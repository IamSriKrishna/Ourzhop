// Package imports:
import 'package:bloc_concurrency/bloc_concurrency.dart' as bc;
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/validation/search_input.dart';
import 'package:customer_app/features/set_location/domain/usecases/set_location_usecase.dart';
import 'package:customer_app/features/set_location/presentation/bloc/set_location_event.dart';
import 'package:customer_app/features/set_location/presentation/bloc/set_location_state.dart';

class SetLocationBloc extends Bloc<SetLocationEvent, SetLocationState> {
  final SetLocationUseCase setLocationUseCase;

  SetLocationBloc({required this.setLocationUseCase})
      : super(const SetLocationInitial()) {
    // Use droppable transformer for async operations to prevent race conditions
    on<SearchSetLocationRequested>(_onSearchLocationRequested,
        transformer: bc.droppable());

    // Immediate state updates (no transformer needed)
    on<SearchInputChanged>(_onSearchInputChanged);
    on<LocationSelected>(_onLocationSelected);
    on<ClearSetLocationEvent>(_onClearSearch);
    on<ShowSearchValidationError>(_onShowSearchValidationError);
    on<HideSearchValidationError>(_onHideSearchValidationError);
  }

  /// Handles search input changes with validation
  void _onSearchInputChanged(
    SearchInputChanged event,
    Emitter<SetLocationState> emit,
  ) {
    final currentState = state;
    if (currentState is SetLocationInitial) {
      final newSearchInput = SearchInput.dirty(event.searchText);

      emit(currentState
          .copyWith(
            searchInput: newSearchInput,
            shouldShowValidationError: false,
          )
          .clearSelectedLocation());
    }
  }

  /// Handles API search requests with proper validation
  Future<void> _onSearchLocationRequested(
    SearchSetLocationRequested event,
    Emitter<SetLocationState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty || query.length < SearchInput.minSearchLength) {
      emit(const SetLocationEmpty());
      return;
    }

    emit(const SetLocationLoading());

    final result = await setLocationUseCase(SetLocationParams(query));

    result.when(
      success: (locations) {
        if (locations.isEmpty) {
          emit(const SetLocationEmpty());
        } else {
          emit(SetLocationSuccess(locations));
        }
      },
      failure: (message) {
        emit(SetLocationError(message.message));
      },
    );
  }

  /// Handles location selection
  void _onLocationSelected(
    LocationSelected event,
    Emitter<SetLocationState> emit,
  ) {
    final currentState = state;
    if (currentState is SetLocationInitial) {
      emit(currentState.copyWith(
        selectedLocation: event.location,
        shouldShowValidationError: false,
      ));
    } else {
      // Create new initial state with selected location
      emit(SetLocationInitial(
        searchInput: SearchInput.dirty(event.location.description),
        selectedLocation: event.location,
        shouldShowValidationError: false,
      ));
    }
  }

  /// Handles clearing search and resetting to initial state
  void _onClearSearch(
    ClearSetLocationEvent event,
    Emitter<SetLocationState> emit,
  ) {
    emit(const SetLocationInitial());
  }

  /// Shows validation errors
  void _onShowSearchValidationError(
    ShowSearchValidationError event,
    Emitter<SetLocationState> emit,
  ) {
    final currentState = state;
    if (currentState is SetLocationInitial) {
      emit(currentState.copyWith(shouldShowValidationError: true));
    }
  }

  /// Hides validation errors
  void _onHideSearchValidationError(
    HideSearchValidationError event,
    Emitter<SetLocationState> emit,
  ) {
    final currentState = state;
    if (currentState is SetLocationInitial) {
      emit(currentState.copyWith(shouldShowValidationError: false));
    }
  }
}

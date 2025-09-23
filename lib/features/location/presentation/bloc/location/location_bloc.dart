
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/location/domain/usecase/location_usercase.dart';
import 'package:customer_app/features/location/presentation/bloc/location/location_event.dart';
import 'package:customer_app/features/location/presentation/bloc/location/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationSearchBloc extends Bloc<LocationSearchEvent, LocationSearchState> {
  final SearchLocationUseCase searchLocationUseCase;

  LocationSearchBloc({required this.searchLocationUseCase}) : super(LocationSearchInitial()) {
    on<SearchLocationEvent>(_onSearchLocation);
    on<ClearLocationSearchEvent>(_onClearSearch);
  }

  Future<void> _onSearchLocation(SearchLocationEvent event, Emitter<LocationSearchState> emit) async {
    if (event.query.trim().isEmpty) {
      emit(LocationSearchEmpty());
      return;
    }

    if (event.query.length < 3) {
      emit(LocationSearchEmpty());
      return;
    }

    emit(LocationSearchLoading());

    final result = await searchLocationUseCase(SearchLocationParams(event.query));

    result.when(
      success: (response) {
        if (response.data.isEmpty) {
          emit(LocationSearchEmpty());
        } else {
          emit(LocationSearchSuccess(response.data));
        }
      },
      failure: (message) {
        emit(LocationSearchError(message.message));
      },
    );
  }

  void _onClearSearch(ClearLocationSearchEvent event, Emitter<LocationSearchState> emit) {
    emit(LocationSearchInitial());
  }
}

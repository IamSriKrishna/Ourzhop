// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:customer_app/common/validation/search_input.dart';
import 'package:customer_app/features/set_location/data/models/set_location_model.dart';

abstract class SetLocationState extends Equatable {
  const SetLocationState();

  @override
  List<Object?> get props => [];
}

class SetLocationInitial extends SetLocationState {
  const SetLocationInitial({
    this.searchInput = const SearchInput.pure(),
    this.shouldShowValidationError = false,
    this.selectedLocation,
  });

  final SearchInput searchInput;
  final bool shouldShowValidationError;
  final SetLocationModel? selectedLocation;

  @override
  List<Object?> get props =>
      [searchInput, shouldShowValidationError, selectedLocation];

  SetLocationInitial copyWith({
    SearchInput? searchInput,
    bool? shouldShowValidationError,
    SetLocationModel? selectedLocation,
  }) {
    return SetLocationInitial(
      searchInput: searchInput ?? this.searchInput,
      shouldShowValidationError:
          shouldShowValidationError ?? this.shouldShowValidationError,
      selectedLocation: selectedLocation ?? this.selectedLocation,
    );
  }

  // Clear selected location
  SetLocationInitial clearSelectedLocation() {
    return copyWith(selectedLocation: null);
  }

  // UI convenience getters
  bool get isValid => searchInput.isValid;
  bool get canSearch => isValid;
  bool get canContinue => selectedLocation != null;
  SearchValidationError? get searchError => searchInput.error;
  String get searchValue => searchInput.value;
  String get trimmedSearchValue => searchInput.value.trim();
}

class SetLocationLoading extends SetLocationState {
  const SetLocationLoading();
}

class SetLocationSuccess extends SetLocationState {
  const SetLocationSuccess(this.locations);

  final List<SetLocationModel> locations;

  @override
  List<Object?> get props => [locations];

  // UI convenience getters
  bool get hasResults => locations.isNotEmpty;
  int get resultCount => locations.length;
}

class SetLocationError extends SetLocationState {
  const SetLocationError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class SetLocationEmpty extends SetLocationState {
  const SetLocationEmpty();
}

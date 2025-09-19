// Package imports:
import 'package:formz/formz.dart';

/// Search input validation errors for set location screen form validation
enum SearchValidationError {
  /// Search field is empty
  empty,

  /// Search query is too short (less than 3 characters)
  tooShort,

  /// Search query is too long (more than 100 characters)
  tooLong,

  /// Search query contains only whitespace
  onlyWhitespace,
}

/// Set location screen search query FormzInput for optimized performance
///
/// This class provides:
/// - Type-safe validation with compile-time error checking
/// - Set location specific validation logic
/// - Industry standard FormZ pattern for UI validation
///
/// Used for real-time search validation without BLoC round-trips
class SearchInput extends FormzInput<String, SearchValidationError> {
  /// Creates a pure (unmodified) search input
  const SearchInput.pure() : super.pure('');

  /// Creates a dirty (user-modified) search input with validation
  const SearchInput.dirty([super.value = '']) : super.dirty();

  /// Minimum characters required for search
  static const int minSearchLength = 3;

  /// Maximum characters allowed for search
  static const int maxSearchLength = 100;

  @override
  SearchValidationError? validator(String value) {
    if (value.isEmpty) {
      return SearchValidationError.empty;
    }

    if (value.trim().isEmpty) {
      return SearchValidationError.onlyWhitespace;
    }

    if (value.length < minSearchLength) {
      return SearchValidationError.tooShort;
    }

    if (value.length > maxSearchLength) {
      return SearchValidationError.tooLong;
    }

    // All validation passed
    return null;
  }
}

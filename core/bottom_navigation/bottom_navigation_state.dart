// Ensure this part statement correctly points to your Cubit file.
part of 'bottom_navigation_cubit.dart';

/// Represents the state of the bottom navigation bar.
class BottomNavigationState extends Equatable {
  /// The current item selected in the bottom navigation.
  final String bottomNavItem;

  /// The index of the selected item.
  final int index;

  /// Constructs a [BottomNavigationState].
  const BottomNavigationState(
      {required this.bottomNavItem, required this.index});

  @override
  List<Object> get props => [bottomNavItem, index];
}

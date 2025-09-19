// Flutter imports:
import 'package:flutter/widgets.dart';

/// A custom navigation bar item with named route support.
///
/// [initialLocation] specifies the initial route or location this item represents.
class AppNamedNavigationBarItem extends BottomNavigationBarItem {
  /// The initial route or location that the navigation bar item represents.
  final String initialLocation;

  /// Creates an [AppNamedNavigationBarItem].
  ///
  /// Requires [initialLocation] to specify the initial route or location,
  /// and an [icon] to represent the item visually.
  /// An optional [label] can be provided for textual representation.
  AppNamedNavigationBarItem({
    required this.initialLocation,
    required super.icon,
    super.label,
  });
}

/// Legacy widget for backward compatibility
@Deprecated('Use AppNamedNavigationBarItem instead')
class NamedNavigationBarItemWidget extends AppNamedNavigationBarItem {
  NamedNavigationBarItemWidget({
    required super.initialLocation,
    required super.icon,
    super.label,
  });
}

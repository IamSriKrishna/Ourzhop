// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/features/home/presentation/screens/home_content_wrapper.dart';
import 'package:customer_app/features/home/presentation/widgets/home_bottom_navigation.dart';

/// Legacy HomeScreen - kept for backward compatibility
/// This widget wraps HomeContentWrapper with its own scaffold and bottom navigation
/// Note: In the new architecture, use HomeContentWrapper directly with MainShell
@Deprecated('Use HomeContentWrapper with MainShell instead')
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeContentWrapper(),
      floatingActionButton: const HomeBottomNavigation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

import 'package:customer_app/common/dialog/permission_dialog.dart';
import 'package:customer_app/features/location/presentation/bloc/location_selector_cubit.dart';
import 'package:customer_app/features/location/presentation/widgets/loading_overlay.dart';
import 'package:customer_app/features/location/presentation/widgets/location_navigation_handler.dart';
import 'package:customer_app/features/location/presentation/widgets/location_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/features/location/presentation/bloc/location/location_bloc.dart';
import 'package:customer_app/service_locator.dart';

class LocationSelectionScreen extends StatelessWidget {
  const LocationSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocationSelectionCubit()),
        BlocProvider.value(value: serviceLocator<LocationSearchBloc>()),
      ],
      child: const LocationSelectionView(),
    );
  }
}

class LocationSelectionView extends StatelessWidget {
  const LocationSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          await LocationNavigationHandler.handleBackNavigation(context);
        }
      },
      child: BlocListener<LocationSelectionCubit, LocationSelectionState>(
        listener: (context, state) {
          if (state is LocationSelectionPermissionDenied) {
            PermissionDialog.show(context);
          }
        },
        child: Stack(
          children: [
            LocationScaffold(
              onContinue: () =>
                  LocationNavigationHandler.handleContinue(context),
            ),
            const LoadingOverlay(),
          ],
        ),
      ),
    );
  }
}

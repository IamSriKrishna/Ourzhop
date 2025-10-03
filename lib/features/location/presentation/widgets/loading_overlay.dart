import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/common/dialog/progress_dialog.dart';
import 'package:customer_app/features/location/presentation/bloc/location_selector_cubit.dart';

class LoadingOverlay extends StatelessWidget {
  final String loadingMessage;

  const LoadingOverlay({
    super.key,
    this.loadingMessage = "Getting your location...",
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationSelectionCubit, LocationSelectionState>(
      builder: (context, state) {
        if (state is LocationSelectionLoading) {
          return ProgressDialog(
            title: loadingMessage,
            isProgressed: true,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

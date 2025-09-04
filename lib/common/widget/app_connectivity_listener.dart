// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Project imports:
import 'package:customer_app/core/bloc/connectivity/connectivity_bloc.dart';
import 'package:customer_app/core/themes/app_colors.dart';

class AppConnectivityListener extends StatelessWidget {
  final Widget child;

  const AppConnectivityListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        _showConnectivityStatusToast(context, state);
      },
      child: child,
    );
  }

  void _showConnectivityStatusToast(
      BuildContext context, ConnectivityState state) {
    final brandColors = context.appColors;

    Fluttertoast.showToast(
      msg: state == ConnectivityState.connected
          ? 'Connected to the Internet'
          : 'No Internet Connection',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: state == ConnectivityState.connected
          ? brandColors.success
          : brandColors.error,
      textColor: state == ConnectivityState.connected
          ? brandColors.onSuccess
          : brandColors.onError,
      fontSize: 16.0,
    );
  }
}

/// Legacy widget for backward compatibility
@Deprecated('Use AppConnectivityListener instead')
class ConnectivityStatusListener extends AppConnectivityListener {
  const ConnectivityStatusListener({super.key, required super.child});
}

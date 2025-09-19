// Dart imports:
import 'dart:async';

// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/core/utils/app_logger.dart';

// Project imports:

enum ConnectivityState { connected, disconnected }

class ConnectivityBloc extends Bloc<ConnectivityState, ConnectivityState> {
  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  late bool _hasCheckedInitialConnectivity = false;
  final AppLogger _logger = AppLogger();

  ConnectivityBloc(this._connectivity) : super(ConnectivityState.disconnected) {
    on<ConnectivityState>((event, emit) => emit(event));
    _initialize();
  }
  // Initialization: Sets up the connectivity change listener and performs the initial connectivity check.
  // The listener will trigger and indicate internet availability when the app is opened with internet,
  // but it won't trigger when there's no internet. This behavior influences how we handle the initial app state.
  void _initialize() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> result) => _handleConnectivityChange(result),
      onError: _handleError, // Error handling for the stream
      onDone: _onDone,
    );
    // Perform the initial connectivity check to handle the case of opening the app without internet.
    _checkInitialConnectivity();
  }

// Check the initial connectivity. If there's no internet connection, handle this state accordingly.
  // This is to ensure that we show a 'no internet' state when the app opens without internet.
  Future<void> _checkInitialConnectivity() async {
    try {
      final currentResult = await _connectivity.checkConnectivity().timeout(
        const Duration(seconds: 2), // Set an appropriate timeout duration
        onTimeout: () {
          // Handle the timeout case
          _logger.warning('ConnectivityBloc: Connectivity check timed out');
          return [ConnectivityResult.none]; // Return a default value
        },
      );

      bool isConnected = _isInternetConnection(currentResult);
      if (!isConnected) {
        _handleConnectivityChange(currentResult);
      }
    } catch (e) {
      _logger.error(
          'ConnectivityBloc: Error during initial connectivity check: ${e.toString()}');
      // You might want to handle the error state or emit a specific state
    }
  }

  // Handles connectivity changes. On the initial app launch, we avoid emitting the 'connected' state
  // to enhance user experience, as the listener triggers with internet but not without it.
  // Subsequent connectivity changes (connected/disconnected) are handled normally.
  void _handleConnectivityChange(List<ConnectivityResult> result) {
    bool isConnected = _isInternetConnection(result);
    _logger.info(
        'ConnectivityBloc: Connectivity Change: ${isConnected ? "Connected" : "Disconnected"}');
    if (_hasCheckedInitialConnectivity || !isConnected) {
      add(isConnected
          ? ConnectivityState.connected
          : ConnectivityState.disconnected);
    }

    _hasCheckedInitialConnectivity = true;
  }

  // Utility to check if the result indicates an internet connection.
  bool _isInternetConnection(List<ConnectivityResult> results) {
    return results.any((result) =>
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.vpn);
  }

// Error handling for the connectivity stream.
  void _handleError(Object error) {
    _logger.error('ConnectivityBloc: Error in connectivity stream: $error');
  }

// Handler for when the connectivity stream is closed.
  void _onDone() {
    _logger.info('ConnectivityBloc: Connectivity stream closed');
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}

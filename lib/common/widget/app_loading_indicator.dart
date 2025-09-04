// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';

enum AppLoadingIndicatorType { wave, circle }

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.type = AppLoadingIndicatorType.wave,
  });

  final AppLoadingIndicatorType type;

  @override
  Widget build(BuildContext context) {
    final brandColors = context.appColors;

    Widget widget;
    switch (type) {
      case AppLoadingIndicatorType.wave:
        widget = SpinKitWave(color: brandColors.primary, size: 50.0);
        break;
      case AppLoadingIndicatorType.circle:
        widget = SpinKitFadingCircle(
          color: brandColors.primary,
          size: 50.0,
        );
    }
    return Center(child: widget);
  }
}

/// Legacy types for backward compatibility
@Deprecated('Use AppLoadingIndicatorType instead')
typedef SpinKitType = AppLoadingIndicatorType;

/// Legacy widget for backward compatibility
@Deprecated('Use AppLoadingIndicator instead')
class SpinKitIndicator extends AppLoadingIndicator {
  const SpinKitIndicator({
    super.key,
    super.type = SpinKitType.wave,
  });
}

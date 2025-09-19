// Flutter imports:
import 'package:flutter/material.dart';

/// Enterprise Brand Colors Configuration
///
/// This is the single source of truth for all brand colors in the application.
/// Changing colors here will update the entire app's branding.
///
/// Brand Identity: E-Commerce Seller Platform (Ourzhop Design System)
/// Primary Brand: Purple (#8A38F5) - Innovation, Premium, Digital
/// Secondary: Dark Gray (#17181A) - Professional, Modern
class AppColors {
  const AppColors._();

  // ========================================
  // CORE BRAND COLORS - Primary Identity (Design System)
  // ========================================

  /// Primary brand color - Main brand identity (from design system)
  /// Used for: Primary buttons, key CTAs, brand elements
  static const Color primaryPurple = Color.fromRGBO(138, 56, 245, 1);

  /// Primary variant - Darker shade for interactions
  static const Color primaryPurpleDark = Color.fromRGBO(138, 56, 245, 1);

  /// Primary variant - Lighter shade for backgrounds
  static const Color primaryPurpleLight = Color(0xFFD1AEFF);

  /// Primary variant - Very light for subtle backgrounds
  static const Color primaryPurpleVeryLight = Color(0xFFEAD9FF);

  /// Secondary brand color - Supporting brand element (from design system)
  /// Used for: Text, accents, secondary elements
  static const Color darkGray = Color(0xFF17181A);

  /// Secondary variant - Medium gray for secondary text
  static const Color mediumGray = Color(0xFF61656A);

  /// Secondary variant - Light gray for outlines and borders
  static const Color lightGray = Color(0xFFD8D8D8);

  /// OTP field border color from design system (#CFD1D3)
  static const Color otpBorderGray = Color(0xFFCFD1D3);

  // ========================================
  // GRADIENT BACKGROUNDS (Design System)
  // ========================================

  /// Primary gradient from design system
  /// Used for: Background gradients, hero sections
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.35],
    colors: [
      primaryPurpleLight, // #D1AEFF
      white, // #FFFFFF
    ],
  );

  /// Secondary gradient for cards and containers
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryPurpleVeryLight, // #EAD9FF
      white, // #FFFFFF
    ],
  );

  /// Legacy colors for backward compatibility
  @Deprecated('Use primaryPurple instead')
  static const Color emeraldGreen = primaryPurple;
  @Deprecated('Use primaryPurpleDark instead')
  static const Color emeraldGreenDark = primaryPurpleDark;
  @Deprecated('Use primaryPurpleLight instead')
  static const Color emeraldGreenLight = primaryPurpleLight;
  @Deprecated('Use darkGray instead')
  static const Color charcoal = darkGray;
  @Deprecated('Use mediumGray instead')
  static const Color charcoalLight = mediumGray;
  @Deprecated('Use darkGray instead')
  static const Color charcoalDark = darkGray;

  // ========================================
  // SEMANTIC COLORS - Functional Colors
  // ========================================

  /// Success color for positive feedback
  static const Color success = Color(0xFF22C55E);

  /// Success variant - Lighter for backgrounds
  static const Color successLight = Color(0xFFDCFCE7);

  /// Warning color for caution states
  static const Color warning = Color(0xFFF59E0B);

  /// Warning variant - Lighter for backgrounds
  static const Color warningLight = Color(0xFFFEF3C7);

  /// Error color for negative feedback
  static const Color error = Color(0xFFEF4444);

  /// Error variant - Lighter for backgrounds
  static const Color errorLight = Color(0xFFFEE2E2);

  /// Info color for informational content
  static const Color info = Color(0xFF3B82F6);

  /// Info variant - Lighter for backgrounds
  static const Color infoLight = Color(0xFFDBEAFE);

  // ========================================
  // NEUTRAL COLORS - Grayscale Palette
  // ========================================

  /// Pure white - Absolute white
  static const Color white = Color(0xFFFFFFFF);

  /// Pure black - Absolute black
  static const Color black = Color(0xFF000000);

  /// Neutral colors - Comprehensive grayscale
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral400 = Color(0xFFA3A3A3);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral900 = Color(0xFF171717);
  static const Color neutral950 = Color(0xFF0A0A0A);

  // ========================================
  // THEME-SPECIFIC BRAND APPLICATIONS
  // ========================================

  /// Light theme brand colors
  static const LightThemeBrandColors light = LightThemeBrandColors._();

  /// Dark theme brand colors
  static const DarkThemeBrandColors dark = DarkThemeBrandColors._();
}

/// Light Theme Brand Color Applications
class LightThemeBrandColors {
  const LightThemeBrandColors._();

  // Surface colors
  Color get background => AppColors.white;
  Color get surface => AppColors.neutral50;
  Color get surfaceVariant => AppColors.neutral100;

  // Primary brand applications (Enterprise design system)
  Color get primary => AppColors.primaryPurple;
  Color get primaryContainer => AppColors.primaryPurpleLight;
  Color get onPrimary => AppColors.white;
  Color get onPrimaryContainer => AppColors.primaryPurpleDark;

  // Secondary brand applications (Enterprise design system)
  Color get secondary => AppColors.darkGray;
  Color get secondaryContainer => AppColors.neutral100;
  Color get onSecondary => AppColors.white;
  Color get onSecondaryContainer => AppColors.darkGray;

  // Text colors (Enterprise design system)
  Color get onBackground => AppColors.darkGray;
  Color get onSurface => AppColors.darkGray;
  Color get onSurfaceVariant => AppColors.mediumGray;

  // Border and outline colors (Enterprise design system)
  Color get outline => AppColors.lightGray;
  Color get outlineVariant => AppColors.neutral200;

  // Semantic colors
  Color get success => AppColors.success;
  Color get onSuccess => AppColors.white;
  Color get successContainer => AppColors.successLight;
  Color get onSuccessContainer => AppColors.success;

  Color get warning => AppColors.warning;
  Color get onWarning => AppColors.white;
  Color get warningContainer => AppColors.warningLight;
  Color get onWarningContainer => AppColors.warning;

  Color get error => AppColors.error;
  Color get onError => AppColors.white;
  Color get errorContainer => AppColors.errorLight;
  Color get onErrorContainer => AppColors.error;

  Color get info => AppColors.info;
  Color get onInfo => AppColors.white;
  Color get infoContainer => AppColors.infoLight;
  Color get onInfoContainer => AppColors.info;

  // Special application colors (Enterprise design system)
  Color get otpBackground => AppColors.primaryPurpleLight;
  Color get otpBackgroundSecondary => AppColors.primaryPurpleVeryLight;

  // Gradient backgrounds
  LinearGradient get backgroundGradient => AppColors.primaryGradient;
  LinearGradient get cardGradient => AppColors.secondaryGradient;
}

/// Dark Theme Brand Color Applications
class DarkThemeBrandColors {
  const DarkThemeBrandColors._();

  // Surface colors
  Color get background => AppColors.black;
  Color get surface => AppColors.neutral900;
  Color get surfaceVariant => AppColors.neutral800;

  // Primary brand applications (Enterprise design system)
  Color get primary => AppColors.primaryPurpleLight;
  Color get primaryContainer => AppColors.primaryPurpleDark;
  Color get onPrimary => AppColors.black;
  Color get onPrimaryContainer => AppColors.primaryPurpleLight;

  // Secondary brand applications
  Color get secondary => AppColors.neutral300;
  Color get secondaryContainer => AppColors.neutral700;
  Color get onSecondary => AppColors.black;
  Color get onSecondaryContainer => AppColors.neutral300;

  // Text colors
  Color get onBackground => AppColors.white;
  Color get onSurface => AppColors.white;
  Color get onSurfaceVariant => AppColors.neutral400;

  // Border and outline colors
  Color get outline => AppColors.neutral600;
  Color get outlineVariant => AppColors.neutral700;

  // Semantic colors
  Color get success => AppColors.success;
  Color get onSuccess => AppColors.white;
  Color get successContainer => Color(0xFF15803D);
  Color get onSuccessContainer => AppColors.success;

  Color get warning => AppColors.warning;
  Color get onWarning => AppColors.black;
  Color get warningContainer => Color(0xFFD97706);
  Color get onWarningContainer => AppColors.warning;

  Color get error => AppColors.error;
  Color get onError => AppColors.white;
  Color get errorContainer => Color(0xFFDC2626);
  Color get onErrorContainer => AppColors.error;

  Color get info => AppColors.info;
  Color get onInfo => AppColors.white;
  Color get infoContainer => Color(0xFF2563EB);
  Color get onInfoContainer => AppColors.info;

  // Special application colors (Enterprise design system)
  Color get otpBackground =>
      AppColors.primaryPurpleLight.withValues(alpha: 0.3);
  Color get otpBackgroundSecondary =>
      AppColors.primaryPurpleVeryLight.withValues(alpha: 0.5);

  // Gradient backgrounds (darker theme)
  LinearGradient get backgroundGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF2A1A4A), // Darker purple
          Color(0xFF1A1A1A), // Dark gray
        ],
      );
  LinearGradient get cardGradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF3A2A5A), // Darker purple variant
          Color(0xFF2A2A2A), // Dark surface
        ],
      );
}

/// Extension for easy access to brand colors from BuildContext
extension BrandColorsExtension on BuildContext {
  /// Get current theme app colors
  AppColorScheme get appColors {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.light
        ? AppColors.light.toAppColorScheme()
        : AppColors.dark.toAppColorScheme();
  }
}

/// App Color Scheme for consistent usage
class AppColorScheme {
  const AppColorScheme({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.primary,
    required this.primaryContainer,
    required this.onPrimary,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.secondaryContainer,
    required this.onSecondary,
    required this.onSecondaryContainer,
    required this.onBackground,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
    required this.otpBackground,
    required this.otpBackgroundSecondary,
    required this.backgroundGradient,
    required this.cardGradient,
  });

  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color primary;
  final Color primaryContainer;
  final Color onPrimary;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color secondaryContainer;
  final Color onSecondary;
  final Color onSecondaryContainer;
  final Color onBackground;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color info;
  final Color onInfo;
  final Color infoContainer;
  final Color onInfoContainer;
  final Color otpBackground;
  final Color otpBackgroundSecondary;
  final LinearGradient backgroundGradient;
  final LinearGradient cardGradient;
}

/// Extension methods for converting theme brand colors to AppColorScheme
extension LightThemeAppColorsExtension on LightThemeBrandColors {
  AppColorScheme toAppColorScheme() => AppColorScheme(
        background: background,
        surface: surface,
        surfaceVariant: surfaceVariant,
        primary: primary,
        primaryContainer: primaryContainer,
        onPrimary: onPrimary,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        secondaryContainer: secondaryContainer,
        onSecondary: onSecondary,
        onSecondaryContainer: onSecondaryContainer,
        onBackground: onBackground,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        success: success,
        onSuccess: onSuccess,
        successContainer: successContainer,
        onSuccessContainer: onSuccessContainer,
        warning: warning,
        onWarning: onWarning,
        warningContainer: warningContainer,
        onWarningContainer: onWarningContainer,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        info: info,
        onInfo: onInfo,
        infoContainer: infoContainer,
        onInfoContainer: onInfoContainer,
        otpBackground: otpBackground,
        otpBackgroundSecondary: otpBackgroundSecondary,
        backgroundGradient: backgroundGradient,
        cardGradient: cardGradient,
      );
}

extension DarkThemeAppColorsExtension on DarkThemeBrandColors {
  AppColorScheme toAppColorScheme() => AppColorScheme(
        background: background,
        surface: surface,
        surfaceVariant: surfaceVariant,
        primary: primary,
        primaryContainer: primaryContainer,
        onPrimary: onPrimary,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        secondaryContainer: secondaryContainer,
        onSecondary: onSecondary,
        onSecondaryContainer: onSecondaryContainer,
        onBackground: onBackground,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        success: success,
        onSuccess: onSuccess,
        successContainer: successContainer,
        onSuccessContainer: onSuccessContainer,
        warning: warning,
        onWarning: onWarning,
        warningContainer: warningContainer,
        onWarningContainer: onWarningContainer,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        info: info,
        onInfo: onInfo,
        infoContainer: infoContainer,
        onInfoContainer: onInfoContainer,
        otpBackground: otpBackground,
        otpBackgroundSecondary: otpBackgroundSecondary,
        backgroundGradient: backgroundGradient,
        cardGradient: cardGradient,
      );
}

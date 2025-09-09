// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:pinput/pinput.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';

enum AppTheme { darkTheme, lightTheme }

/// Custom theme extensions for app-specific colors
@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.appColors,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
    required this.otpBackground,
    required this.otpBackgroundSecondary,
  });

  final AppColorScheme appColors;
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color info;
  final Color onInfo;
  final Color infoContainer;
  final Color onInfoContainer;
  final Color otpBackground;
  final Color otpBackgroundSecondary;

  @override
  AppThemeExtension copyWith({
    AppColorScheme? appColors,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? info,
    Color? onInfo,
    Color? infoContainer,
    Color? onInfoContainer,
    Color? otpBackground,
    Color? otpBackgroundSecondary,
  }) {
    return AppThemeExtension(
      appColors: appColors ?? this.appColors,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      infoContainer: infoContainer ?? this.infoContainer,
      onInfoContainer: onInfoContainer ?? this.onInfoContainer,
      otpBackground: otpBackground ?? this.otpBackground,
      otpBackgroundSecondary:
          otpBackgroundSecondary ?? this.otpBackgroundSecondary,
    );
  }

  @override
  AppThemeExtension lerp(AppThemeExtension? other, double t) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      appColors: appColors,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      successContainer:
          Color.lerp(successContainer, other.successContainer, t)!,
      onSuccessContainer:
          Color.lerp(onSuccessContainer, other.onSuccessContainer, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      warningContainer:
          Color.lerp(warningContainer, other.warningContainer, t)!,
      onWarningContainer:
          Color.lerp(onWarningContainer, other.onWarningContainer, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      onInfoContainer: Color.lerp(onInfoContainer, other.onInfoContainer, t)!,
      otpBackground: Color.lerp(otpBackground, other.otpBackground, t)!,
      otpBackgroundSecondary:
          Color.lerp(otpBackgroundSecondary, other.otpBackgroundSecondary, t)!,
    );
  }
}

class AppThemes {
  const AppThemes._();

  /// Light theme app extension
  static AppThemeExtension get _lightAppExtension => AppThemeExtension(
        appColors: AppColors.light.toAppColorScheme(),
        success: AppColors.light.success,
        onSuccess: AppColors.light.onSuccess,
        successContainer: AppColors.light.successContainer,
        onSuccessContainer: AppColors.light.onSuccessContainer,
        warning: AppColors.light.warning,
        onWarning: AppColors.light.onWarning,
        warningContainer: AppColors.light.warningContainer,
        onWarningContainer: AppColors.light.onWarningContainer,
        info: AppColors.light.info,
        onInfo: AppColors.light.onInfo,
        infoContainer: AppColors.light.infoContainer,
        onInfoContainer: AppColors.light.onInfoContainer,
        otpBackground: AppColors.light.otpBackground,
        otpBackgroundSecondary: AppColors.light.otpBackgroundSecondary,
      );

  /// Dark theme app extension
  static AppThemeExtension get _darkAppExtension => AppThemeExtension(
        appColors: AppColors.dark.toAppColorScheme(),
        success: AppColors.dark.success,
        onSuccess: AppColors.dark.onSuccess,
        successContainer: AppColors.dark.successContainer,
        onSuccessContainer: AppColors.dark.onSuccessContainer,
        warning: AppColors.dark.warning,
        onWarning: AppColors.dark.onWarning,
        warningContainer: AppColors.dark.warningContainer,
        onWarningContainer: AppColors.dark.onWarningContainer,
        info: AppColors.dark.info,
        onInfo: AppColors.dark.onInfo,
        infoContainer: AppColors.dark.infoContainer,
        onInfoContainer: AppColors.dark.onInfoContainer,
        otpBackground: AppColors.dark.otpBackground,
        otpBackgroundSecondary: AppColors.dark.otpBackgroundSecondary,
      );

  /// Material 3 Color Scheme for Light Theme
  static ColorScheme get _lightColorScheme => ColorScheme.light(
        brightness: Brightness.light,
        primary: AppColors.light.primary,
        onPrimary: AppColors.light.onPrimary,
        primaryContainer: AppColors.light.primaryContainer,
        onPrimaryContainer: AppColors.light.onPrimaryContainer,
        secondary: AppColors.light.secondary,
        onSecondary: AppColors.light.onSecondary,
        secondaryContainer: AppColors.light.secondaryContainer,
        onSecondaryContainer: AppColors.light.onSecondaryContainer,
        tertiary: AppColors.primaryPurpleDark,
        onTertiary: AppColors.white,
        tertiaryContainer: AppColors.primaryPurpleLight,
        onTertiaryContainer: AppColors.primaryPurpleDark,
        error: AppColors.light.error,
        onError: AppColors.light.onError,
        errorContainer: AppColors.light.errorContainer,
        onErrorContainer: AppColors.light.onErrorContainer,
        surface: AppColors.light.surface,
        onSurface: AppColors.light.onSurface,
        surfaceContainerHighest: AppColors.light.surfaceVariant,
        onSurfaceVariant: AppColors.light.onSurfaceVariant,
        outline: AppColors.light.outline,
        outlineVariant: AppColors.light.outlineVariant,
      );

  /// Material 3 Color Scheme for Dark Theme
  static ColorScheme get _darkColorScheme => ColorScheme.dark(
        brightness: Brightness.dark,
        primary: AppColors.dark.primary,
        onPrimary: AppColors.dark.onPrimary,
        primaryContainer: AppColors.dark.primaryContainer,
        onPrimaryContainer: AppColors.dark.onPrimaryContainer,
        secondary: AppColors.dark.secondary,
        onSecondary: AppColors.dark.onSecondary,
        secondaryContainer: AppColors.dark.secondaryContainer,
        onSecondaryContainer: AppColors.dark.onSecondaryContainer,
        tertiary: AppColors.primaryPurpleLight,
        onTertiary: AppColors.darkGray,
        tertiaryContainer: AppColors.primaryPurpleDark,
        onTertiaryContainer: AppColors.primaryPurpleLight,
        error: AppColors.dark.error,
        onError: AppColors.dark.onError,
        errorContainer: AppColors.dark.errorContainer,
        onErrorContainer: AppColors.dark.onErrorContainer,
        surface: AppColors.dark.surface,
        onSurface: AppColors.dark.onSurface,
        surfaceContainerHighest: AppColors.dark.surfaceVariant,
        onSurfaceVariant: AppColors.dark.onSurfaceVariant,
        outline: AppColors.dark.outline,
        outlineVariant: AppColors.dark.outlineVariant,
      );

  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      extensions: <ThemeExtension<dynamic>>[_lightAppExtension],

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.light.surface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: h2Style.copyWith(color: AppColors.light.onSurface),
        toolbarTextStyle: h2Style.copyWith(color: AppColors.light.onSurface),
        iconTheme: IconThemeData(color: AppColors.light.onSurfaceVariant),
        actionsIconTheme:
            IconThemeData(color: AppColors.light.onSurfaceVariant),
      ),

      // Button Themes (Enterprise Design System)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.light.primary,
          foregroundColor: AppColors.light.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                AppDesignTokens.borderRadiusLarge), // 50px from design system
          ),
          textStyle: h2Style, // 18px, 600 weight from design system
          elevation: 0, // Flat design from design system
          padding: const EdgeInsets.symmetric(
            vertical: AppDesignTokens.spacingMd, // 17px from design system
            horizontal: 32,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.light.primary,
          side: BorderSide(color: AppColors.light.outline),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppDesignTokens.borderRadiusLarge),
          ),
          textStyle: h2Style, // Updated to match design system
          padding: const EdgeInsets.symmetric(
            vertical: AppDesignTokens.spacingMd,
            horizontal: 32,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.light.primary,
          textStyle: h2Style, // Updated to match design system
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppDesignTokens.borderRadiusSmall),
          ),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.light.primary,
        foregroundColor: AppColors.light.onPrimary,
        elevation: 6,
        focusElevation: 8,
        hoverElevation: 8,
        highlightElevation: 12,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: textFieldStyle,
        enabledBorder: textFieldStyle.copyWith(
          
          borderSide: BorderSide(color: AppColors.light.outline),
        ),
        focusedBorder: textFieldStyle.copyWith(
          borderSide: BorderSide(color: AppColors.light.primary, width: 2),
        ),
        errorBorder: textFieldStyle.copyWith(
          borderSide: BorderSide(color: AppColors.light.error),
        ),
        focusedErrorBorder: textFieldStyle.copyWith(
          borderSide: BorderSide(color: AppColors.light.error, width: 2),
        ),
        filled: true,
        fillColor: AppColors.light.surface,
        contentPadding: const EdgeInsets.all(20),
        hintStyle: TextStyle(color: AppColors.light.onSurfaceVariant),
        labelStyle: TextStyle(color: AppColors.light.onSurfaceVariant),
        floatingLabelStyle: TextStyle(color: AppColors.light.primary),
      ),

      // Navigation Themes
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.light.surface,
        selectedItemColor: AppColors.light.primary,
        unselectedItemColor: AppColors.light.onSurfaceVariant,
        elevation: 8,
        selectedLabelStyle: subtitleLight.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: subtitleLight,
      ),

      // Menu and Dialog Themes
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.light.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        textStyle: bodyTextLight.copyWith(color: AppColors.light.onSurface),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.light.surface,
        surfaceTintColor: AppColors.light.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 24,
        titleTextStyle: h3Style.copyWith(color: AppColors.light.onSurface),
        contentTextStyle:
            bodyTextLight.copyWith(color: AppColors.light.onSurfaceVariant),
      ),

      // Card Theme (Enterprise Design System)
      cardTheme: CardThemeData(
        color: AppColors.light.surface,
        surfaceTintColor: AppColors.light.primary,
        shadowColor:
            AppColors.light.outline.withValues(alpha: 0.1), // Subtle shadow
        elevation: 2, // Reduced elevation for flat design
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AppDesignTokens.borderRadiusMedium), // 17px from design system
        ),
        margin: EdgeInsets.symmetric(
          horizontal: AppDesignTokens.spacingLg,
          vertical: AppDesignTokens.spacingXs,
        ),
      ),

      // Chip Theme (Enterprise Design System)
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.light.surfaceVariant,
        labelStyle:
            subtitleLight.copyWith(color: AppColors.light.onSurfaceVariant),
        secondaryLabelStyle:
            subtitleLight.copyWith(color: AppColors.light.onPrimary),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDesignTokens.borderRadiusSmall),
        ),
        selectedColor: AppColors.light.primary,
        secondarySelectedColor: AppColors.light.secondary,
        showCheckmark: true,
        checkmarkColor: AppColors.light.onPrimary,
        deleteIconColor: AppColors.light.onSurfaceVariant,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: h1Style.copyWith(color: AppColors.light.onSurface),
        displayMedium: h2Style.copyWith(color: AppColors.light.onSurface),
        displaySmall: h3Style.copyWith(color: AppColors.light.onSurface),
        headlineMedium: h4StyleLight.copyWith(color: AppColors.light.onSurface),
        headlineSmall: h5StyleLight.copyWith(color: AppColors.light.onSurface),
        bodyLarge: bodyTextLight.copyWith(color: AppColors.light.onSurface),
        bodyMedium:
            bodyTextLight.copyWith(color: AppColors.light.onSurfaceVariant),
        titleMedium: subtitleLight.copyWith(color: AppColors.light.onSurface),
        labelLarge: h4StyleLight.copyWith(color: AppColors.light.primary),
        headlineLarge: headlineLarge.copyWith(color: AppColors.light.onSurface),
      ),

      // Icon Theme
      iconTheme: IconThemeData(color: AppColors.light.onSurfaceVariant),
      primaryIconTheme: IconThemeData(color: AppColors.light.primary),

      // Other Themes
      bottomAppBarTheme: BottomAppBarThemeData(
        color: AppColors.light.surface,
        elevation: 8,
        shape: const CircularNotchedRectangle(),
      ),

      dividerTheme: DividerThemeData(
        color: AppColors.light.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.light.primary,
        linearTrackColor: AppColors.light.surfaceVariant,
        circularTrackColor: AppColors.light.surfaceVariant,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.light.primary;
          }
          return AppColors.light.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.light.primary.withValues(alpha: 0.5);
          }
          return AppColors.light.surfaceVariant;
        }),
      ),
    ),
    AppTheme.darkTheme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      extensions: <ThemeExtension<dynamic>>[_darkAppExtension],

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.dark.surface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: h2Style.copyWith(color: AppColors.dark.onSurface),
        toolbarTextStyle: h2Style.copyWith(color: AppColors.dark.onSurface),
        iconTheme: IconThemeData(color: AppColors.dark.onSurfaceVariant),
        actionsIconTheme: IconThemeData(color: AppColors.dark.onSurfaceVariant),
      ),

      // Button Themes (Enterprise Design System)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.dark.primary,
          foregroundColor: AppColors.dark.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppDesignTokens.borderRadiusLarge),
          ),
          textStyle: h2Style, // Updated to match design system
          elevation: 0, // Flat design
          padding: const EdgeInsets.symmetric(
            vertical: AppDesignTokens.spacingMd,
            horizontal: 32,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.dark.primary,
          side: BorderSide(color: AppColors.dark.outline),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppDesignTokens.borderRadiusLarge),
          ),
          textStyle: h2Style, // Updated to match design system
          padding: const EdgeInsets.symmetric(
            vertical: AppDesignTokens.spacingMd,
            horizontal: 32,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.dark.primary,
          textStyle: h2Style, // Updated to match design system
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppDesignTokens.borderRadiusSmall),
          ),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.dark.primary,
        foregroundColor: AppColors.dark.onPrimary,
        elevation: 6,
        focusElevation: 8,
        hoverElevation: 8,
        highlightElevation: 12,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: textFieldStyle,
        enabledBorder: textFieldStyle.copyWith(
          borderSide: BorderSide(color: AppColors.dark.outline),
        ),
        focusedBorder: textFieldStyle.copyWith(
          borderSide: BorderSide(color: AppColors.dark.primary, width: 2),
        ),
        errorBorder: textFieldStyle.copyWith(
          borderSide: BorderSide(color: AppColors.dark.error),
        ),
        focusedErrorBorder: textFieldStyle.copyWith(
          borderSide: BorderSide(color: AppColors.dark.error, width: 2),
        ),
        filled: true,
        fillColor: AppColors.dark.surface,
        contentPadding: const EdgeInsets.all(20),
        hintStyle: TextStyle(color: AppColors.dark.onSurfaceVariant),
        labelStyle: TextStyle(color: AppColors.dark.onSurfaceVariant),
        floatingLabelStyle: TextStyle(color: AppColors.dark.primary),
      ),

      // Navigation Themes
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.dark.surface,
        selectedItemColor: AppColors.dark.primary,
        unselectedItemColor: AppColors.dark.onSurfaceVariant,
        elevation: 8,
        selectedLabelStyle: subtitleLight.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: subtitleLight,
      ),

      // Menu and Dialog Themes
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.dark.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        textStyle: bodyTextLight.copyWith(color: AppColors.dark.onSurface),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.dark.surface,
        surfaceTintColor: AppColors.dark.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 24,
        titleTextStyle: h3Style.copyWith(color: AppColors.dark.onSurface),
        contentTextStyle:
            bodyTextLight.copyWith(color: AppColors.dark.onSurfaceVariant),
      ),

      // Card Theme (Enterprise Design System)
      cardTheme: CardThemeData(
        color: AppColors.dark.surface,
        surfaceTintColor: AppColors.dark.primary,
        shadowColor: AppColors.black.withValues(alpha: 0.2), // Reduced shadow
        elevation: 2, // Reduced elevation
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDesignTokens.borderRadiusMedium),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: AppDesignTokens.spacingLg,
          vertical: AppDesignTokens.spacingXs,
        ),
      ),

      // Chip Theme (Enterprise Design System)
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.dark.surfaceVariant,
        labelStyle:
            subtitleLight.copyWith(color: AppColors.dark.onSurfaceVariant),
        secondaryLabelStyle:
            subtitleLight.copyWith(color: AppColors.dark.onPrimary),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDesignTokens.borderRadiusSmall),
        ),
        selectedColor: AppColors.dark.primary,
        secondarySelectedColor: AppColors.dark.secondary,
        showCheckmark: true,
        checkmarkColor: AppColors.dark.onPrimary,
        deleteIconColor: AppColors.dark.onSurfaceVariant,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: h1Style.copyWith(color: AppColors.dark.onSurface),
        displayMedium: h2Style.copyWith(color: AppColors.dark.onSurface),
        displaySmall: h3Style.copyWith(color: AppColors.dark.onSurface),
        headlineMedium: h4StyleLight.copyWith(color: AppColors.dark.onSurface),
        headlineSmall: h5StyleLight.copyWith(color: AppColors.dark.onSurface),
        bodyLarge: bodyTextLight.copyWith(color: AppColors.dark.onSurface),
        bodyMedium:
            bodyTextLight.copyWith(color: AppColors.dark.onSurfaceVariant),
        titleMedium: subtitleLight.copyWith(color: AppColors.dark.onSurface),
        labelLarge: h4StyleLight.copyWith(color: AppColors.dark.primary),
        headlineLarge: headlineLarge.copyWith(color: AppColors.dark.onSurface),
      ),

      // Icon Theme
      iconTheme: IconThemeData(color: AppColors.dark.onSurfaceVariant),
      primaryIconTheme: IconThemeData(color: AppColors.dark.primary),

      // Other Themes
      bottomAppBarTheme: BottomAppBarThemeData(
        color: AppColors.dark.surface,
        elevation: 8,
        shape: const CircularNotchedRectangle(),
      ),

      dividerTheme: DividerThemeData(
        color: AppColors.dark.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.dark.primary,
        linearTrackColor: AppColors.dark.surfaceVariant,
        circularTrackColor: AppColors.dark.surfaceVariant,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.dark.primary;
          }
          return AppColors.dark.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.dark.primary.withValues(alpha: 0.5);
          }
          return AppColors.dark.surfaceVariant;
        }),
      ),
    ),
  };
}

/// Extension for PinTheme to support OTP input styling
extension PinThemeExtension on ThemeData {
  /// Get app theme extension
  AppThemeExtension get _appExtension =>
      extension<AppThemeExtension>() ??
      (brightness == Brightness.light
          ? AppThemes._lightAppExtension
          : AppThemes._darkAppExtension);

  /// Default PIN theme for OTP fields
  PinTheme get defaultPinTheme => PinTheme(
        height: 58,
        width: 58,
        textStyle: textTheme.displayMedium?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          color: _appExtension.otpBackgroundSecondary,
          shape: BoxShape.circle,
          border: Border.all(
            color: colorScheme.outline,
            width: 1.0,
          ),
        ),
      );

  /// Focused PIN theme for active OTP field
  PinTheme get focusedPinTheme => PinTheme(
        height: 58,
        width: 58,
        textStyle: textTheme.displayMedium?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          color: _appExtension.otpBackground.withValues(alpha: 0.4),
          border: Border.all(
            color: colorScheme.primary,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.25),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          shape: BoxShape.circle,
        ),
      );

  /// Submitted PIN theme for completed OTP field
  PinTheme get submittedPinTheme => PinTheme(
        height: 58,
        width: 58,
        textStyle: textTheme.displayMedium?.copyWith(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.w700,
        ),
        decoration: BoxDecoration(
          color: colorScheme.primary,
          border: Border.all(
            color: colorScheme.primary,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.3),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          shape: BoxShape.circle,
        ),
      );

  /// Error PIN theme for invalid OTP field
  PinTheme get errorPinTheme => PinTheme(
        height: 58,
        width: 58,
        textStyle: textTheme.displayMedium?.copyWith(
          color: colorScheme.onError,
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          color: colorScheme.errorContainer,
          border: Border.all(
            color: colorScheme.error,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.error.withValues(alpha: 0.25),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          shape: BoxShape.circle,
        ),
      );
}

/// Theme Extension Accessor
extension ThemeExtensionAccessor on BuildContext {
  /// Get app theme extension from context
  AppThemeExtension get appTheme =>
      Theme.of(this).extension<AppThemeExtension>() ??
      (Theme.of(this).brightness == Brightness.light
          ? AppThemes._lightAppExtension
          : AppThemes._darkAppExtension);
}

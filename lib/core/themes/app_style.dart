// app_style.dart - Typography System (Enterprise Design System)
// Single Source of Truth for Font Management
// Fonts: Poppins (universal font for entire app)
//
// ✅ CURRENT: Using Local Poppins Fonts
// 🎯 STATUS: Production ready with local font files

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'app_colors.dart';

/// AppFonts - Centralized Font Management System
///
/// This class provides a single source of truth for all font families,
/// weights, and styles used throughout the application. To change the
/// font family for the entire app, only modify this class.
///
/// Usage:
/// - AppFonts.headingFont for all heading fonts
/// - AppFonts.bodyFont for all body text fonts
/// - AppFonts.getHeadingStyle() for themed heading styles
/// - AppFonts.getBodyStyle() for themed body styles
class AppFonts {
  const AppFonts._();

  // ========================================
  // FONT FAMILY CONFIGURATION
  // Single source for all fonts in the app
  // ========================================

  /// Universal font family for all text (headings, body, buttons, etc.)
  /// Poppins provides complete coverage with weights 100-900
  /// Change this single constant to update all fonts throughout the app
  static const String _universalFontFamily = 'Poppins';

  // ========================================
  // FONT GETTERS
  // Use these methods to get font families consistently
  // USING LOCAL POPPINS FONTS
  // ========================================

  /// Get Poppins font for headings (same as body for consistency)
  /// Uses local fonts from asset/fonts/
  static TextStyle get headingFont =>
      const TextStyle(fontFamily: _universalFontFamily);

  /// Get Poppins font for body text (same as headings for consistency)
  /// Uses local fonts from asset/fonts/
  static TextStyle get bodyFont =>
      const TextStyle(fontFamily: _universalFontFamily);

  // ========================================
  // POPPINS WEIGHT REFERENCE & UTILITIES
  // Complete weight mapping for all Poppins variants
  // ========================================

  /// Complete Poppins Weight Reference
  /// All weights available in the font family for easy access
  static const Map<String, FontWeight> poppinsWeights = {
    'thin': FontWeight.w100, // Poppins-Thin.ttf
    'extraLight': FontWeight.w200, // Poppins-ExtraLight.ttf
    'light': FontWeight.w300, // Poppins-Light.ttf
    'regular': FontWeight.w400, // Poppins-Regular.ttf ✅ Used
    'medium': FontWeight.w500, // Poppins-Medium.ttf ✅ Used
    'semiBold': FontWeight.w600, // Poppins-SemiBold.ttf ✅ Used
    'bold': FontWeight.w700, // Poppins-Bold.ttf ✅ Used
    'extraBold': FontWeight.w800, // Poppins-ExtraBold.ttf ✅ Used
    'black': FontWeight.w900, // Poppins-Black.ttf
  };

  /// Quick access to commonly used weights
  static FontWeight get thin => poppinsWeights['thin']!;
  static FontWeight get extraLight => poppinsWeights['extraLight']!;
  static FontWeight get light => poppinsWeights['light']!;
  static FontWeight get regular => poppinsWeights['regular']!;
  static FontWeight get medium => poppinsWeights['medium']!;
  static FontWeight get semiBold => poppinsWeights['semiBold']!;
  static FontWeight get bold => poppinsWeights['bold']!;
  static FontWeight get extraBold => poppinsWeights['extraBold']!;
  static FontWeight get black => poppinsWeights['black']!;

  /// Get Poppins TextStyle with specific weight
  /// Usage: AppFonts.poppins(weight: AppFonts.semiBold, size: 18)
  /// Uses local fonts from asset/fonts/
  static TextStyle poppins({
    FontWeight weight = FontWeight.w400,
    double? size,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: _universalFontFamily,
      fontWeight: weight,
      fontSize: size,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // ========================================
  // THEMED TEXT STYLES
  // Context-aware text styles that adapt to theme
  // ========================================

  /// Get heading style with theme-aware colors
  static TextStyle getHeadingStyle(
    BuildContext context, {
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return headingFont.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? Theme.of(context).colorScheme.onSurface,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// Get body style with theme-aware colors
  static TextStyle getBodyStyle(
    BuildContext context, {
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return bodyFont.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? Theme.of(context).colorScheme.onSurface,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// Get heading style without context (use with caution - prefer getHeadingStyle)
  static TextStyle getRawHeadingStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return headingFont.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// Get body style without context (use with caution - prefer getBodyStyle)
  static TextStyle getRawBodyStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return bodyFont.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}

// ========================================
// PREDEFINED TEXT STYLES (Legacy Support)
// Use AppFonts methods for new code
// ========================================

/// Primary heading style (32px, Poppins, Weight 800)
/// @deprecated Use AppFonts.getHeadingStyle() instead
TextStyle h1Style = AppFonts.getRawHeadingStyle(
  fontSize: 32,
  fontWeight: FontWeight.w800, // Design system weight
  height: 1.2, // Design system line height
);

/// Secondary heading style (18px, Poppins, Weight 600)
/// @deprecated Use AppFonts.getBodyStyle() instead
TextStyle h2Style = AppFonts.getRawBodyStyle(
  fontSize: 18, // Design system button text size
  fontWeight: FontWeight.w600, // Design system button weight
);

/// Tertiary heading style (16px, Poppins, Weight 500)
/// @deprecated Use AppFonts.getBodyStyle() instead
TextStyle h3Style = AppFonts.getRawBodyStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500, // Design system body text weight
  height: 1.5, // Design system line height
);

/// Large headline style (18px, Poppins, Weight 600)
/// @deprecated Use AppFonts.getBodyStyle() instead
TextStyle headlineLarge = AppFonts.getRawBodyStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600, // System UI weight from design system
);

/// Light heading style (16px, Poppins, Weight 500)
/// @deprecated Use AppFonts.getBodyStyle() instead
TextStyle h4StyleLight = AppFonts.getRawBodyStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500, // Adjusted for consistency
);

/// Small heading style (14px, Poppins, Weight 400)
/// @deprecated Use AppFonts.getBodyStyle() instead
TextStyle h5StyleLight = AppFonts.getRawBodyStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

/// Main body text style (16px, Poppins, Weight 500)
/// @deprecated Use AppFonts.getBodyStyle() instead
TextStyle bodyTextLight = AppFonts.getRawBodyStyle(
  fontSize: 16, // Main body text size from design system
  fontWeight: FontWeight.w500, // From design system
  height: 1.5, // Design system line height
);

/// Subtitle text style (14px, Poppins, Weight 500)
/// @deprecated Use AppFonts.getBodyStyle() instead
TextStyle subtitleLight = AppFonts.getRawBodyStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500, // Adjusted for consistency
);

// Input Decoration Style (Enterprise Design System)
// Border radius updated to match design system
final OutlineInputBorder textFieldStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10), // Design system small elements
  borderSide: BorderSide(color: AppColors.light.outline, width: 1.0),
);

final decorationStyle = BoxDecoration(
    borderRadius: BorderRadius.circular(10), // Design system border radius
    border: Border.all(color: AppColors.light.outline, width: 1.0));

// Enterprise Design System Constants
class AppDesignTokens {
  static const double borderRadiusSmall = 10.0; // Small elements
  static const double borderRadiusMedium = 17.0; // Larger containers
  static const double borderRadiusLarge = 50.0; // Buttons (full round)

  static const double spacingXs = 6.0; // Gap spacing from design system
  static const double spacingSm = 11.0; // Vertical spacing from design system
  static const double spacingMd = 17.0; // Button padding from design system
  static const double spacingLg = 20.0; // Container padding
}

// App Design System - Typography Specifications
// Using Poppins for all text (consistent font strategy)
class AppTypography {
  const AppTypography._();

  // ========================================
  // OTP SCREEN SPECIFIC TYPOGRAPHY
  // Design system typography specifications
  // Using Poppins for consistency
  // ========================================

  /// OTP Screen Title - "OTP" (Poppins ExtraBold, 800 weight, 32px, 100% line height)
  static TextStyle getOtpTitle(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.medium, // w800 - Poppins ExtraBold
      size: 32.0,
      height: 1.0, // 100% line height
      letterSpacing: 0.0, // 0% letter spacing
      color: appColors.onBackground, // Theme-aware color
    );
  }

  /// OTP Screen Subtitle - "Enter the OTP sent to your number" (Poppins Medium, 500 weight, 16px, 100% line height)
  static TextStyle getOtpSubtitle(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.medium, // w500 - Poppins Medium
      size: 16.0,
      height: 1.0, // 100% line height
      letterSpacing: 0.0, // 0% letter spacing
      color: appColors.onSurfaceVariant, // Theme-aware color for secondary text
    );
  }

  static TextStyle getAccountSetupTitle(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.medium, // w800 - Poppins ExtraBold
      size: 32.0,
      height: 1.0, // 100% line height
      letterSpacing: 0.0, // 0% letter spacing
      color: appColors.onBackground, // Theme-aware color
    );
  }

  /// App Bar Title - Generic app bar title styling (Poppins SemiBold, 600 weight, 18px, 100% line height)
  static TextStyle getAppBarTitle(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.semiBold, // w600 - Poppins SemiBold
      size: 18.0,
      height: 1.0, // 100% line height
      letterSpacing: 0.0, // 0% letter spacing
      color: appColors.onSurface, // Theme-aware color for app bar text
    );
  }

  /// Body Text - General purpose body text styling (Poppins Regular, 400 weight, 16px, 150% line height)
  static TextStyle getBodyText(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.regular, // w400 - Poppins Regular
      size: 16.0,
      height: 1.5, // 150% line height for readability
      letterSpacing: 0.0, // 0% letter spacing
      color: appColors.onSurface, // Theme-aware color
    );
  }

  /// Phone Number Display - "+91 89404 16286" (Poppins Medium, 500 weight, 19px, 100% line height)
  static TextStyle getPhoneNumberDisplay(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.medium, // w500 - Poppins Medium
      size: 19.0, // Exact size specification
      height: 1.0, // 100% line height
      letterSpacing: 0.0, // 0% letter spacing
      color: appColors.onSurface, // Theme-aware color
    );
  }

  /// OTP Input Fields - "1", "2", "3", "4" (Poppins SemiBold, 600 weight, 24px, 100% line height, 6% letter spacing)
  static TextStyle getOtpInputText(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.semiBold, // w600 - Poppins SemiBold
      size: 24.0, // Exact size specification
      height: 1.0, // 100% line height
      letterSpacing: 0.06 * 24.0, // 6% of font size
      color: appColors.onSurface, // Theme-aware color
    );
  }

  /// Resend Timer Text - "Resend (30s)" (Poppins Medium, 500 weight, 16px, 100% line height)
  static TextStyle getResendText(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.medium, // w500 - Poppins Medium
      size: 16.0,
      height: 1.0, // 100% line height
      letterSpacing: 0.0, // 0% letter spacing
      color: appColors.primary, // Theme-aware primary color
    );
  }

  /// Button Text - "Verify" (Poppins Medium, 500 weight, 18px, 100% line height)
  static TextStyle getButtonText(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.medium, // w500 - Poppins Medium
      size: 18.0, // Exact size specification
      height: 1.0, // 100% line height
      letterSpacing: 0.0, // 0% letter spacing
      color: appColors.onPrimary, // Theme-aware text on primary color
    );
  }

  static TextStyle getTextFieldText(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.regular, // w400 - Poppins Regular
      size: 16.0,
      height: 1.0, // 100% line height
      letterSpacing: 0.0,
      color: appColors.onSurface, // Theme-aware color
    );
  }

  /// Text Field Label - Styling for floating labels and field labels
  static TextStyle getTextFieldLabel(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.medium, // w500 - Poppins Medium
      size: 14.0,
      height: 1.0, // 100% line height
      letterSpacing: 0.0,
      color: appColors.onSurfaceVariant, // Theme-aware color for labels
    );
  }

  /// Text Field Hint - Styling for placeholder/hint text
  static TextStyle getTextFieldHint(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.regular, // w400 - Poppins Regular
      size: 16.0,
      height: 1.0, // 100% line height
      letterSpacing: 0.0,
      color: appColors.onSurfaceVariant.withOpacity(0.6), // Lighter hint color
    );
  }

  /// Already have account text - "Already have an account?" (Poppins Medium, 500 weight, 16px, 100% line height)
  static TextStyle getPromptText(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.medium, // w500 - Poppins Medium
      size: 16.0,
      height: 1.0, // 100% line height
      letterSpacing: 0.0, // 0% letter spacing
      color: appColors.onSurfaceVariant, // Theme-aware color for secondary text
    );
  }

  /// Login link text - "Login" (Poppins Medium, 500 weight, 16px, 100% line height)
  static TextStyle getLinkText(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.medium, // w500 - Poppins Medium
      size: 16.0,
      height: 1.0, // 100% line height
      letterSpacing: 0.0, // 0% letter spacing
      color: appColors.primary, // Theme-aware primary color
    );
  }

  // ========================================
  // LOGIN SCREEN SPECIFIC TYPOGRAPHY
  // Design system typography specifications
  // Following OTP screen patterns for consistency
  // ========================================

  /// Login Screen Title - "Login" (Poppins ExtraBold, 800 weight, 32px, 100% line height)
  static TextStyle getLoginTitle(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.extraBold, // w800 - Poppins ExtraBold
      size: 32.0,
      height: 1.0, // 100% line height
      letterSpacing: 0.0, // 0% letter spacing
      color: appColors.onBackground, // Theme-aware color
    );
  }

  /// Login Screen Subtitle - "Enter your mobile number" (Poppins Medium, 500 weight, 16px, 100% line height)
  static TextStyle getLoginSubtitle(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.medium, // w500 - Poppins Medium
      size: 16.0,
      height: 1.0, // 100% line height
      letterSpacing: 0.0, // 0% letter spacing
      color: appColors.onSurfaceVariant, // Theme-aware color for secondary text
    );
  }

  /// Country Code Text - "+91" (Poppins Medium, 500 weight, 14px, 100% line height)
  static TextStyle getCountryCodeText(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.medium, // w500 - Poppins Medium
      size: 14.0, // Exact size specification
      height: 1.0, // 100% line height
      letterSpacing: 0.0, // 0% letter spacing
      color: appColors.onSurface, // Theme-aware color
    );
  }

  /// Mobile Input Text - Input field text styling (Poppins Regular, 400 weight, 18px, 1.08 letter spacing)
  static TextStyle getMobileInputText(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.regular, // w400 - Poppins Regular
      size: 18.0, // Exact size specification
      height: 1.0, // 100% line height
      letterSpacing: 1.08, // 1.08px letter spacing
      color: appColors.onSurface, // Theme-aware color
    );
  }

  /// Mobile Input Label - "Mobile Number" (Poppins Medium, 500 weight, 14px, 100% line height)
  static TextStyle getMobileInputLabel(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.medium, // w500 - Poppins Medium
      size: 14.0,
      height: 1.0, // 100% line height
      letterSpacing: 0.0, // 0% letter spacing
      color: appColors.onSurface, // Theme-aware color
    );
  }

  /// Mobile Input Hint - Placeholder text styling (Poppins Regular, 400 weight, 18px, 1.08 letter spacing)
  static TextStyle getMobileInputHint(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.regular, // w400 - Poppins Regular
      size: 18.0,
      height: 1.0, // 100% line height
      letterSpacing: 1.08, // 1.08px letter spacing
      color: appColors.onSurfaceVariant, // Theme-aware color for hint text
    );
  }

  /// Error Text - Styling for validation error messages (Poppins Regular, 400 weight, 14px)
  static TextStyle getErrorText(BuildContext context) {
    final appColors = context.appColors;
    return AppFonts.poppins(
      weight: AppFonts.regular, // w400 - Poppins Regular
      size: 14.0, // Standard error text size
      height: 1.5, // 150% line height for readability
      letterSpacing: 0.0, // Standard letter spacing
      color: appColors.error, // Theme-aware error color
    );
  }
}

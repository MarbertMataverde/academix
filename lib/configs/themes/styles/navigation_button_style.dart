/// Imports color values for different themes
///
/// Contains DarkThemeColors, LightThemeColors, and
/// MirageThemeColors classes with color constants.
///
/// Allows looking up colors for currently selected
/// theme option.

import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';

/// Imports theme state management
///
/// ThemeOptions class enumerates possible themes.
///
/// themeStateProvider Riverpod provider stores the
/// currently selected ThemeOptions value.

import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';

/// Flutter widget library for UI and Material Components
///
/// Provides ElevatedButton class and theming capabilities.

import 'package:flutter/material.dart';

/// Riverpod state management library
///
/// Gives access to read theme state via providers.

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Builds ElevatedButton style adapting colors and styling based on
/// selected theme.
///
/// Useful for navigation buttons that reflect current theme options.
/// Theming applied includes background, text color, sizing, etc.

ButtonStyle navigationButtonStyle({
  /// [WidgetRef] from Riverpod to access current theme

  /// Passed in by caller to look up theme from providers

  required WidgetRef ref,

  /// Exact width to use for button size

  /// Allows overriding default width to fixed value

  double? buttonWidth,

  /// Exact height to use for button size

  /// Allows overriding default height to fixed value

  double? buttonHeight,

  /// Whether to use active styling for button

  /// Applies theme based background when true

  bool isActiv = false,
}) {
  /// Get current theme name from state provider

  final String themeState = ref.watch(themeStateProvider);

  /// Configure ElevatedButton theming based on theme:

  ///
  /// - No elevation shadow

  /// - Custom size if width/height specified

  /// - Rounded rectangle border radius 5

  /// - Remove splash effect

  /// - Transparent background unless active

  /// - Theme based background color when active

  /// - Theme based foreground/text color

  return ElevatedButton.styleFrom(
    elevation: 0,
    fixedSize: Size(buttonWidth ?? double.infinity, buttonHeight ?? 50),
    backgroundColor: isActiv
        ? themeState == ThemeOptions.darkTheme
            ? DarkThemeColors.buttonBackgroundColor
            : themeState == ThemeOptions.mirageTheme
                ? MirageThemeColors.buttonBackgroundColor
                : LightThemeColors.shadowColor
        : Colors.transparent,
    side: null,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    splashFactory: NoSplash.splashFactory,
    shadowColor: Colors.transparent,
    animationDuration: const Duration(milliseconds: 100),
    foregroundColor: themeState == ThemeOptions.darkTheme
        ? DarkThemeColors.foregroundColor
        : themeState == ThemeOptions.mirageTheme
            ? MirageThemeColors.foregroundColor
            : LightThemeColors.foregroundColor,
  );
}

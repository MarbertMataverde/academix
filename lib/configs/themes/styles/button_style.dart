import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:flutter/material.dart';

/// Returns a ButtonStyle based on the provided theme state.
///
/// The `themeState` parameter represents the current theme of the app, which is a string.
/// The returned ButtonStyle will have a background color, elevation, side, shape, splash factory, animation duration,
/// and foreground color based on the provided theme state.
ButtonStyle elevatedButtonStyle({
  required String themeState,
  double? buttonWidth,
  double? buttonHeight,
}) {
  return ElevatedButton.styleFrom(
    elevation: 0,
    fixedSize: Size(buttonWidth ?? double.infinity, buttonHeight ?? 50),
    backgroundColor: themeState == ThemeOptions.darkTheme
        ? DarkThemeColors.buttonBackgroundColor
        : themeState == ThemeOptions.mirageTheme
            ? MirageThemeColors.buttonBackgroundColor
            : LightThemeColors.buttonBackgroundColor,
    side: themeState == ThemeOptions.lightTheme
        ? const BorderSide(color: LightThemeColors.shadowColor, width: 0.5)
        : null,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    splashFactory: NoSplash.splashFactory,
    animationDuration: const Duration(milliseconds: 100),
    foregroundColor: themeState == ThemeOptions.darkTheme
        ? DarkThemeColors.foregroundColor
        : themeState == ThemeOptions.mirageTheme
            ? MirageThemeColors.foregroundColor
            : LightThemeColors.foregroundColor,
  );
}

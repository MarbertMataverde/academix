/// The `customMaterialIconButton` function creates a custom material button with an icon. Here's the documentation for the code:

/// customMaterialIconButton: This function is used to create a material button with a circular shape and an icon. It is commonly used to create close or cancel buttons in dialog boxes or modals.
/// The function takes the following parameters:
///   - `ref`: The widget reference used to access providers and update state.
///   - `themeState`: The current theme state of the app.
///   - `onPressed`: (optional) A callback function to be executed when the button is pressed. If not provided, the button will be disabled.
/// The function returns a `MaterialButton` widget with the specified configuration.

import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

MaterialButton customMaterialIconButton({
  required WidgetRef ref,
  required String themeState,
  required Function()? onPressed,
}) {
  return MaterialButton(
    minWidth: 10,
    shape: const CircleBorder(),
    onPressed: onPressed,
    child: Icon(
      Icons.close_rounded,
      color: themeState == ThemeOptions.darkTheme
          ? DarkThemeColors.foregroundSecondColor
          : themeState == ThemeOptions.mirageTheme
              ? MirageThemeColors.foregroundSecondColor
              : LightThemeColors.foregroundSecondColor,
    ),
  );
}

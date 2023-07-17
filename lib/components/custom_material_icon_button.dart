/// Imports color classes for different theme options.
/// Provides access to color values for each theme.
import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';

/// Imports theme state management code.
/// Contains ThemeOptions class for current theme.
import 'package:academix/configs/themes/provider/theme_options.dart';

/// Imports core Flutter libraries for UI and state management.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Builds a custom Material button with icon color based on theme.
///
/// This is useful for having buttons that adapt their icon color
/// to the currently selected app theme. The theme is read from
/// the state provider to get the current option.

MaterialButton customMaterialIconButton({
  /// [WidgetRef] from Riverpod state management.
  ///
  /// Gives access to read the current theme selection from the
  /// state provider. Passed in by caller.

  required WidgetRef ref,

  /// Current theme selected, will be value from ThemeOptions.
  ///
  /// Used to map to correct colors class for icon tint.

  required String themeState,

  /// Callback invoked when button is pressed by user.
  ///
  /// Passed thru to MaterialButton onPressed parameter.

  required Function()? onPressed,

  /// Icon to display within button, defaults to close icon.
  ///
  /// Can customize the icon shown if needed.

  IconData? iconData,
}) {
  /// Return a MaterialButton configured with:
  ///
  /// - Circle border shape using CircleBorder.
  ///
  /// - Minimum width of 10 logical pixels.
  ///
  /// - Passed in onPressed callback for handling taps.
  ///
  /// - Child icon wrapped in Padding for spacing.
  ///
  /// - Icon tinted using theme based color map.

  return MaterialButton(
    // Circular shape
    shape: const CircleBorder(),

    // Minimum width
    minWidth: 10,

    // Passed in tap handler
    onPressed: onPressed,

    // Padded icon child
    child: Padding(
      padding: const EdgeInsets.all(5.0),

      // Icon with theme color
      child: Icon(
        iconData ?? Icons.close_rounded,

        // Map theme to color
        color: themeState == ThemeOptions.darkTheme
            ? DarkThemeColors.foregroundSecondColor
            : themeState == ThemeOptions.mirageTheme
                ? MirageThemeColors.foregroundSecondColor
                : LightThemeColors.foregroundSecondColor,
      ),
    ),
  );
}

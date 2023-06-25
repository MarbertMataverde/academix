import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:flutter/material.dart';

// This is the definition of the light theme data used in the application.
final ThemeData lightThemeData = ThemeData(
  // Enable Material3 design.
  useMaterial3: true,

  // Set the primary color for the theme.
  primaryColor: LightThemeColors.primaryColor,

  // Set the background color for the scaffold (the main app screen).
  scaffoldBackgroundColor: LightThemeColors.scaffoldBackgroundColor,

  // Customize the color scheme for the theme.
  colorScheme: const ColorScheme.light().copyWith(
    // Set the error color.
    error: LightThemeColors.errorColor,

    // Set the shadow color.
    shadow: LightThemeColors.shadowColor,
  ),

  // Define the text styles for different types of text in the app.
  textTheme: const TextTheme(
    // Set the text style for small-sized body text.
    bodySmall: TextStyle(color: LightThemeColors.foregroundColor),

    // Set the text style for medium-sized body text.
    bodyMedium: TextStyle(color: LightThemeColors.foregroundColor),

    // Set the text style for large-sized body text.
    bodyLarge: TextStyle(color: LightThemeColors.foregroundColor),

    // Set the text style for small-sized labels.
    labelSmall: TextStyle(color: LightThemeColors.foregroundSecondColor),

    // Set the text style for medium-sized labels.
    labelMedium: TextStyle(color: LightThemeColors.foregroundSecondColor),

    // Set the text style for large-sized labels.
    labelLarge: TextStyle(color: LightThemeColors.foregroundSecondColor),
  ),

  // Set the default font family for the theme.
  fontFamily: 'Ysabeau',
);

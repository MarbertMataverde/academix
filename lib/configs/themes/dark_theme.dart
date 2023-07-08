import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:flutter/material.dart';

// This is the definition of the dark theme data used in the application.
final ThemeData darkThemeData = ThemeData(
  // Enable Material3 design.
  // useMaterial3: true,

  // Set the primary color for the theme.
  primaryColor: DarkThemeColors.primaryColor,

  // Set the background color for the scaffold (the main app screen).
  scaffoldBackgroundColor: DarkThemeColors.scaffoldBackgroundColor,

  // Customize the color scheme for the theme.

  colorScheme: const ColorScheme.dark(
    primary: DarkThemeColors.primaryColor,
    secondary: DarkThemeColors.secondaryColor,
    error: DarkThemeColors.errorColor,
    shadow: DarkThemeColors.shadowColor,
  ),

  // Define the text styles for different types of text in the app.
  textTheme: const TextTheme(
    // Set the text style for small-sized body text.
    bodySmall: TextStyle(color: DarkThemeColors.foregroundColor),

    // Set the text style for medium-sized body text.
    bodyMedium: TextStyle(color: DarkThemeColors.foregroundColor),

    // Set the text style for large-sized body text.
    bodyLarge: TextStyle(color: DarkThemeColors.foregroundColor),

    // Set the text style for small-sized labels.
    labelSmall: TextStyle(color: DarkThemeColors.foregroundSecondColor),

    // Set the text style for medium-sized labels.
    labelMedium: TextStyle(color: DarkThemeColors.foregroundSecondColor),

    // Set the text style for large-sized labels.
    labelLarge: TextStyle(color: DarkThemeColors.foregroundSecondColor),
  ),

  // Set the default font family for the theme.
  fontFamily: 'Gilroy',
);

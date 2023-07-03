import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:flutter/material.dart';

// This is the definition of the Mirage theme data used in the application with Mirage colors.
final ThemeData mirageThemeData = ThemeData(
  // Enable Material3 design.
  // useMaterial3: true,

  // Set the primary color for the theme.
  primaryColor: MirageThemeColors.primaryColor,

  // Set the background color for the scaffold (the main app screen).
  scaffoldBackgroundColor: MirageThemeColors.scaffoldBackgroundColor,

  // Customize the color scheme for the theme.
  colorScheme: const ColorScheme.dark().copyWith(
    // Set the error color.
    error: MirageThemeColors.errorColor,

    // Set the shadow color.
    shadow: MirageThemeColors.shadowColor,
  ),

  // Define the text styles for different types of text in the app.
  textTheme: const TextTheme(
    // Set the text style for small-sized body text.
    bodySmall: TextStyle(color: MirageThemeColors.foregroundColor),

    // Set the text style for medium-sized body text.
    bodyMedium: TextStyle(color: MirageThemeColors.foregroundColor),

    // Set the text style for large-sized body text.
    bodyLarge: TextStyle(color: MirageThemeColors.foregroundColor),

    // Set the text style for small-sized labels.
    labelSmall: TextStyle(color: MirageThemeColors.foregroundSecondColor),

    // Set the text style for medium-sized labels.
    labelMedium: TextStyle(color: MirageThemeColors.foregroundSecondColor),

    // Set the text style for large-sized labels.
    labelLarge: TextStyle(color: MirageThemeColors.foregroundSecondColor),
  ),

  // Set the default font family for the theme.
  fontFamily: 'Gilroy',
);

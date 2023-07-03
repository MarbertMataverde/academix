import 'package:flutter/material.dart';
import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';

/// A customizable text input field that adapts its appearance based on the selected theme of the app. It allows users to enter text and provides visual feedback according to the theme.

class CustomTextFormField extends StatelessWidget {
  /// The current theme of the app.
  final String themeState;

  /// Determines whether the text field is used for entering a password. If `true`, the entered text will be obscured.
  final bool? obscureText;

  /// The text to display as a hint in the text field.
  final String hintText;

  /// The keyboard type to use for the text field.
  final TextInputType? keyboardType;

  /// Creates a `CustomTextFormField`.
  ///
  /// The `themeState` parameter represents the current theme of the app, which is a string.
  /// The `obscureText` parameter determines whether the text field is used for entering a password. If `true`, the entered text will be obscured.
  /// The `hintText` parameter specifies the text to display as a hint in the text field.
  /// The `keyboardType` parameter determines the keyboard type to use for the text field.
  const CustomTextFormField({
    Key? key,
    required this.themeState,
    this.obscureText,
    required this.hintText,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      autocorrect: false,
      obscureText: obscureText ?? false,
      cursorRadius: const Radius.circular(5.0),
      maxLines: 1,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: themeState == ThemeOptions.darkTheme
              ? DarkThemeColors.foregroundColor.withAlpha(150)
              : themeState == ThemeOptions.mirageTheme
                  ? MirageThemeColors.foregroundColor.withAlpha(150)
                  : LightThemeColors.foregroundColor.withAlpha(150),
        ),
        filled: true,
        fillColor: themeState == ThemeOptions.darkTheme
            ? DarkThemeColors.buttonBackgroundColor
            : themeState == ThemeOptions.mirageTheme
                ? MirageThemeColors.buttonBackgroundColor
                : LightThemeColors.buttonBackgroundColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: themeState == ThemeOptions.darkTheme
                ? DarkThemeColors.foregroundColor
                : themeState == ThemeOptions.mirageTheme
                    ? MirageThemeColors.foregroundColor
                    : LightThemeColors.foregroundColor,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: themeState == ThemeOptions.lightTheme
              ? const BorderSide(
                  color: LightThemeColors.shadowColor,
                  width: 0.5,
                )
              : BorderSide.none,
        ),
      ),
      style: TextStyle(
        color: themeState == ThemeOptions.darkTheme
            ? DarkThemeColors.foregroundColor
            : themeState == ThemeOptions.mirageTheme
                ? MirageThemeColors.foregroundColor
                : LightThemeColors.foregroundColor,
      ),
      cursorColor: themeState == ThemeOptions.darkTheme
          ? DarkThemeColors.foregroundColor
          : themeState == ThemeOptions.mirageTheme
              ? MirageThemeColors.foregroundColor
              : LightThemeColors.foregroundColor,
    );
  }
}

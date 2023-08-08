// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';

/// A customizable text input field that adapts its appearance based on the selected theme of the app.
class CustomTextFormField extends StatelessWidget {
  /// The referrence of the app.
  final WidgetRef ref;

  /// Determines whether the text field is used for entering a password. If `true`, the entered text will be obscured.
  final bool? obscureText;

  /// The text to display as a hint in the text field.
  final String hintText;

  /// The keyboard type to use for the text field.
  final TextInputType? keyboardType;

  /// The custom text field width.
  final double? width;

  /// The custom text field height.
  final double? height;

  /// The input formatter for text field.
  final List<TextInputFormatter>? inputFomater;

  /// The maximum character length for the text field.
  final int? maxLength;

  /// The suffix icon widget to display at the end of the text field.
  final Widget? suffixIcon;

  /// The validator of the field
  final String? Function(String?)? validator;

  /// The text editing cotroller
  final TextEditingController? controller;

  final Function(String)? onFieldSubmited;

  /// Creates a `CustomTextFormField`.
  ///
  /// The `themeState` parameter represents the current theme of the app as a string.
  /// The `obscureText` parameter determines whether the text field is used for entering a password. If `true`, the entered text will be obscured.
  /// The `hintText` parameter specifies the text to display as a hint in the text field.
  /// The `keyboardType` parameter determines the keyboard type to use for the text field.
  const CustomTextFormField({
    Key? key,
    required this.ref,
    this.obscureText,
    required this.hintText,
    required this.keyboardType,
    this.width,
    this.height,
    this.inputFomater,
    this.maxLength,
    this.suffixIcon,
    this.validator,
    this.controller,
    this.onFieldSubmited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String themeState = ref.watch(themeStateProvider);
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: TextFormField(
        onFieldSubmitted: onFieldSubmited,
        controller: controller,
        validator: validator,
        autofocus: false,
        autocorrect: false,
        obscureText: obscureText ?? false,
        cursorRadius: const Radius.circular(5.0),
        inputFormatters: inputFomater,
        maxLines: 1,
        maxLength: maxLength,
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
          suffixIcon: suffixIcon,
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
      ),
    );
  }
}

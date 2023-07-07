import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:flutter/material.dart';

class AuthenticatingSpinnerWidget extends StatelessWidget {
  const AuthenticatingSpinnerWidget({
    super.key,
    required this.themeState,
  });

  final String themeState;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(
          color: themeState == ThemeOptions.darkTheme
              ? DarkThemeColors.foregroundColor
              : themeState == ThemeOptions.mirageTheme
                  ? MirageThemeColors.foregroundColor
                  : LightThemeColors.foregroundColor,
        ),
      ),
    );
  }
}

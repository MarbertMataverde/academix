import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:academix/constants/routes_path.dart';
import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// A custom AppBar widget that displays a back arrow button. The appearance of the arrow and the AppBar itself is based on the selected theme of the app.

/// Creates a custom [AppBar] with a back arrow button.
///
/// The [context] parameter represents the build context of the app.
/// The [themeState] parameter represents the current theme of the app as a string.
AppBar appBarArrowBackWidget(BuildContext context, WidgetRef ref) {
  final String themeState = ref.watch(themeStateProvider);
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: IconButton(
      onPressed: () => context.go(RoutesPath.home),
      icon: Icon(
        Icons.keyboard_arrow_left_outlined,
        color: themeState == ThemeOptions.darkTheme
            ? DarkThemeColors.foregroundColor
            : themeState == ThemeOptions.mirageTheme
                ? MirageThemeColors.foregroundColor
                : LightThemeColors.foregroundColor,
      ),
    ),
  );
}

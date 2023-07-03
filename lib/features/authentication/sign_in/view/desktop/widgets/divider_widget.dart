import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:flutter/material.dart';

/// A widget that displays a divider with text in between based on the selected theme.
class DividerWidget extends StatelessWidget {
  /// Creates a [DividerWidget].
  ///
  /// The [key] parameter is used to provide a key for this widget.
  /// The [themeState] parameter is required and represents the current theme state.
  const DividerWidget({
    Key? key,
    required this.themeState,
  }) : super(key: key);

  /// The current theme state.
  final String themeState;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExpandedDivider(themeState: themeState),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'or',
          ),
        ),
        ExpandedDivider(themeState: themeState),
      ],
    );
  }
}

/// A widget that displays an expanded divider based on the selected theme.
class ExpandedDivider extends StatelessWidget {
  /// Creates an [ExpandedDivider].
  ///
  /// The [key] parameter is used to provide a key for this widget.
  /// The [themeState] parameter is required and represents the current theme state.
  const ExpandedDivider({
    Key? key,
    required this.themeState,
  });

  /// The current theme state.
  final String themeState;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Divider(
        color: themeState == ThemeOptions.darkTheme
            ? DarkThemeColors.foregroundColor.withAlpha(150)
            : themeState == ThemeOptions.mirageTheme
                ? MirageThemeColors.foregroundColor.withAlpha(150)
                : LightThemeColors.foregroundColor.withAlpha(150),
      ),
    );
  }
}

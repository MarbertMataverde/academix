import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that displays a custom suffix icon for a text field. The icon toggles visibility of the text when pressed, and its appearance is based on the selected theme of the app.

class CustomSuffixIconWidget extends StatelessWidget {
  /// A reference to the widget's widgetRef.
  final WidgetRef ref;

  /// The state provider for controlling the visibility of the text.
  final StateProvider<bool> stateProvider;

  /// The current theme of the app.
  final String themeState;

  /// Creates a [CustomSuffixIconWidget].
  ///
  /// The [ref] parameter is a reference to the widget's [WidgetRef].
  /// The [stateProvider] parameter is the state provider for controlling the visibility of the text.
  /// The [themeState] parameter represents the current theme of the app as a string.
  const CustomSuffixIconWidget({
    Key? key,
    required this.ref,
    required this.stateProvider,
    required this.themeState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const CircleBorder(),
      onPressed: () => ref
          .read(stateProvider.notifier)
          .update((state) => !ref.read(stateProvider)),
      child: Icon(
        ref.watch(stateProvider) == false
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
        color: themeState == ThemeOptions.darkTheme
            ? DarkThemeColors.foregroundSecondColor
            : themeState == ThemeOptions.mirageTheme
                ? MirageThemeColors.foregroundSecondColor
                : LightThemeColors.foregroundSecondColor,
      ),
    );
  }
}

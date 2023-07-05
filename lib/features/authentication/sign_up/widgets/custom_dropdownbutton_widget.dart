import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';

/// A custom dropdown button widget.
class CustomDropdownButtonWidget extends StatelessWidget {
  /// Constructs a custom dropdown button widget.
  const CustomDropdownButtonWidget({
    Key? key,
    required this.ref,
    required this.mediaQuerySize,
    required this.themeState,
    this.width,
    this.height,
    required this.value,
    required this.valueStateProvider,
    required this.listOfItems,
    required this.hint,
  }) : super(key: key);

  /// The [WidgetRef] used for reading and updating state.
  final WidgetRef ref;

  /// The size of the media query.
  final Size mediaQuerySize;

  /// The theme state.
  final String themeState;

  /// The width of the dropdown button. Defaults to `null`.
  final double? width;

  /// The height of the dropdown button. Defaults to `null`.
  final double? height;

  /// The currently selected value of the dropdown button.
  final String? value;

  /// The state provider for the selected value.
  final StateProvider<String?> valueStateProvider;

  /// The list of items in the dropdown.
  final List<String> listOfItems;

  /// The hint text displayed when no item is selected.
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? mediaQuerySize.width * 0.8 / 6,
      height: height ?? 50,
      decoration: BoxDecoration(
        color: themeState == ThemeOptions.darkTheme
            ? DarkThemeColors.buttonBackgroundColor
            : themeState == ThemeOptions.mirageTheme
                ? MirageThemeColors.buttonBackgroundColor
                : LightThemeColors.buttonBackgroundColor,
        border: themeState == ThemeOptions.lightTheme
            ? Border.all(color: LightThemeColors.shadowColor, width: 0.5)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        dropdownColor: themeState == ThemeOptions.darkTheme
            ? DarkThemeColors.buttonBackgroundColor
            : themeState == ThemeOptions.mirageTheme
                ? MirageThemeColors.buttonBackgroundColor
                : LightThemeColors.buttonBackgroundColor,
        value: value,
        borderRadius: BorderRadius.circular(8),
        elevation: 1,
        items: listOfItems.map((String gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Center(child: Text(gender)),
          );
        }).toList(),
        onChanged: (String? selectedValue) => ref
            .read(valueStateProvider.notifier)
            .update((state) => selectedValue),
        hint: Center(child: Text(hint)),
        isExpanded: true,
        underline: Container(),
      ),
    );
  }
}

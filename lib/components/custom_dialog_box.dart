import 'package:academix/components/custom_material_icon_button.dart';
import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Displays a custom dialog box with the specified title, message, and optional widget.
///
/// The `customDialogBox` function is used to show a dialog box with a custom design and content.
/// It accepts various parameters to configure the dialog box appearance and behavior.
///
/// Parameters:
/// - `context`: The build context in which the dialog box is shown.
/// - `ref`: The widget reference used to access providers and update state.
/// - `themeState`: The current theme state of the app.
/// - `title`: The title of the dialog box.
/// - `message`: The message content of the dialog box.
/// - `width`: The width of the dialog box.
/// - `height`: The height of the dialog box.
/// - `isWithCloseIconButton`: (optional) Determines whether to display a close icon button in the dialog box. Defaults to `true`.
/// - `isDissmisable`: (optional) Determines whether the dialog box can be dismissed by tapping outside. Defaults to `false`.
/// - `widget`: (optional) An additional widget to be displayed in the dialog box.
///
/// Returns:
/// A `Future<dynamic>` representing the result of the dialog box. The type of the result depends on the user's interaction with the dialog box (e.g., button press).
Future<dynamic> customDialogBox({
  required BuildContext context,
  required WidgetRef ref,
  required String title,
  required String message,
  double? width,
  double? height,
  bool isWithCloseIconButton = true,
  bool isDissmisable = false,
  Widget? widget,
  Function()? closeButtonOnPressed,
}) async {
  final themeState = ref.watch(themeStateProvider);
  return showDialog(
    barrierDismissible: isDissmisable,
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          // Background container
          Container(
            width: width ?? 300,
            height: height ?? 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                width: 1,
                color: themeState == ThemeOptions.darkTheme
                    ? DarkThemeColors.foregroundSecondColor
                    : themeState == ThemeOptions.mirageTheme
                        ? MirageThemeColors.foregroundSecondColor
                        : LightThemeColors.scaffoldBackgroundColor,
              ),
            ),
          ),
          // Rotated container for visual effect
          Transform.rotate(
            angle: -0.08,
            child: Container(
              width: width ?? 300,
              height: height ?? 300,
              decoration: BoxDecoration(
                color: themeState == ThemeOptions.darkTheme
                    ? DarkThemeColors.buttonBackgroundColor
                    : themeState == ThemeOptions.mirageTheme
                        ? MirageThemeColors.buttonBackgroundColor
                        : LightThemeColors.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: isWithCloseIconButton
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: customMaterialIconButton(
                            ref: ref,
                            themeState: themeState,
                            onPressed:
                                closeButtonOnPressed ?? () => context.pop()),
                      ),
                    )
                  : Container(),
            ),
          ),
          // Message container
          SizedBox(
            width: width ?? 300,
            height: height ?? 300,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Message
                  Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                  // Additional widget
                  widget ?? Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

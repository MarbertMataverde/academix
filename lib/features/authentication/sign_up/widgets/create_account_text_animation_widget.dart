import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

/// The `creatingAccountTextAnimation` function displays a dialog with an animated text that simulates the process of creating an account. Here's the documentation for the code:

/// creatingAccountTextAnimation: This function creates and displays a dialog with an animated text that provides visual feedback during the account creation process.
/// It takes the following parameters:
///   - context: The build context of the widget.
///   - themeState: The current theme state (e.g., ThemeOptions.darkTheme, ThemeOptions.mirageTheme) used to determine the text color.
/// The function returns a `Future<dynamic>` that represents the dialog.

/// The function uses the `showDialog` method to create the dialog. It sets `barrierDismissible` to `false` to prevent dismissing the dialog by tapping outside.

/// Inside the dialog, it uses the `Dialog` widget with a transparent background color and elevation set to 0 to achieve a custom dialog appearance.

/// The animated text is achieved using the `AnimatedTextKit` widget from the `animated_text_kit` package. It displays a series of animated texts that rotate with a fade-in effect.
/// The `isRepeatingAnimation` parameter is set to `true`, so the animation repeats indefinitely.

/// The `DefaultTextStyle` widget sets the default text style for the animated text. The text size and color are determined based on the `themeState` parameter.
/// The `fontSize` is set to 30, and the text color is determined by the current theme state: white for dark theme, white70 for mirage theme, and the scaffold background color for other light themes.

/// The animated texts are defined as a list of `RotateAnimatedText` widgets, each representing a text phrase. The animated texts are displayed sequentially in the dialog.

/// The function wraps the entire dialog creation code and returns a `Future<dynamic>`, allowing it to be awaited for further control flow if needed.

Future<dynamic> creatingAccountTextAnimation(
    BuildContext context, String themeState) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 30,
            color: themeState == ThemeOptions.darkTheme
                ? Colors.white
                : themeState == ThemeOptions.mirageTheme
                    ? Colors.white70
                    : LightThemeColors.scaffoldBackgroundColor,
          ),
          child: AnimatedTextKit(
            isRepeatingAnimation: true,
            animatedTexts: [
              RotateAnimatedText('CREATING YOUR ACCOUNT',
                  textAlign: TextAlign.center),
              RotateAnimatedText('WE APPRICIATE YOUR PATIENCE',
                  textAlign: TextAlign.center),
              RotateAnimatedText('YOU ARE AMAZING',
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    },
  );
}

/// The `DialogBoxButton` widget represents a button that is commonly used in dialog boxes. Here's the documentation for the code:

/// DialogBoxButton: This widget is used to display a button within a dialog box. It is typically used as an action button, such as "Okay" or "Cancel".
/// The widget takes the following parameters:
///   - themeState: The current theme state (e.g., light theme, dark theme) used to determine the button style.
///   - onPressed: An optional callback function that is executed when the button is pressed. If not provided, the default action is to dismiss the dialog by calling `context.pop()`.
///   - label: An optional string that represents the text displayed on the button. If not provided, the default label is "Okay".
/// The widget returns a `SizedBox` containing an `ElevatedButton` with the specified properties.

/// The `DialogBoxButton` widget is used to create consistent action buttons within dialog boxes. It encapsulates the button's appearance and behavior, making it easy to reuse and customize.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:academix/configs/themes/styles/button_style.dart';

class DialogBoxButton extends StatelessWidget {
  const DialogBoxButton({
    Key? key,
    required this.themeState,
    this.onPressed,
    this.label,
  }) : super(key: key);

  final String themeState;
  final Function()? onPressed;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 30,
      child: ElevatedButton(
        style: elevatedButtonStyle(
          themeState: themeState,
        ),
        onPressed: onPressed ?? () => context.pop(),
        child: Text(label ?? 'Okay'),
      ),
    );
  }
}

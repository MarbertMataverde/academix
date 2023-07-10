import 'package:academix/constants/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The `ForgotPasswordTextButtonWidget` widget displays a clickable text button for the "Forgot Password" feature.
///
/// It is used to navigate to the forgot password screen when tapped.
/// The widget is aligned to the center-right of its parent container.
///
/// Constructor Parameters:
/// - `key` (optional): An identifier for the widget. If omitted, a new key will be assigned automatically.
///
/// Example Usage:
/// ```dart
/// ForgotPasswordTextButtonWidget(),
/// ```
class ForgotPasswordTextButtonWidget extends StatelessWidget {
  const ForgotPasswordTextButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        hoverColor: Colors.transparent,
        onTap: () => context.push(RoutesPath.forgotPassword),
        child: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Text('Forgot Password?'),
        ),
      ),
    );
  }
}

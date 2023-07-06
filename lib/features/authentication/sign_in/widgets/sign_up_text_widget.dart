import 'package:academix/constants/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpTextWidget extends StatelessWidget {
  const SignUpTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
        ),
        InkWell(
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          hoverColor: Colors.transparent,
          onTap: () => context.go(RoutesPath.signUp),
          child: const Text(
            "Sign Up",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

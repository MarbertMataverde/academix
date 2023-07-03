import 'package:flutter/material.dart';

class SignUpTextWidget extends StatelessWidget {
  const SignUpTextWidget({
    super.key,
  });

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
          onTap: () {
            // Handle the button tap here
            // For example, navigate to the sign-up screen
          },
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

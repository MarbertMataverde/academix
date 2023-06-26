import 'package:flutter/material.dart';

// This widget enables responsive layout based on the screen width.
class ResponsiveLayout extends StatelessWidget {
  final Widget phone; // The widget to be displayed on phone-sized screens.
  final Widget tablet; // The widget to be displayed on tablet-sized screens.
  final Widget desktop; // The widget to be displayed on desktop-sized screens.

  // Constructor for the ResponsiveLayout widget.
  const ResponsiveLayout({
    Key? key,
    required this.phone,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the LayoutBuilder widget to obtain the screen constraints.
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Determine the appropriate widget based on the screen width.
        if (constraints.maxWidth <= 480) {
          // Return the phone widget for screens with width <= 480.
          return phone;
        } else if (constraints.maxWidth >= 480 &&
            constraints.maxWidth <= 1080) {
          // Return the tablet widget for screens with width between 480 and 1080.
          return tablet;
        } else {
          // Return the desktop widget for screens with width > 1080.
          return desktop;
        }
      },
    );
  }
}

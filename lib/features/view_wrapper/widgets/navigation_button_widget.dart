import 'package:academix/configs/themes/styles/navigation_button_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Represents a navigation button with an icon and label.
///
/// The button's visual style is determined by [navigationButtonStyle] and
/// whether it is active. Tapping calls [onTap].
///
/// The button displays the [iconData] and [label] text. It also interacts
/// with [stateProvider] to determine if it is the active button.
class NavigationButton extends StatelessWidget {
  /// Creates a new [NavigationButton].
  ///
  /// All parameters are required.
  const NavigationButton({
    Key? key,
    required this.ref,
    required this.onTap,
    required this.label,
    this.isActive = false,
    required this.iconData,
    required this.stateProvider,
    required this.index,
  }) : super(key: key);

  /// The widget ref to access state etc.
  final WidgetRef ref;

  /// The callback when the button is tapped.
  final Function() onTap;

  /// The text label to display.
  final String label;

  /// Whether this button is currently active.
  final bool isActive;

  /// The icon to display next to the label.
  final IconData iconData;

  /// The state provider that tracks the active index.
  final StateProvider<int> stateProvider;

  /// This button's index in the navigation list.
  final int index;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          style: navigationButtonStyle(ref: ref, isActiv: isActive),
          onPressed: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(iconData),
              const SizedBox(
                width: 30,
              ),
              Text(
                label,
                textScaleFactor: 1.1,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 100 * index)).slideX();
  }
}

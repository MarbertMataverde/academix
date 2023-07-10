import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:academix/constants/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// The `PageNotFound` widget displays a custom error page when a route is not found.
///
/// This widget is used to handle the "404 - Page Not Found" scenario in the application.
/// It shows a text column with a large "404" text, a "Page Not Found" message, and a "Back to Home" link.
/// It also includes an animated pointer that follows the user's cursor.
///
/// Constructor Parameters:
/// - `key` (optional): An identifier for the widget. If omitted, a new key will be assigned automatically.
///
/// Example Usage:
/// ```dart
/// PageNotFound(),
/// ```
class PageNotFound extends ConsumerStatefulWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PageNotFoundState();
}

/// The `PageNotFoundState` is the state class for the `PageNotFound` widget.
///
/// It extends the `ConsumerState` class and includes animation-related properties and methods.
class PageNotFoundState extends ConsumerState<PageNotFound>
    with SingleTickerProviderStateMixin {
  late Offset pointerOffset;
  late AnimationController pointerSizeController;
  late Animation<double> pointerAnimation;

  @override
  void initState() {
    pointerOffset = Offset.zero;
    pointerSizeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    pointerAnimation = CurvedAnimation(
        curve: Curves.easeInOutCubic,
        parent: Tween<double>(begin: 0, end: 1).animate(pointerSizeController));
    super.initState();
  }

  /// Toggles the size of the pointer animation based on the hover state.
  ///
  /// This method takes a `hovering` parameter that determines whether the cursor is hovering over the widget.
  /// If `hovering` is `true`, the pointer size is increased by animating the `pointerSizeController` forward.
  /// If `hovering` is `false`, the pointer size is decreased by animating the `pointerSizeController` in reverse.
  void togglePointerSize(bool hovering) async {
    if (hovering) {
      pointerSizeController.forward();
    } else {
      pointerSizeController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    // theme state
    final String themeState = ref.watch(themeStateProvider);

    return Scaffold(
      body: MouseRegion(
        opaque: false,
        cursor: SystemMouseCursors.none,
        onHover: (e) => setState(() => pointerOffset = e.localPosition),
        onExit: (e) => setState(() => pointerOffset = Offset.zero),
        child: Stack(
          children: [
            TextColumn(
              backgroundColor: themeState == ThemeOptions.darkTheme
                  ? DarkThemeColors.scaffoldBackgroundColor
                  : themeState == ThemeOptions.mirageTheme
                      ? MirageThemeColors.scaffoldBackgroundColor
                      : LightThemeColors.scaffoldBackgroundColor,
              textColor: themeState == ThemeOptions.darkTheme
                  ? DarkThemeColors.foregroundColor
                  : themeState == ThemeOptions.mirageTheme
                      ? MirageThemeColors.foregroundColor
                      : LightThemeColors.foregroundColor,
              onLinkHovered: togglePointerSize,
            ),
            AnimatedBuilder(
              animation: pointerSizeController,
              builder: (context, snapshot) {
                return AnimatedPointer(
                  pointerOffset: pointerOffset,
                  radius: 45 + 100 * pointerAnimation.value,
                );
              },
            ),
            AnimatedPointer(
              pointerOffset: pointerOffset,
              movementDuration: const Duration(milliseconds: 200),
              radius: 10,
            ),
          ],
        ),
      ),
    );
  }
}

/// The `TextColumn` widget displays a column of text content for the `PageNotFound` widget.
///
/// It includes the "404" text, "Page Not Found" message, and the "Back to Home" link.
class TextColumn extends StatelessWidget {
  const TextColumn({
    Key? key,
    required this.onLinkHovered,
    required this.textColor,
    required this.backgroundColor,
  }) : super(key: key);

  final Function(bool) onLinkHovered;
  final Color textColor;
  final Color backgroundColor;

  TextStyle get _defaultTextStyle => TextStyle(color: textColor);

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '4 0 4',
            style: _defaultTextStyle.copyWith(fontSize: 150),
          ),
          const SizedBox(height: 20),
          Text(
            'Page Not Found',
            style: _defaultTextStyle.copyWith(fontSize: 30),
          ),
          const SizedBox(height: 30),
          InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onHover: onLinkHovered,
            mouseCursor: SystemMouseCursors.none,
            onTap: () => context.go(RoutesPath.home),
            child: Ink(
              child: Column(
                children: [
                  Text('Back To Home', style: _defaultTextStyle),
                  const SizedBox(height: 7),
                  Container(color: textColor, width: 50, height: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The `AnimatedPointer` widget displays an animated pointer that follows the user's cursor.
///
/// It uses the `AnimatedPositioned` widget to animate the pointer's position based on the `pointerOffset`.
class AnimatedPointer extends StatelessWidget {
  const AnimatedPointer({
    Key? key,
    this.movementDuration = const Duration(milliseconds: 900),
    this.radius = 30,
    required this.pointerOffset,
  }) : super(key: key);

  final Duration movementDuration;
  final Offset pointerOffset;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: movementDuration,
      curve: Curves.easeOutExpo,
      top: pointerOffset.dy,
      left: pointerOffset.dx,
      child: CustomPaint(
        painter: Pointer(radius),
      ),
    );
  }
}

/// The `Pointer` class is a custom painter that draws the pointer for the `AnimatedPointer` widget.
class Pointer extends CustomPainter {
  final double radius;

  Pointer(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      const Offset(0, 0),
      radius,
      Paint()
        ..color = Colors.white
        ..blendMode = BlendMode.difference,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:academix/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A widget that displays the Academix logo with text based on the selected theme.
class LogoWithTextWidget extends StatelessWidget {
  /// Creates a [LogoWithTextWidget].
  ///
  /// The [key] parameter is used to provide a key for this widget.
  /// The [themeState] parameter is required and represents the current theme state.
  const LogoWithTextWidget({
    Key? key,
    required this.themeState,
  }) : super(key: key);

  /// The current theme state.
  final String themeState;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          themeState == ThemeOptions.darkTheme
              ? AssetPath.logoDarkTheme
              : themeState == ThemeOptions.mirageTheme
                  ? AssetPath.logoMirageTheme
                  : AssetPath.logoLightTheme,
          fit: BoxFit.cover,
          width: 40,
          height: 40,
        ),
        const SizedBox(
          width: 10,
        ),
        const Text(
          'Academix',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

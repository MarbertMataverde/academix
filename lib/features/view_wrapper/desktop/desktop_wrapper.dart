import 'package:academix/features/bulletin/view/desktop_bulletin_view.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:academix/constants/assets_path.dart';
import 'package:academix/constants/routes_path.dart';
import 'package:academix/features/authentication/services/sign_out_services.dart';
import 'package:academix/features/view_wrapper/widgets/navigation_button_widget.dart';

// DesktopWrapper renders the sidebar navigation and main content
/// for the desktop UI.
class DesktopWrapper extends ConsumerStatefulWidget {
  const DesktopWrapper({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DesktopWrapperState();
}

class _DesktopWrapperState extends ConsumerState<DesktopWrapper> {
  /// State provider to track selected sidebar item
  final selectedNavigationBarItemStateProvider = StateProvider<int>((ref) => 0);

  /// State provider for selected theme
  final selectedThemeStateProvider = StateProvider<int>((ref) => 0);

  @override
  Widget build(BuildContext context) {
    /// Get current selected theme
    final String themeState = ref.watch(themeStateProvider);

    return Scaffold(
      body: Row(
        children: [
          /// Sidebar container
          Container(
            width: 250,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 0.5,
                  color: _getSidebarBorderColor(themeState),
                ),
              ),
            ),
            child: _buildSidebar(themeState),
          ),

          /// Main content
          const BulletinView(),
        ],
      ),
    );
  }

  /// Builds the sidebar navigation
  Widget _buildSidebar(String themeState) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// App logo
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => context.go(RoutesPath.home),
                child: _buildLogoSection(themeState),
              ),
            ),

            /// Navigation items
            NavigationButton(
              index: 0,
              ref: ref,
              iconData: FluentIcons.news_16_regular,
              stateProvider: selectedNavigationBarItemStateProvider,
              onTap: () => ref
                  .read(selectedNavigationBarItemStateProvider.notifier)
                  .update((state) => 0),
              isActive: ref.watch(selectedNavigationBarItemStateProvider) == 0,
              label: 'Bulletin',
            ),
            NavigationButton(
              index: 1,
              stateProvider: selectedNavigationBarItemStateProvider,
              ref: ref,
              iconData: FluentIcons.megaphone_16_regular,
              onTap: () => ref
                  .read(selectedNavigationBarItemStateProvider.notifier)
                  .update((state) => 1),
              isActive: ref.watch(selectedNavigationBarItemStateProvider) == 1,
              label: 'Announcements',
            ),
            NavigationButton(
              index: 2,
              stateProvider: selectedNavigationBarItemStateProvider,
              ref: ref,
              iconData: FluentIcons.group_20_regular,
              onTap: () => ref
                  .read(selectedNavigationBarItemStateProvider.notifier)
                  .update((state) => 2),
              isActive: ref.watch(selectedNavigationBarItemStateProvider) == 2,
              label: 'Groups',
            ),
            NavigationButton(
              index: 3,
              stateProvider: selectedNavigationBarItemStateProvider,
              ref: ref,
              iconData: FluentIcons.chat_bubbles_question_16_regular,
              onTap: () => ref
                  .read(selectedNavigationBarItemStateProvider.notifier)
                  .update((state) => 3),
              isActive: ref.watch(selectedNavigationBarItemStateProvider) == 3,
              label: 'Forum',
            ),
            NavigationButton(
              index: 4,
              stateProvider: selectedNavigationBarItemStateProvider,
              ref: ref,
              iconData: FluentIcons.person_12_regular,
              onTap: () => ref
                  .read(selectedNavigationBarItemStateProvider.notifier)
                  .update((state) => 4),
              isActive: ref.watch(selectedNavigationBarItemStateProvider) == 4,
              label: 'Profile',
            ),
            NavigationButton(
              index: 5,
              stateProvider: selectedNavigationBarItemStateProvider,
              ref: ref,
              iconData: FluentIcons.settings_16_regular,
              onTap: () => ref
                  .read(selectedNavigationBarItemStateProvider.notifier)
                  .update((state) => 5),
              isActive: ref.watch(selectedNavigationBarItemStateProvider) == 5,
              label: 'Settings',
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: themeState == ThemeOptions.darkTheme
                  ? DarkThemeColors.foregroundSecondColor.withOpacity(0.2)
                  : themeState == ThemeOptions.mirageTheme
                      ? MirageThemeColors.foregroundSecondColor.withOpacity(0.2)
                      : LightThemeColors.shadowColor,
            ),
            const SizedBox(
              height: 5,
            ),

            /// Sign out button
            NavigationButton(
              index: 6,
              stateProvider: selectedNavigationBarItemStateProvider,
              ref: ref,
              iconData: FluentIcons.sign_out_20_regular,
              onTap: () async => await signOut(),
              label: 'Sign Out',
            ),
          ],
        ),
      ),
    );
  }
}

/// Returns border color for sidebar based on theme
Color _getSidebarBorderColor(String themeState) {
  if (themeState == ThemeOptions.darkTheme) {
    return DarkThemeColors.foregroundSecondColor.withOpacity(0.2);
  } else if (themeState == ThemeOptions.mirageTheme) {
    return MirageThemeColors.foregroundSecondColor.withOpacity(0.2);
  } else {
    return LightThemeColors.shadowColor;
  }
}

/// Builds the logo section
Widget _buildLogoSection(String themeState) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Animated logo image
          RepaintBoundary(
            child: SvgPicture.asset(
              _getLogoAsset(themeState),
              width: 50,
              height: 50,
            ),
          ).animate().fadeIn().slideY(),

          const SizedBox(height: 5),

          /// Animated logo text
          const RepaintBoundary(
            child: Text(
              'Academix',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ).animate().fadeIn().slideY(begin: 1),
        ],
      ),
    ),
  );
}

/// Get logo asset based on theme
String _getLogoAsset(String themeState) {
  if (themeState == ThemeOptions.darkTheme) {
    return AssetPath.logoDarkTheme;
  } else if (themeState == ThemeOptions.mirageTheme) {
    return AssetPath.logoMirageTheme;
  } else {
    return AssetPath.logoLightTheme;
  }
}

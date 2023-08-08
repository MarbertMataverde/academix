import 'package:academix/features/view_wrapper/widgets/navigation_sidebar_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';

// TabletWrapper renders the sidebar navigation and main content
/// for the desktop UI.
class TabletWrapper extends ConsumerStatefulWidget {
  const TabletWrapper({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabletWrapperState();
}

class _TabletWrapperState extends ConsumerState<TabletWrapper> {
  @override
  Widget build(BuildContext context) {
    /// Get current selected theme
    final String themeState = ref.watch(themeStateProvider);

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(
                FluentIcons.list_16_filled,
                color: themeState == ThemeOptions.darkTheme
                    ? DarkThemeColors.foregroundColor
                    : themeState == ThemeOptions.mirageTheme
                        ? MirageThemeColors.foregroundColor
                        : LightThemeColors.foregroundColor,
              ),
            );
          })),
      drawer: Drawer(
        child: buildSidebar(
          context: context,
          ref: ref,
        ),
      ),
      // I wrap list widget because each widget needs to have its own unique ID
      body: Row(
        children: [
          listOfContents[ref.watch(selectedNavigationBarItemStateProvider)],
        ],
      ),
    );
  }
}

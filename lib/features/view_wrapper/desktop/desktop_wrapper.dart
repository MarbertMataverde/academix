import 'package:academix/features/view_wrapper/widgets/navigation_sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';

// DesktopWrapper renders the sidebar navigation and main content
/// for the desktop UI.
class DesktopWrapper extends ConsumerStatefulWidget {
  const DesktopWrapper({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DesktopWrapperState();
}

class _DesktopWrapperState extends ConsumerState<DesktopWrapper> {
  @override
  Widget build(BuildContext context) {
    /// Get current selected theme
    final String themeState = ref.watch(themeStateProvider);

    return Scaffold(
      body: Row(
        children: [
          // Sidebar container
          Container(
            width: 250,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 0.5,
                  color: getSidebarBorderColor(themeState),
                ),
              ),
            ),
            child: buildSidebar(context: context, ref: ref),
          ),

          /// Main content
          listOfContents[ref.watch(selectedNavigationBarItemStateProvider)],
        ],
      ),
    );
  }
}

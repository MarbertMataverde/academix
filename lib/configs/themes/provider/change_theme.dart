import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// A function to change the user's theme and update the state.
void changeTheme({required String selectedTheme, required WidgetRef ref}) {
  ref.read(themeStateProvider.notifier).update((state) => selectedTheme);
}

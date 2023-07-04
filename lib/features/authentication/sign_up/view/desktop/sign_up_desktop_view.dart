import 'package:academix/components/custom_textformfield.dart';
import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:academix/features/authentication/sign_up/provider/genders.dart';
import 'package:academix/features/authentication/sign_up/utils/number_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DesktopSignUpView extends ConsumerWidget {
  final selectedGenderProvider = StateProvider<String?>((ref) => null);
  DesktopSignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeStateProvider);
    final mediaQuerySize = MediaQuery.of(context).size;

    final List<String> genders = [Gender.male, Gender.female];
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: mediaQuerySize.width * 0.8,
          height: mediaQuerySize.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        'To proceed, please complete the form below.',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.labelMedium!.color,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                //form
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Personal Information',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          CustomTextFormField(
                            width: mediaQuerySize.width * 0.8 / 3.1,
                            themeState: themeState,
                            hintText: 'First Name',
                            keyboardType: TextInputType.text,
                          ),
                          const Spacer(),
                          CustomTextFormField(
                            width: mediaQuerySize.width * 0.8 / 3.1,
                            themeState: themeState,
                            hintText: 'Middle Name',
                            keyboardType: TextInputType.text,
                          ),
                          const Spacer(),
                          CustomTextFormField(
                            width: mediaQuerySize.width * 0.8 / 3.1,
                            themeState: themeState,
                            hintText: 'Last Name',
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          CustomTextFormField(
                            width: mediaQuerySize.width * 0.8 / 3.1,
                            themeState: themeState,
                            inputFomater: numberFormater,
                            hintText: 'Contact Number',
                            keyboardType: TextInputType.number,
                          ),
                          const Spacer(),
                          CustomTextFormField(
                            width: mediaQuerySize.width * 0.8 / 2.1,
                            themeState: themeState,
                            hintText: 'Address',
                            keyboardType: TextInputType.text,
                          ),
                          const Spacer(),
                          Container(
                            width: mediaQuerySize.width * 0.8 / 6,
                            height: 50,
                            decoration: BoxDecoration(
                              color: themeState == ThemeOptions.darkTheme
                                  ? DarkThemeColors.buttonBackgroundColor
                                  : themeState == ThemeOptions.mirageTheme
                                      ? MirageThemeColors.buttonBackgroundColor
                                      : LightThemeColors
                                          .buttonBackgroundColor, // Fill color
                              border: themeState == ThemeOptions.lightTheme
                                  ? Border.all(
                                      color: LightThemeColors.shadowColor,
                                      width: 0.5)
                                  : null,
                              // Border color
                              borderRadius: BorderRadius.circular(
                                  8), // Optional border radius
                            ),
                            child: DropdownButton<String>(
                              dropdownColor: themeState ==
                                      ThemeOptions.darkTheme
                                  ? DarkThemeColors.buttonBackgroundColor
                                  : themeState == ThemeOptions.mirageTheme
                                      ? MirageThemeColors.buttonBackgroundColor
                                      : LightThemeColors.buttonBackgroundColor,
                              value: ref.watch(selectedGenderProvider),
                              borderRadius: BorderRadius.circular(8),
                              elevation: 1,
                              items: genders.map((String gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Center(child: Text(gender)),
                                );
                              }).toList(),
                              onChanged: (String? selectedValue) => ref
                                  .read(selectedGenderProvider.notifier)
                                  .update((state) => selectedValue),
                              hint: const Center(child: Text('Gender')),
                              isExpanded: true,
                              underline:
                                  Container(), // Remove the default underline
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

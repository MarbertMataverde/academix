import 'package:academix/configs/themes/styles/button_style.dart';
import 'package:academix/constants/agreement_message.dart';
import 'package:academix/features/authentication/sign_up/widgets/appbar_arrow_back_widget.dart';
import 'package:academix/features/authentication/sign_up/widgets/custom_suffix_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:academix/components/custom_textformfield.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:academix/features/authentication/sign_up/provider/colleges.dart';
import 'package:academix/features/authentication/sign_up/provider/genders.dart';
import 'package:academix/features/authentication/sign_up/utils/number_formater.dart';
import 'package:academix/features/authentication/sign_up/widgets/custom_dropdownbutton_widget.dart';

class PhoneSignUpView extends ConsumerWidget {
  // Selected gender state provider
  final selectedGenderStateProvider = StateProvider<String?>((ref) => null);
  // Selected college state provider
  final selectedCollegeStateProvider = StateProvider<String?>((ref) => null);
  // Password visibility state provider
  final isPasswordVisibleStateProvider = StateProvider<bool>((ref) => false);

  PhoneSignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeStateProvider);
    final mediaQuerySize = MediaQuery.of(context).size;

    // List of genders
    final List<String> listOfGenders = [Gender.male, Gender.female];

    // List of colleges
    final List<String> listOfColleges = [College.coa, College.cob, College.ccs];

    return Scaffold(
      appBar: signUpArrowBackWidget(context, themeState),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
          child: SingleChildScrollView(
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
                const SizedBox(height: 20),
                const Text(
                  'Personal Information',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  themeState: themeState,
                  hintText: 'First Name',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  themeState: themeState,
                  hintText: 'Middle Name',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  themeState: themeState,
                  hintText: 'Last Name',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  themeState: themeState,
                  inputFomater: numberFormater,
                  hintText: 'Contact Number',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  themeState: themeState,
                  hintText: 'Full Address',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                CustomDropdownButtonWidget(
                  width: double.infinity,
                  ref: ref,
                  listOfItems: listOfGenders,
                  hint: 'Gender',
                  value: ref.watch(selectedGenderStateProvider),
                  valueStateProvider: selectedGenderStateProvider,
                  mediaQuerySize: mediaQuerySize,
                  themeState: themeState,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Student Information
                const Text(
                  'Student Information',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  themeState: themeState,
                  inputFomater: numberFormater,
                  hintText: 'Student Number',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDropdownButtonWidget(
                  ref: ref,
                  width: double.infinity,
                  listOfItems: listOfColleges,
                  hint: 'College',
                  value: ref.watch(selectedCollegeStateProvider),
                  valueStateProvider: selectedCollegeStateProvider,
                  mediaQuerySize: mediaQuerySize,
                  themeState: themeState,
                ),
                const SizedBox(height: 20),
                // Account Information
                const Text(
                  'Account Information',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  themeState: themeState,
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  themeState: themeState,
                  hintText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !ref.watch(isPasswordVisibleStateProvider),
                  suffixIcon: CustomSuffixIconWidget(
                    themeState: themeState,
                    ref: ref,
                    stateProvider: isPasswordVisibleStateProvider,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  themeState: themeState,
                  hintText: 'Confirm Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !ref.watch(isPasswordVisibleStateProvider),
                  suffixIcon: CustomSuffixIconWidget(
                    themeState: themeState,
                    ref: ref,
                    stateProvider: isPasswordVisibleStateProvider,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  AgreementMessage.signUpAgreementMessage,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: elevatedButtonStyle(
                      buttonWidth: 200,
                      buttonHeight: 45,
                      themeState: themeState,
                    ),
                    onPressed: () {},
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

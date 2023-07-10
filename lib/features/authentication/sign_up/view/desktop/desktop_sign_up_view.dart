import 'package:academix/components/custom_dialog_box.dart';
import 'package:academix/components/dialog_box_button.dart';
import 'package:academix/configs/themes/styles/button_style.dart';
import 'package:academix/constants/agreement_message.dart';
import 'package:academix/constants/dialog_box_sizes.dart';
import 'package:academix/constants/routes_path.dart';
import 'package:academix/constants/sign_up_message_constant.dart';
import 'package:academix/features/authentication/services/email_sign_up_services.dart';
import 'package:academix/features/authentication/sign_up/widgets/create_account_text_animation_widget.dart';
import 'package:academix/features/authentication/sign_up/widgets/custom_suffix_icon_widget.dart';
import 'package:academix/features/authentication/validator/field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:academix/components/custom_textformfield.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:academix/features/authentication/sign_up/constants/colleges.dart';
import 'package:academix/features/authentication/sign_up/constants/genders.dart';
import 'package:academix/features/authentication/sign_up/utils/number_formater.dart';
import 'package:academix/features/authentication/sign_up/widgets/custom_dropdownbutton_widget.dart';
import 'package:go_router/go_router.dart';

// View for the desktop sign-up screen
class DesktopSignUpView extends ConsumerStatefulWidget {
  const DesktopSignUpView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DesktopSignUpViewState();
}

// State for the desktop sign-up screen
class _DesktopSignUpViewState extends ConsumerState<DesktopSignUpView> {
  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Password visibility state provider
  final isPasswordVisibleStateProvider = StateProvider<bool>((ref) => false);

  // Personal Information Controllers & Provider
  late final TextEditingController userFirstName;
  late final TextEditingController userMiddleName;
  late final TextEditingController userLastName;
  late final TextEditingController userContactNumber;
  late final TextEditingController userFullAddress;
  final selectedGenderStateProvider = StateProvider<String?>((ref) => null);

  // Student Information Controllers & Provider
  late final TextEditingController userStudentNumber;
  final selectedCollegeStateProvider = StateProvider<String?>((ref) => null);

  // Account Information Controllers
  late final TextEditingController userEmailAddress;
  late final TextEditingController userPassword;
  late final TextEditingController userConfirmedPassword;

  @override
  void initState() {
    super.initState();
    // Initialize controllers for Personal Information
    userFirstName = TextEditingController();
    userMiddleName = TextEditingController();
    userLastName = TextEditingController();
    userContactNumber = TextEditingController();
    userFullAddress = TextEditingController();

    // Initialize controllers for Student Information
    userStudentNumber = TextEditingController();

    // Initialize controllers for Account Information
    userEmailAddress = TextEditingController();
    userPassword = TextEditingController();
    userConfirmedPassword = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose controllers for Personal Information
    userFirstName.dispose();
    userMiddleName.dispose();
    userLastName.dispose();
    userContactNumber.dispose();
    userFullAddress.dispose();

    // Dispose controllers for Student Information
    userStudentNumber.dispose();

    // Dispose controllers for Account Information
    userEmailAddress.dispose();
    userPassword.dispose();
    userConfirmedPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeStateProvider);
    final mediaQuerySize = MediaQuery.of(context).size;
    // List of genders
    final List<String> listOfGenders = [Gender.male, Gender.female];
    // List of colleges
    final List<String> listOfColleges = [College.coa, College.cob, College.ccs];

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: mediaQuerySize.width * 0.8,
          height: mediaQuerySize.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                  const SizedBox(height: 30),
                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Personal Information
                        const Text(
                          'Personal Information',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // First Name field
                            CustomTextFormField(
                              controller: userFirstName,
                              width: mediaQuerySize.width * 0.8 / 3.1,
                              ref: ref,
                              hintText: 'First Name',
                              keyboardType: TextInputType.text,
                              validator: (value) => firstNameValidator(value),
                            ),
                            const Spacer(),
                            // Middle Name field
                            CustomTextFormField(
                              controller: userMiddleName,
                              width: mediaQuerySize.width * 0.8 / 3.1,
                              ref: ref,
                              hintText: 'Middle Name',
                              keyboardType: TextInputType.text,
                              validator: (value) => middleNameValidator(value),
                            ),
                            const Spacer(),
                            // Last Name field
                            CustomTextFormField(
                              controller: userLastName,
                              width: mediaQuerySize.width * 0.8 / 3.1,
                              ref: ref,
                              hintText: 'Last Name',
                              keyboardType: TextInputType.text,
                              validator: (value) => lastNameValidator(value),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Contact Number field
                            CustomTextFormField(
                              controller: userContactNumber,
                              width: mediaQuerySize.width * 0.8 / 3.1,
                              ref: ref,
                              inputFomater: numberFormater,
                              hintText: 'Contact Number',
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  contactNumberValidator(value),
                            ),
                            const Spacer(),
                            // Full Address field
                            CustomTextFormField(
                              controller: userFullAddress,
                              width: mediaQuerySize.width * 0.8 / 2.1,
                              ref: ref,
                              hintText: 'Full Address',
                              keyboardType: TextInputType.text,
                              validator: (value) => fullAddressValidator(value),
                            ),
                            const Spacer(),
                            // Gender dropdown
                            CustomDropdownButtonWidget(
                              ref: ref,
                              listOfItems: listOfGenders,
                              hint: 'Gender',
                              value: ref.watch(selectedGenderStateProvider),
                              valueStateProvider: selectedGenderStateProvider,
                              mediaQuerySize: mediaQuerySize,
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Student Information
                                const Text(
                                  'Student Information',
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(height: 10),
                                // Student Number field
                                CustomTextFormField(
                                  controller: userStudentNumber,
                                  width: mediaQuerySize.width * 0.8 / 2.1,
                                  ref: ref,
                                  inputFomater: numberFormater,
                                  hintText: 'Student Number',
                                  keyboardType: TextInputType.number,
                                  validator: (value) =>
                                      studentNumberValidator(value),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // College dropdown
                                CustomDropdownButtonWidget(
                                  width: mediaQuerySize.width * 0.8 / 2.1,
                                  ref: ref,
                                  listOfItems: listOfColleges,
                                  hint: 'College',
                                  value:
                                      ref.watch(selectedCollegeStateProvider),
                                  valueStateProvider:
                                      selectedCollegeStateProvider,
                                  mediaQuerySize: mediaQuerySize,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Account Information
                                const Text(
                                  'Account Information',
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Email Address field
                                CustomTextFormField(
                                  controller: userEmailAddress,
                                  width: mediaQuerySize.width * 0.8 / 2.1,
                                  ref: ref,
                                  hintText: 'Email Address',
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) => emailValidator(value),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Password field
                                CustomTextFormField(
                                  controller: userPassword,
                                  width: mediaQuerySize.width * 0.8 / 2.1,
                                  ref: ref,
                                  hintText: 'Password',
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) =>
                                      passwordValidator(value),
                                  obscureText: !ref
                                      .watch(isPasswordVisibleStateProvider),
                                  suffixIcon: CustomSuffixIconWidget(
                                    ref: ref,
                                    stateProvider:
                                        isPasswordVisibleStateProvider,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Confirm Password field
                                CustomTextFormField(
                                  controller: userConfirmedPassword,
                                  width: mediaQuerySize.width * 0.8 / 2.1,
                                  ref: ref,
                                  hintText: 'Confirm Password',
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (userPassword.text ==
                                        userConfirmedPassword.text) {
                                      return passwordValidator(value);
                                    } else {
                                      return 'Password did not match.';
                                    }
                                  },
                                  obscureText: !ref
                                      .watch(isPasswordVisibleStateProvider),
                                  suffixIcon: CustomSuffixIconWidget(
                                    ref: ref,
                                    stateProvider:
                                        isPasswordVisibleStateProvider,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
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
                              ref: ref,
                              buttonWidth: 200,
                              buttonHeight: 50,
                            ),
                            onPressed: () async {
                              Future.delayed(
                                const Duration(seconds: 2),
                                () {},
                              );
                              const String dialogTitle =
                                  'Missing Required Information';

                              if (_formKey.currentState!.validate()) {
                                // If the gender is not null
                                if (ref.read(selectedGenderStateProvider) !=
                                    null) {
                                  // if the college is not null
                                  if (ref.read(selectedCollegeStateProvider) !=
                                      null) {
                                    // Creating account text animation
                                    creatingAccountTextAnimation(
                                      context,
                                      themeState,
                                    );

                                    // All fields are valid, proceed with account creation
                                    await emailSignUp(
                                      userFirstName:
                                          userFirstName.value.text.trim(),
                                      userMiddleName:
                                          userMiddleName.value.text.trim(),
                                      userLastName:
                                          userLastName.value.text.trim(),
                                      userContactNumber: int.parse(
                                          userContactNumber.value.text.trim()),
                                      userFullAddress:
                                          userFullAddress.value.text.trim(),
                                      userGender: ref.read(
                                              selectedGenderStateProvider) ??
                                          'Gender',
                                      userStudentNumber: int.parse(
                                          userStudentNumber.value.text.trim()),
                                      userCollege: ref.read(
                                              selectedCollegeStateProvider) ??
                                          'College',
                                      userEmail:
                                          userEmailAddress.value.text.trim(),
                                      userPassword:
                                          userPassword.value.text.trim(),
                                      ref: ref,
                                      context: context,
                                    ).whenComplete(
                                      () {
                                        // this will close the animated text dialog
                                        context.pop();
                                        // this will replace the animated text dialog
                                        customDialogBox(
                                          context: context,
                                          ref: ref,
                                          title: SignUpMessage
                                              .accountCreatedDialogTitle,
                                          message: SignUpMessage
                                              .accountCreatedDialogMessage,
                                          width: DialogBoxSize.desktopWidth,
                                          height: DialogBoxSize.desktopHeight,
                                          isWithCloseIconButton: false,
                                          widget: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: DialogBoxButton(
                                              ref: ref,
                                              label: 'Okay',
                                              onPressed: () {
                                                context.pop();
                                                context
                                                    .replace(RoutesPath.home);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    // Show dialog for empty college selection
                                    customDialogBox(
                                      context: context,
                                      ref: ref,
                                      title: dialogTitle,
                                      message: 'Please select your college.',
                                      width: DialogBoxSize.desktopWidth,
                                      height: DialogBoxSize.desktopHeight,
                                    );
                                  }
                                } else {
                                  // Show dialog for empty gender selection
                                  customDialogBox(
                                    context: context,
                                    ref: ref,
                                    title: dialogTitle,
                                    message: 'Please select your gender.',
                                    width: DialogBoxSize.desktopWidth,
                                    height: DialogBoxSize.desktopHeight,
                                  );
                                }
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

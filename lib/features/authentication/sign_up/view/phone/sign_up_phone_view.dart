import 'package:academix/components/custom_dialog_box.dart';
import 'package:academix/components/dialog_box_button.dart';
import 'package:academix/configs/themes/styles/button_style.dart';
import 'package:academix/constants/agreement_message.dart';
import 'package:academix/constants/dialog_box_sizes.dart';
import 'package:academix/constants/routes_path.dart';
import 'package:academix/constants/sign_up_message_constant.dart';
import 'package:academix/features/authentication/services/email_sign_up_services.dart';
import 'package:academix/features/authentication/sign_up/widgets/appbar_arrow_back_widget.dart';
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

class PhoneSignUpView extends ConsumerStatefulWidget {
  const PhoneSignUpView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PhoneSignUpViewState();
}

class _PhoneSignUpViewState extends ConsumerState<PhoneSignUpView> {
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
      appBar: signUpArrowBackWidget(context, themeState),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                    controller: userFirstName,
                    ref: ref,
                    hintText: 'First Name',
                    keyboardType: TextInputType.text,
                    validator: (value) => firstNameValidator(value),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: userMiddleName,
                    ref: ref,
                    hintText: 'Middle Name',
                    keyboardType: TextInputType.text,
                    validator: (value) => middleNameValidator(value),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: userLastName,
                    ref: ref,
                    hintText: 'Last Name',
                    keyboardType: TextInputType.text,
                    validator: (value) => lastNameValidator(value),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: userContactNumber,
                    ref: ref,
                    inputFomater: numberFormater,
                    hintText: 'Contact Number',
                    keyboardType: TextInputType.number,
                    validator: (value) => contactNumberValidator(value),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: userFullAddress,
                    ref: ref,
                    hintText: 'Full Address',
                    keyboardType: TextInputType.text,
                    validator: (value) => fullAddressValidator(value),
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
                    controller: userStudentNumber,
                    ref: ref,
                    inputFomater: numberFormater,
                    hintText: 'Student Number',
                    keyboardType: TextInputType.number,
                    validator: (value) => studentNumberValidator(value),
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
                  ),
                  const SizedBox(height: 20),
                  // Account Information
                  const Text(
                    'Account Information',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: userEmailAddress,
                    ref: ref,
                    hintText: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => emailValidator(value),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: userPassword,
                    ref: ref,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !ref.watch(isPasswordVisibleStateProvider),
                    validator: (value) => passwordValidator(value),
                    suffixIcon: CustomSuffixIconWidget(
                      ref: ref,
                      stateProvider: isPasswordVisibleStateProvider,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: userConfirmedPassword,
                    ref: ref,
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !ref.watch(isPasswordVisibleStateProvider),
                    validator: (value) {
                      if (userPassword.text == userConfirmedPassword.text) {
                        return passwordValidator(value);
                      } else {
                        return 'Password did not match.';
                      }
                    },
                    suffixIcon: CustomSuffixIconWidget(
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
                        ref: ref,
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
                          if (ref.read(selectedGenderStateProvider) != null) {
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
                                userFirstName: userFirstName.value.text.trim(),
                                userMiddleName:
                                    userMiddleName.value.text.trim(),
                                userLastName: userLastName.value.text.trim(),
                                userContactNumber: int.parse(
                                    userContactNumber.value.text.trim()),
                                userFullAddress:
                                    userFullAddress.value.text.trim(),
                                userGender:
                                    ref.read(selectedGenderStateProvider) ??
                                        'Gender',
                                userStudentNumber: int.parse(
                                    userStudentNumber.value.text.trim()),
                                userCollege:
                                    ref.read(selectedCollegeStateProvider) ??
                                        'College',
                                userEmail: userEmailAddress.value.text.trim(),
                                userPassword: userPassword.value.text.trim(),
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
                                    title:
                                        SignUpMessage.accountCreatedDialogTitle,
                                    message: SignUpMessage
                                        .accountCreatedDialogMessage,
                                    width: DialogBoxSize.phoneWidth,
                                    height: DialogBoxSize.phoneHeight,
                                    isWithCloseIconButton: false,
                                    widget: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: DialogBoxButton(
                                        ref: ref,
                                        label: 'Okay',
                                        onPressed: () {
                                          context.pop();
                                          context.replace(RoutesPath.home);
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
                                width: DialogBoxSize.phoneWidth,
                                height: DialogBoxSize.phoneHeight,
                              );
                            }
                          } else {
                            // Show dialog for empty gender selection
                            customDialogBox(
                              context: context,
                              ref: ref,
                              title: dialogTitle,
                              message: 'Please select your gender.',
                              width: DialogBoxSize.phoneWidth,
                              height: DialogBoxSize.phoneHeight,
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
          ),
        ),
      ),
    );
  }
}

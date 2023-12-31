import 'package:academix/components/custom_dialog_box.dart';
import 'package:academix/configs/themes/provider/change_theme.dart';
import 'package:academix/configs/themes/provider/save_user_theme.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:academix/configs/themes/styles/button_style.dart';
import 'package:academix/components/custom_textformfield.dart';
import 'package:academix/constants/dialog_box_sizes.dart';
import 'package:academix/features/authentication/services/sign_in_services.dart';
import 'package:academix/features/authentication/sign_in/widgets/authenticating_spinner_widget.dart';
import 'package:academix/features/authentication/sign_in/widgets/divider_widget.dart';
import 'package:academix/features/authentication/sign_in/view/desktop/widgets/logo_with_text_desktop_widget.dart';
import 'package:academix/features/authentication/sign_in/widgets/forgot_password_text_button.dart';
import 'package:academix/features/authentication/sign_in/widgets/sign_up_text_widget.dart';
import 'package:academix/features/authentication/sign_up/widgets/custom_suffix_icon_widget.dart';
import 'package:academix/features/authentication/validator/field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The desktop view of the sign-in screen.
class DesktopSignInView extends ConsumerStatefulWidget {
  const DesktopSignInView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DesktopViewState();
}

class _DesktopViewState extends ConsumerState<DesktopSignInView> {
  // isAuthenticating
  final isAuthenticating = StateProvider<bool>((ref) => false);

  // isPasswordVisible
  final isPasswordVisible = StateProvider<bool>((ref) => false);

  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController userEmailAddress;
  late final TextEditingController userPassword;

  @override
  void initState() {
    super.initState();
    userEmailAddress = TextEditingController();
    userPassword = TextEditingController();
  }

  @override
  void dispose() {
    userEmailAddress.dispose();
    userPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeStateProvider);

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 40),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: LogoWithTextWidget(themeState: themeState),
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    width: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          'Sign in to your account',
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.labelMedium!.color,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: elevatedButtonStyle(ref: ref),
                            onPressed: () => customDialogBox(
                              context: context,
                              ref: ref,
                              title: 'Feature Coming Soon',
                              message:
                                  'We regret to inform you that the Google Sign-In feature has not been implemented yet. We apologize for any inconvenience caused and assure you that we are working diligently to make it available as soon as possible. Thank you for your understanding.',
                              width: DialogBoxSize.desktopWidth,
                              height: DialogBoxSize.desktopHeight,
                            ),
                            child: const Text('Continue with Google'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        DividerWidget(themeState: themeState),
                        const SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextFormField(
                                controller: userEmailAddress,
                                ref: ref,
                                hintText: 'Academix@email.edu',
                                keyboardType: TextInputType.emailAddress,
                                onFieldSubmited: (_) async =>
                                    await signInFunction(context),
                                validator: (value) => emailValidator(value),
                              ),
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                controller: userPassword,
                                obscureText: !ref.watch(isPasswordVisible),
                                ref: ref,
                                hintText: 'Password',
                                keyboardType: TextInputType.visiblePassword,
                                onFieldSubmited: (_) async =>
                                    await signInFunction(context),
                                suffixIcon: CustomSuffixIconWidget(
                                  ref: ref,
                                  stateProvider: isPasswordVisible,
                                ),
                                validator: (value) =>
                                    signInPasswordValidator(value),
                              ),
                            ],
                          ),
                        ),
                        const ForgotPasswordTextButtonWidget(),
                        const SizedBox(height: 30),
                        ref.watch(isAuthenticating)
                            ? AuthenticatingSpinnerWidget(
                                themeState: themeState)
                            : SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: elevatedButtonStyle(ref: ref),
                                  onPressed: () async =>
                                      await signInFunction(context),
                                  child: const Text('Sign In'),
                                ),
                              ),
                        const SizedBox(height: 40),
                        const SignUpTextWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Change Theme'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          changeTheme(
                              selectedTheme: ThemeOptions.lightTheme, ref: ref);
                          await saveUserTheme(ref);
                        },
                        icon: const Icon(Icons.light_mode),
                      ),
                      IconButton(
                        onPressed: () async {
                          changeTheme(
                              selectedTheme: ThemeOptions.darkTheme, ref: ref);
                          await saveUserTheme(ref);
                        },
                        icon: const Icon(Icons.dark_mode),
                      ),
                      IconButton(
                        onPressed: () async {
                          changeTheme(
                              selectedTheme: ThemeOptions.mirageTheme,
                              ref: ref);
                          await saveUserTheme(ref);
                        },
                        icon: const Icon(Icons.location_city),
                      ),
                    ],
                  ),
                  const Text(
                    '“There are no shortcuts to any place worth going.”',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Text('— Beverly Stills'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signInFunction(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      ref.read(isAuthenticating.notifier).update((state) => true);

      await signIn(
        userEmail: userEmailAddress.value.text.trim(),
        userPassword: userPassword.value.text,
        context: context,
        ref: ref,
      );

      ref.read(isAuthenticating.notifier).update((state) => false);
    }
  }
}

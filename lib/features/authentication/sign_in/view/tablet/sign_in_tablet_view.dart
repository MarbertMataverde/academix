import 'package:academix/components/custom_dialog_box.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:academix/configs/themes/styles/button_style.dart';
import 'package:academix/constants/assets_path.dart';
import 'package:academix/components/custom_textformfield.dart';
import 'package:academix/constants/dialog_box_sizes.dart';
import 'package:academix/features/authentication/services/sign_in_services.dart';
import 'package:academix/features/authentication/sign_in/widgets/authenticating_spinner_widget.dart';
import 'package:academix/features/authentication/sign_in/widgets/divider_widget.dart';
import 'package:academix/features/authentication/sign_in/widgets/sign_up_text_widget.dart';
import 'package:academix/features/authentication/sign_up/widgets/custom_suffix_icon_widget.dart';
import 'package:academix/features/authentication/validator/field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabletSignInView extends ConsumerStatefulWidget {
  const TabletSignInView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TabletSignInViewState();
}

class _TabletSignInViewState extends ConsumerState<TabletSignInView> {
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
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 400,
            child: Column(
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
                const SizedBox(height: 20),
                const Text(
                  'Welcome back',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  'Sign in to your account',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.labelMedium!.color,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: elevatedButtonStyle(themeState: themeState),
                    onPressed: () => customDialogBox(
                      context: context,
                      ref: ref,
                      themeState: themeState,
                      title: 'Feature Coming Soon',
                      message:
                          'We regret to inform you that the Google Sign-In feature has not been implemented yet. We apologize for any inconvenience caused and assure you that we are working diligently to make it available as soon as possible. Thank you for your understanding.',
                      width: DialogBoxSize.tabletWidth,
                      height: DialogBoxSize.tabletHeight,
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
                        themeState: themeState,
                        hintText: 'Academix@email.edu',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => emailValidator(value),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        controller: userPassword,
                        obscureText: !ref.watch(isPasswordVisible),
                        themeState: themeState,
                        hintText: 'Password',
                        suffixIcon: CustomSuffixIconWidget(
                          ref: ref,
                          stateProvider: isPasswordVisible,
                          themeState: themeState,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) => signInPasswordValidator(value),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    hoverColor: Colors.transparent,
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text('Forgot Password?'),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ref.watch(isAuthenticating)
                    ? AuthenticatingSpinnerWidget(themeState: themeState)
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: elevatedButtonStyle(themeState: themeState),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              ref
                                  .read(isAuthenticating.notifier)
                                  .update((state) => true);

                              await signIn(
                                userEmail: userEmailAddress.value.text.trim(),
                                userPassword: userPassword.value.text,
                                context: context,
                                ref: ref,
                                themeState: themeState,
                              );

                              ref
                                  .read(isAuthenticating.notifier)
                                  .update((state) => false);
                            }
                          },
                          child: const Text('Sign In'),
                        ),
                      ),
                const SizedBox(height: 40),
                const SignUpTextWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

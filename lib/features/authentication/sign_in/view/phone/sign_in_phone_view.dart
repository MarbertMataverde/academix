import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:academix/configs/themes/styles/button_style.dart';
import 'package:academix/constants/assets_path.dart';
import 'package:academix/components/custom_textformfield.dart';
import 'package:academix/features/authentication/sign_in/widgets/divider_widget.dart';
import 'package:academix/features/authentication/sign_in/widgets/sign_up_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A widget that represents the phone view of the sign-in screen.
class PhoneSignInView extends ConsumerWidget {
  const PhoneSignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeStateProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                      onPressed: () {},
                      child: const Text('Continue with Google'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DividerWidget(themeState: themeState),
                  const SizedBox(height: 20),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          themeState: themeState,
                          hintText: 'Academix@email.com',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          obscureText: true,
                          themeState: themeState,
                          hintText: 'Password',
                          keyboardType: TextInputType.visiblePassword,
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: elevatedButtonStyle(themeState: themeState),
                      onPressed: () {},
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
      ),
    );
  }
}

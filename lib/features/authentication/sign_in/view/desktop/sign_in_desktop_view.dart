import 'package:academix/configs/themes/provider/change_theme.dart';
import 'package:academix/configs/themes/provider/save_user_theme.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:academix/configs/themes/styles/button_style.dart';
import 'package:academix/components/custom_textformfield.dart';
import 'package:academix/features/authentication/sign_in/widgets/divider_widget.dart';
import 'package:academix/features/authentication/sign_in/view/desktop/widgets/logo_with_text_desktop_widget.dart';
import 'package:academix/features/authentication/sign_in/widgets/sign_up_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The desktop view of the sign-in screen.
class DesktopView extends ConsumerStatefulWidget {
  const DesktopView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DesktopViewState();
}

class _DesktopViewState extends ConsumerState<DesktopView> {
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
}

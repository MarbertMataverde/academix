import 'package:academix/components/custom_textformfield.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:academix/configs/themes/styles/button_style.dart';
import 'package:academix/constants/forgot_password_message_constant.dart';
import 'package:academix/features/authentication/services/reset_password_services.dart';
import 'package:academix/features/authentication/sign_in/widgets/authenticating_spinner_widget.dart';
import 'package:academix/features/authentication/validator/field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DesktopForgotPassword extends ConsumerStatefulWidget {
  const DesktopForgotPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DesktopForgotPassword();
}

class _DesktopForgotPassword extends ConsumerState<DesktopForgotPassword> {
  // isAuthenticating
  final isAuthenticating = StateProvider<bool>((ref) => false);

  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController userEmailAddress;

  @override
  void initState() {
    super.initState();
    userEmailAddress = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final String themeState = ref.watch(themeStateProvider);
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                ForgotPasswordMessage.title,
                textScaleFactor: 3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                ForgotPasswordMessage.message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: CustomTextFormField(
                  ref: ref,
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => emailValidator(value),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ref.watch(isAuthenticating)
                  ? AuthenticatingSpinnerWidget(themeState: themeState)
                  : SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        style: elevatedButtonStyle(ref: ref),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            ref
                                .read(isAuthenticating.notifier)
                                .update((state) => true);

                            await resetPassword(
                              userEmail: userEmailAddress.value.text.trim(),
                              context: context,
                              ref: ref,
                            );

                            ref
                                .read(isAuthenticating.notifier)
                                .update((state) => false);
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

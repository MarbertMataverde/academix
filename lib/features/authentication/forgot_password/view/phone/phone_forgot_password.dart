import 'package:academix/components/custom_textformfield.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:academix/configs/themes/styles/button_style.dart';
import 'package:academix/constants/forgot_password_message_constant.dart';
import 'package:academix/features/authentication/services/reset_password_services.dart';
import 'package:academix/features/authentication/sign_in/widgets/authenticating_spinner_widget.dart';
import 'package:academix/features/authentication/sign_up/widgets/appbar_arrow_back_widget.dart';
import 'package:academix/features/authentication/validator/field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneForgotPassword extends ConsumerStatefulWidget {
  const PhoneForgotPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhoneForgotPassword();
}

class _PhoneForgotPassword extends ConsumerState<PhoneForgotPassword> {
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
      appBar: appBarArrowBackWidget(context, ref),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                ForgotPasswordMessage.title,
                textScaleFactor: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                ForgotPasswordMessage.message,
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
                  : Center(
                      child: SizedBox(
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
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

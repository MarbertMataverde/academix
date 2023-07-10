import 'package:academix/components/custom_dialog_box.dart';
import 'package:academix/constants/error_messages.dart';
import 'package:academix/features/authentication/temporary_bug_fixes/sign_in_fix/parse_exeption_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> resetPassword({
  required String userEmail,
  required WidgetRef ref,
  required BuildContext context,
}) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: userEmail);
  } on FirebaseAuthException catch (e) {
    // Temporary Fix
    final code = parseFirebaseAuthExceptionMessage(input: e.message);
    switch (code) {
      case 'missing-email':
        customDialogBox(
            ref: ref,
            context: context,
            title: 'User Not Found',
            message: ResetPasswordMessage.userNotFoundMessage);
        break;
      case 'too-many-requests':
        customDialogBox(
            ref: ref,
            context: context,
            title: 'Too Many Request',
            message: ResetPasswordMessage.tooManyRequestMessage);
        break;
      case 'network-request-failed':
        customDialogBox(
            ref: ref,
            context: context,
            title: 'No Internet Connection',
            message: ResetPasswordMessage.networkRequestFailedMessage);
        break;
      default:
        customDialogBox(
            ref: ref,
            context: context,
            title: code, // temporary fix
            message: e.message.toString());
    }
  } catch (error) {
    customDialogBox(
      ref: ref,
      context: context,
      title: 'Something Went Wrong',
      message: error.toString(),
    );
  }
}

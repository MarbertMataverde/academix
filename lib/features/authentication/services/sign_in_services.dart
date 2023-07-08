import 'package:academix/components/custom_dialog_box.dart';
import 'package:academix/constants/error_messages.dart';
import 'package:academix/features/authentication/temporary_bug_fixes/sign_in_fix/parse_exeption_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO always check about firebase auth error code bug issue

/// Bug: [firebase_auth] signInWithEmailAndPassword returns error code "unknown"
/// https://github.com/firebase/flutterfire/issues/10966

/// Temporary Fix:
/// Use the parseFirebaseAuthExceptionMessage function
/// It is a regex that will extract the code of a FirebaseAuthException from the exception message:

Future<void> signIn({
  required String userEmail,
  required String userPassword,
  required BuildContext context,
  required WidgetRef ref,
  required String themeState,
}) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );
  } on FirebaseAuthException catch (e) {
    // Temporary Fix
    final code = parseFirebaseAuthExceptionMessage(input: e.message);
    switch (code) {
      case 'wrong-password':
        customDialogBox(
            ref: ref,
            themeState: themeState,
            context: context,
            title: 'Wrong Password',
            message: ErrorMessage.wrongPasswordMessage);
        break;
      case 'user-not-found':
        customDialogBox(
            ref: ref,
            themeState: themeState,
            context: context,
            title: 'User Not Found',
            message: ErrorMessage.userNotFoundMessage);
        break;
      case 'user-disabled':
        customDialogBox(
            ref: ref,
            themeState: themeState,
            context: context,
            title: 'User Disabled',
            message: ErrorMessage.userDisabledMessage);
        break;
      case 'too-many-requests':
        customDialogBox(
            ref: ref,
            themeState: themeState,
            context: context,
            title: 'Too Many Request',
            message: ErrorMessage.tooManyRequestMessage);
        break;
      case 'network-request-failed':
        customDialogBox(
            ref: ref,
            themeState: themeState,
            context: context,
            title: 'No Internet Connection',
            message: ErrorMessage.networkRequestFailedMessage);
        break;
      default:
        customDialogBox(
            ref: ref,
            themeState: themeState,
            context: context,
            title: code, // temporary fix
            message: e.message.toString());
    }
  } catch (error) {
    customDialogBox(
      ref: ref,
      themeState: themeState,
      context: context,
      title: 'Something Went Wrong',
      message: error.toString(),
    );
  }
}

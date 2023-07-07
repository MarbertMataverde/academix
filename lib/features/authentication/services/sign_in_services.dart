import 'package:academix/components/custom_dialog_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    customDialogBox(
      context: context,
      ref: ref,
      themeState: themeState,
      title: 'Something is not right.',
      message: '${e.message}',
      width: 300,
      height: 300,
    );
  }
}

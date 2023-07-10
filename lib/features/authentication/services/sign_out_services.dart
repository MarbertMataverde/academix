import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<void> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
  } on FirebaseAuthException catch (e) {
    debugPrint('Failed with error code: ${e.code}');
    debugPrint(e.message);
  }
}

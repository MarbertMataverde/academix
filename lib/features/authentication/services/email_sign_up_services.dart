import 'package:academix/components/custom_dialog_box.dart';
import 'package:academix/constants/account_document_field_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Performs the sign-up process using email and password.
///
/// The `emailSignUp` function creates an account in Firebase Authentication with the provided email and password. It also stores additional user information in the Firestore database.
/// This function is responsible for handling the sign-up process and displaying error messages in case of any failures.
///
/// Parameters:
/// - `userFirstName`: The first name of the user.
/// - `userMiddleName`: The middle name of the user.
/// - `userLastName`: The last name of the user.
/// - `userContactNumber`: The contact number of the user.
/// - `userFullAddress`: The full address of the user.
/// - `userGender`: The gender of the user.
/// - `userStudentNumber`: The student number of the user.
/// - `userCollege`: The college of the user.
/// - `userEmail`: The email address for the user's account.
/// - `userPassword`: The password for the user's account.
/// - `ref`: The widget reference used to access providers and update state.
/// - `context`: The build context in which the sign-up function is triggered.
/// - `themeState`: The current theme state of the app.
///
/// Throws:
/// - `FirebaseAuthException` if an error occurs during the sign-up process with Firebase Authentication.
///
/// Returns:
/// A `Future<void>` that represents the asynchronous operation of creating an account and storing user information.
Future<void> emailSignUp({
  required String userFirstName,
  required String userMiddleName,
  required String userLastName,
  required int userContactNumber,
  required String userFullAddress,
  required String userGender,
  required int userStudentNumber,
  required String userCollege,
  required String userEmail,
  required String userPassword,
  required WidgetRef ref,
  required BuildContext context,
  required String themeState,
}) async {
  final String formattedName =
      '$userLastName, $userFirstName ${userMiddleName[0]}';

  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: userEmail, password: userPassword)
        .then(
      (value) async {
        await FirebaseAuth.instance.currentUser!
            .updateDisplayName(formattedName)
            .then(
          (value) async {
            await FirebaseFirestore.instance
                .collection('students')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set(
              {
                StudentAccountDocumentFieldName.firstName: userFirstName,
                StudentAccountDocumentFieldName.middleName: userMiddleName,
                StudentAccountDocumentFieldName.lastName: userLastName,
                StudentAccountDocumentFieldName.contactNumber:
                    userContactNumber,
                StudentAccountDocumentFieldName.fullAddress: userFullAddress,
                StudentAccountDocumentFieldName.gender: userGender,
                StudentAccountDocumentFieldName.studentNumber:
                    userStudentNumber,
                StudentAccountDocumentFieldName.college: userCollege,
                StudentAccountDocumentFieldName.email: userEmail
              },
            );
          },
        );
      },
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

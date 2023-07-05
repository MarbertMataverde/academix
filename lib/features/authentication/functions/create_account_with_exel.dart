// import 'package:excel/excel.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';

// /// INSTRUCTION TO USE THIS CODE
// ///
// /// Get all these packages
// /// excel:
// /// firebase_core:
// /// firebase_auth:
// /// file_picker:
// ///
// /// Then
// ///
// /// Initialize firebase to this project
// ///
// /// Then you can call it to create multiple account

// /// A function that creates user accounts using data from an Excel file.
// /// It prompts the user to select an Excel file, reads the file data, and creates user accounts based on the data.
// Future<void> createAccountWithExcelFile() async {
//   // Prompt the user to select an Excel file
//   final result = await FilePicker.platform.pickFiles(
//     type: FileType.custom,
//     allowedExtensions: ['xlsx', 'xls'],
//   );

//   if (result != null) {
//     // Retrieve the file bytes from the selected file
//     final fileBytes = result.files.single.bytes;

//     // Decode the Excel file bytes into an Excel object
//     final excel = Excel.decodeBytes(fileBytes!);

//     // Get the 'Sheet1' table from the Excel object
//     final table = excel.tables['Sheet1'];

//     // Retrieve the rows from the table
//     final rows = table!.rows;

//     // Iterate over each row in the table (excluding the header row)
//     for (var i = 1; i < rows.length; i++) {
//       // Extract the email and password values from the current row
//       final email = rows[i][0]!.value;
//       final password = rows[i][1]!.value;

//       try {
//         // Create a user account using the extracted email and password
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: email.toString(),
//           password: password.toString(),
//         );
//         debugPrint('User created with email: $email');
//       } on FirebaseAuthException catch (e) {
//         debugPrint(
//           'Failed to create user with email: $email. Error: ${e.message}',
//         );
//       }
//     }
//   } else {
//     // User canceled the picker
//     debugPrint('Cancel');
//   }
// }

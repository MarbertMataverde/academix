import 'package:academix/components/custom_dialog_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadBulletinUpdate {
  Future<void> uploadUpdateWithImagesWeb({
    // List of Uint8List converted images
    required List<Uint8List> listOfImagesWeb,
    // FilePicker Result
    required FilePickerResult? result,
    // News description and other information
    required String creatorName,
    required String title,
    required String description,
    // Dialog parameters
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      final List<String> imageUrlList = [];
      final Timestamp timestamp = Timestamp.now();
      final String dateTimeString = (DateTime.now()
            ..month
            ..day
            ..hour
            ..minute)
          .toString();

      if (result != null) {
        for (var i = 0; i < result.count; i++) {
          Uint8List fileUint8List = result.files[i].bytes!;
          String fileName = result.files[i].name;

          // Upload file
          await FirebaseStorage.instance
              .ref('bulletin-images/$creatorName/$dateTimeString/$fileName')
              .putData(fileUint8List);
          // Get download URL
          String downloadUrl = await FirebaseStorage.instance
              .ref('bulletin-images/$creatorName/$dateTimeString/$fileName')
              .getDownloadURL();

          imageUrlList.add(downloadUrl);
        }
        // when images uploading is done then upload the needed data
        await FirebaseFirestore.instance
            .collection('bulletin-update')
            .doc()
            .set({
          // created time
          'created-time': timestamp,
          // created by
          'created-by': creatorName,
          // title
          'title': title,
          // description
          'description': description,
          // list of image url if available
          'image-url': imageUrlList,
        });
      }
    } on FirebaseException catch (e) {
      customDialogBox(
        context: context,
        ref: ref,
        title: e.code,
        message: e.message.toString(),
      );
    }
  }

  Future<void> uploadNewsWithImagesAndroid() async {}

  Future<void> uploadNewsWithoutImages({
    // News description and other information
    required String creatorName,
    required String title,
    required String description,
    // Dialog parameters
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final Timestamp timestamp = Timestamp.now();

    try {} on FirebaseException catch (e) {
      customDialogBox(
        context: context,
        ref: ref,
        title: e.code,
        message: e.message.toString(),
      );
    }

    await FirebaseFirestore.instance.collection('bulletin-update').doc().set(
      {
        // created time
        'created-time': timestamp,
        // created by
        'created-by': creatorName,
        // title
        'title': title,
        // description
        'description': description,
        // list of image url if available
        'image-url': [],
        // reaction count default = 0
        'reaction-count': 0,
      },
    );
  }
}

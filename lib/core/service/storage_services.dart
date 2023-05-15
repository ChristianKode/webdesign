import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  final _storage = FirebaseStorage.instance.ref();

// Storing image for the uploaded jobs
// Returns IMG URL, that will be uploaded to database
  Future<String> uploadImage(
      String aid, String selectFile, Uint8List selectedImageInBytes) async {
    String imageUrl = '';
    final metadata = SettableMetadata(contentType: 'image/jpeg');

    await _storage
        .child('adventures/')
        .child(aid)
        .child('/$selectFile')
        .putData(selectedImageInBytes, metadata);

    try {
      imageUrl = await _storage
          .child('adventures/')
          .child(aid)
          .child('/$selectFile')
          .getDownloadURL()
          .then((value) => value);
    } catch (e) {
      return e.toString();
    }
    return imageUrl;
  }
}

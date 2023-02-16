import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:webdesign/pages/profile/profile.dart';
import 'package:webdesign/widgets/navbar.dart';

class LargeProfile extends StatelessWidget {
  LargeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
              Color.fromRGBO(240, 95, 87, 1.0),
              Color.fromRGBO(54, 9, 64, 1.0)
            ])),
        child: Column(
          children: <Widget>[NavBarIn(), ProfileContent()],
        ),
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  late Uint8List selectedImageInBytes;
  List<Uint8List> pickedImagesInBytes = [];
  FirebaseStorage _storage = FirebaseStorage.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users");
  String selectFile = '';
  int imageCounts = 0;
  String imageUrl = "";

  final TextEditingController Fornavn = TextEditingController();
  final TextEditingController Etternavn = TextEditingController();
  final TextEditingController Telefon = TextEditingController();

  _selectFile(bool imageFrom) async {
    FilePickerResult? fileResult =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (fileResult != null) {
      selectFile = fileResult.files.first.name;
      fileResult.files.forEach((element) {
        pickedImagesInBytes.add(element.bytes as Uint8List);
        selectedImageInBytes = fileResult.files.first.bytes!;
        imageCounts += 1;
      });
    }
    print(selectFile);
    print(imageCounts);
  }

  _upload() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    final StorageRef =
        _storage.ref().child("userimage").child(uid!).child('/' + selectFile);

    final metadata = SettableMetadata(contentType: 'image/jpeg');

    await StorageRef.putData(selectedImageInBytes, metadata);

    try {
      imageUrl =
          await StorageRef.getDownloadURL().then((value) => value as String);
    } catch (e) {
      print("Error getting download URL: $e");
    }

    print(imageUrl);

    await ref.child(uid).set({"pfp": imageUrl});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
          alignment: Alignment.center,
          height: 400,
          width: 1200,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 1035, top: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      color: Colors.black),
                  width: 120,
                  height: 120,
                  child: InkWell(
                    onTap: () async {
                      await _selectFile(true);

                      await _upload();
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius: new BorderRadius.all(Radius.circular(60)),
                        shape: BoxShape.rectangle
                      ),
                      child: new ClipRRect(
                          borderRadius: new BorderRadius.circular(60),
                          child: Image(
                              image: const AssetImage("images/Profile.jpg"))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 500),
                child: Container(
                  height: 100,
                  width: 300,
                  child: TextField(
                    controller: Fornavn,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(102, 82, 143, 1.0),
                              width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      )),
                      hintText: 'Fornavn',
                    )),
                ),
              ),
            ],
          ),
          ),
    );
  }
}

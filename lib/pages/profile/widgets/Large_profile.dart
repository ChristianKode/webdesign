import 'dart:math';
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
        color: Colors.white,
        child: Column(
          children: <Widget>[
            NavBarIn(),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ProfileContent(),
            ),
        ])));
  }
}

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      width: 1000,
      child: Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: [
                Tab(
                  text: 'Profil',
                  ),
                Tab(text: 'Favoritter',),
                Tab(text: 'Mine Annonser',)
                ],
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, color: Color.fromRGBO(102, 82, 143, 1.0)),
                labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                labelColor: Color.fromRGBO(102, 82, 143, 1.0),
                indicatorColor: Color.fromRGBO(102, 82, 143, 1.0),
                indicatorWeight: 5,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      height: 800,
                      width: 1400,
                      color: Colors.blue,
                      child: Text("Profil"),
                    ),
                    Container(
                      height: 800,
                      width: 1400,
                      color: Colors.yellow,
                      child: Text("Favoritter"),
                    ),
                    Container(
                      height: 800,
                      width: 1400,
                      color: Colors.green,
                      child: Text("Mine Annonser"),
                    ),
                  ],))
            ],
        ),
    );
  }
}

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

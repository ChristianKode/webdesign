import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:webdesign/pages/home/widgets/main_home.dart';
import 'package:get/get.dart';

class LargeNewJob extends StatelessWidget {
  LargeNewJob({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/0bec91f9-2264-4273-9e8f-6aeb2f53b5ac%2Fwp11093306-bmw-m5-2022-wallpapers.jpg?alt=media&token=59266e96-f193-4ace-ab9d-3aa129cf8f44'),
                fit: BoxFit.cover)),
        child: Column(
          children: [const Nav(), FillOut()],
        ),
      ),
    );
  }
}

class FillOut extends StatefulWidget {
  FillOut({super.key});

  @override
  State<FillOut> createState() => _FillOutState();
}

class _FillOutState extends State<FillOut> {
  final TextEditingController titleCon = TextEditingController();
  final TextEditingController descpritionCon = TextEditingController();
  final TextEditingController addressCon = TextEditingController();
  final TextEditingController zipcodeCon = TextEditingController();
  final TextEditingController priceCon = TextEditingController();
  FirebaseStorage _storage = FirebaseStorage.instance;

  late Uint8List selectedImageInBytes;
  List<Uint8List> pickedImagesInBytes = [];
  String selectFile = '';
  int imageCounts = 0;

  _selectFile(bool imageFrom) async {
    FilePickerResult? fileResult =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (fileResult != null) {
      selectFile = fileResult.files.first.name;
      fileResult.files.forEach((element) {
        setState(() {
          pickedImagesInBytes.add(element.bytes as Uint8List);
          selectedImageInBytes = fileResult.files.first.bytes!;
          imageCounts += 1;
        });
      });
    }
    print(selectFile);
    print(imageCounts);
  }

  upload() async {
    String title = titleCon.text.trim();
    String descprition = descpritionCon.text.trim();
    String address = addressCon.text.trim();
    String zipcode = zipcodeCon.text.trim();
    String price = priceCon.text.trim();
    String imageUrl = '';

    var uuid = Uuid();
    var aid = uuid.v4();

    final StorageRef = _storage.ref().child(aid).child('/' + selectFile);

    final metadata = SettableMetadata(contentType: 'image/jpeg');

    await StorageRef.putData(selectedImageInBytes, metadata);

    try {
      imageUrl =
          await StorageRef.getDownloadURL().then((value) => value as String);
    } catch (e) {
      print("Error getting download URL: $e");
    }

    print(imageUrl);

    DatabaseReference ref = FirebaseDatabase.instance.ref("adventures");

    String uid = FirebaseAuth.instance.currentUser!.uid;

    await ref.child(aid).set({
      "title": title,
      "descprition": descprition,
      "address": address,
      "zipcode": zipcode,
      "price": price,
      "uid": uid,
      "aid": aid,
      "img1": imageUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Container(
          height: 600,
          width: 450,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(2)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text('Hva skal utføres?',
                    style: GoogleFonts.tinos(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: titleCon,
                    decoration: const InputDecoration(
                      labelText: 'Overskrift',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(102, 82, 143, 1.0), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 200,
                  width: 350,
                  child: TextField(
                    controller: descpritionCon,
                    decoration: const InputDecoration(
                      labelText: 'Beskrivelse',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(102, 82, 143, 1.0), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                    ),
                    minLines: 10,
                    maxLines: 10,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 50, bottom: 7, top: 10),
                        child: Text('Bilder'),
                      ),
                    ),
                    Expanded(
                        child: selectFile.isEmpty
                            ? SizedBox(
                                height: 1,
                              )
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: SizedBox(
                                    height: 100,
                                    child: Image.memory(selectedImageInBytes)),
                              )),
                  ],
                ),
                SizedBox(
                  width: 350,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () async {
                        _selectFile(true);
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                          backgroundColor:
                              const Color.fromRGBO(102, 82, 143, 1.0)),
                      child: const Text(
                        'Last opp',
                        style: TextStyle(fontSize: 15),
                      )),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 50, top: 30),
                    child: Text('Hvor er dette?'),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                    width: 350,
                    child: TextField(
                      controller: addressCon,
                      decoration: const InputDecoration(
                        labelText: 'Gate',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(102, 82, 143, 1.0),
                              width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
                    )),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 50, top: 30),
                    child: Text('Hvor er dette?'),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: zipcodeCon,
                    decoration: const InputDecoration(
                      labelText: 'Postnummer',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(102, 82, 143, 1.0), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 50, top: 30, bottom: 7),
                    child: Text('Belønning?'),
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: priceCon,
                    decoration: const InputDecoration(
                      labelText: 'Pris',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(102, 82, 143, 1.0), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 350,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        upload();
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                          backgroundColor:
                              const Color.fromRGBO(102, 82, 143, 1.0)),
                      child: const Text(
                        'Fullfør',
                        style: TextStyle(fontSize: 15),
                      )),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Nav extends StatelessWidget {
  const Nav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Get.to(() => LargeHome());
              },
              child: (Text.rich(
                  TextSpan(style: const TextStyle(fontSize: 70), children: [
                TextSpan(
                    text: 'UNG',
                    style: GoogleFonts.tinos(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(
                    text: 'ANSATT',
                    style: GoogleFonts.tinos(
                        color: const Color.fromRGBO(102, 82, 143, 1.0)))
              ]))))
        ],
      ),
    );
  }
}

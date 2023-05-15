import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webdesign/core/utils/responsive/theme.dart';
import 'package:webdesign/pages/home/widgets/main_home.dart';
import 'package:get/get.dart';
import 'package:webdesign/core/utils/widgets/appbar.dart';
import 'package:webdesign/core/utils/widgets/drawer.dart';

class LargeNewJob extends StatelessWidget {
  LargeNewJob({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // Creates a visual scaffold for Material Design widgets.
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context, scaffoldKey),
      drawer: const Drawer(
        child: SideDrawer(),
      ),
      // Container decorated with an image for the background.
      body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fnewjob_background.jpg?alt=media&token=3c5212e1-dcbf-4a61-a6c8-bb13c9b9bb9e'),
                  fit: BoxFit.cover)),
          child: const FillOut()),
    );
  }
}

var uuid = const Uuid();
var aid = uuid.v4();

class FillOut extends StatefulWidget {
  const FillOut({super.key});

  @override
  State<FillOut> createState() => _FillOutState();
}

class _FillOutState extends State<FillOut> {
  // Controllers for the textfields
  final TextEditingController titleCon = TextEditingController();
  final TextEditingController descpritionCon = TextEditingController();
  final TextEditingController addressCon = TextEditingController();
  final TextEditingController zipcodeCon = TextEditingController();
  final TextEditingController priceCon = TextEditingController();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  
  late Uint8List selectedImageInBytes;
  List<Uint8List> pickedImagesInBytes = [];
  String selectFile = '';
  int imageCounts = 0;

  // FilePicker
  _selectFile(bool imageFrom) async {
    
    // Opens filepicker
    FilePickerResult? fileResult =
        await FilePicker.platform.pickFiles(allowMultiple: true);


    // selectFile gets the FilePicker Result
    if (fileResult != null) {
      selectFile = fileResult.files.first.name;
      for (var element in fileResult.files) {
        setState(() {
          pickedImagesInBytes.add(element.bytes as Uint8List);
          selectedImageInBytes = fileResult.files.first.bytes!;
          imageCounts += 1;
        });
      }
    }
  }

  // Upload logic
  upload() async {
    // Local variables for the controller data
    String title = titleCon.text.trim();
    String descprition = descpritionCon.text.trim();
    String address = addressCon.text.trim();
    String zipcode = zipcodeCon.text.trim();
    String price = priceCon.text.trim();
    String imageUrl = '';
    // Creating a unique id for the new ad
    var uuid = const Uuid();
    var aid = uuid.v4();

    // Path for the image upload to Cloud Storage
    final storageRef = _storage.ref().child(aid).child('/$selectFile');
    final metadata = SettableMetadata(contentType: 'image/jpeg');
    await storageRef.putData(selectedImageInBytes, metadata);
    try {
      // Getting the URL of the imagge
      imageUrl = await storageRef.getDownloadURL().then((value) => value);
    } catch (e) {
      return e;
    }
    // Uploading new AD data + stored Image URL
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.80,
            width: 450,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: SizedBox(
                  width: 350,
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
                              borderSide: BorderSide(color: appColor, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
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
                              borderSide: BorderSide(color: appColor, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
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
                              padding:
                                  EdgeInsets.only(left: 50, bottom: 7, top: 10),
                              child: Text('Bilder'),
                            ),
                          ),
                          Expanded(
                              child: selectFile.isEmpty
                                  ? const SizedBox(
                                      height: 1,
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: SizedBox(
                                          height: 100,
                                          child: Image.memory(
                                              selectedImageInBytes)),
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
                                backgroundColor: appColor),
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
                                borderSide:
                                    BorderSide(color: appColor, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
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
                              borderSide: BorderSide(color: appColor, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding:
                              EdgeInsets.only(left: 50, top: 30, bottom: 7),
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
                              borderSide: BorderSide(color: appColor, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
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
                              Get.to(() => LargeHome());
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2)),
                                backgroundColor: appColor),
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
                    text: 'ANSATT', style: GoogleFonts.tinos(color: appColor))
              ]))))
        ],
      ),
    );
  }
}

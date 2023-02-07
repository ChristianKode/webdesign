import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:webdesign/pages/newJob/widgets/body.dart';

Uint8List? Images = Uint8List.fromList([]);

class LargeNewJob extends StatelessWidget {
  LargeNewJob({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/newjob_background.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          children: [const Nav(), FillOut1()],
        ),
      ),
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
              onPressed: () {},
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

class FillOut1 extends StatelessWidget {
  FillOut1({super.key});

  //Controllers to save input
  final TextEditingController titleCon = TextEditingController();
  final TextEditingController descpritionCon = TextEditingController();
  final TextEditingController addressCon = TextEditingController();
  final TextEditingController zipcodeCon = TextEditingController();
  final TextEditingController priceCon = TextEditingController();

  final _pickedImages = <Image>[];

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
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 50, bottom: 7, top: 10),
                    child: Text('Bilder'),
                  ),
                ),
                SizedBox(
                  width: 350,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () async {
                        Images = await ImagePickerWeb.getImageAsBytes();

                        var uuid = Uuid();
                        var aid = uuid.v4();

                        final refref = FirebaseStorage.instance.ref("1aid");

                        refref.putData(Images!);
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
                            color: Color.fromRGBO(102, 82, 143, 1.0), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                    ),)),
                    
                    SizedBox(
                      width: 350,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () async {
                              final infos = await ImagePickerWeb.getMultiImagesAsBytes();
                                        print(infos);
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
                        String title = titleCon.text.trim();
                        String descprition = descpritionCon.text.trim();
                        String address = addressCon.text.trim();
                        String zipcode = zipcodeCon.text.trim();
                        String price = priceCon.text.trim();

                        var uuid = Uuid();
                        var aid = uuid.v4();

                        DatabaseReference ref =
                            FirebaseDatabase.instance.ref("adventures");

                        final refref = FirebaseStorage.instance.ref("aid");

                        String uid = FirebaseAuth.instance.currentUser!.uid;

                        ref.child(aid).set({
                          "title": title,
                          "descprition": descprition,
                          "address": address,
                          "zipcode": zipcode,
                          "price": price,
                          "uid": uid,
                        });
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

class asd extends StatefulWidget {
  const asd({super.key, Int8List? Images});

  @override
  State<asd> createState() => _asdState();
}

class _asdState extends State<asd> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Images == null
            ? const CircularProgressIndicator()
            : Image.memory(
                Uint8List.fromList(Images!),
                width: 250,
                height: 250,
                fit: BoxFit.contain,
              ));
  }
}

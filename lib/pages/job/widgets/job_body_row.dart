import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:webdesign/pages/chat/widgets/large_chat.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/utils/responsive.dart';

import '../../../app_logic/services/message.dart';

// ignore: must_be_immutable
class BodyRow extends StatefulWidget {
  String aid = '';
  String uid = '';
  String img1 = '';
  String title = '';
  String descprition = '';
  String price = '';
  String address = '';
  String zipcode = '';
  BodyRow(
      {super.key,
      required this.aid,
      required this.uid,
      required this.img1,
      required this.title,
      required this.descprition,
      required this.price,
      required this.address,
      required this.zipcode});

  @override
  State<BodyRow> createState() => _BodyRowState();
}

class _BodyRowState extends State<BodyRow> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30),
      child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(maxWidth: 1052),
          child: !ResponsiveLayout.isSmallScreen(context)
              ? LargeBodyColumn(
                  img1: widget.img1,
                  title: widget.title,
                  descprition: widget.descprition,
                  price: widget.price,
                  uid: widget.uid,
                  address: widget.address,
                  zipcode: widget.zipcode)
              : SmallBodyColumn(
                  img1: widget.img1,
                  title: widget.title,
                  descprition: widget.descprition,
                  price: widget.price,
                  uid: widget.uid,
                  address: widget.address,
                  zipcode: widget.zipcode)),
    );
  }
}

class SmallBodyColumn extends StatefulWidget {
  final String img1;
  final String title;
  final String descprition;
  final String price;
  final String uid;
  final String address;
  final String zipcode;

  const SmallBodyColumn({
    super.key,
    required this.img1,
    required this.title,
    required this.descprition,
    required this.price,
    required this.uid,
    required this.address,
    required this.zipcode,
  });

  @override
  State<SmallBodyColumn> createState() => _SmallBodyColumnState();
}

class _SmallBodyColumnState extends State<SmallBodyColumn> {
  bool onHover0 = false;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          const SizedBox(
            height: 150,
          ),

          // Main image
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
                constraints: const BoxConstraints(minHeight: 350),
                child: Image.network(
                  widget.img1,
                  fit: BoxFit.cover,
                )),
          ),

          Row(
            children: [
              // Favorite button
              const SizedBox(width: 200, height: 40, child: FavoriteButton()),
              const SizedBox(
                width: 30,
              ),

              // Copy button
              SizedBox(
                width: 100,
                height: 40,
                child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.ios_share,
                          color: Colors.blue,
                        ),
                        Text(
                          'Kopier',
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    )),
              )
            ],
          ),

          // Divide line
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Container(
              height: 2,
              color: Colors.black12,
            ),
          ),

          //Job Title
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style:
                  GoogleFonts.tinos(fontSize: 30, fontWeight: FontWeight.w700),
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              widget.descprition,
              style: GoogleFonts.tinos(
                fontSize: 17,
              ),
            ),
          ),

          // Divide Line
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 50),
            child: Container(
              height: 2,
              color: Colors.black12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Se i kart",
              ),
            ),
          ),

          Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const Icon(
                    Icons.map_outlined,
                    color: Colors.blue,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onHover: (value) => {
                      setState(() {
                        onHover0 = value;
                      })
                    },
                    onTap: () {},
                    child: Text(
                      '${widget.zipcode}, ${widget.address}',
                      style: GoogleFonts.tinos(
                          color: Colors.blue,
                          fontSize: 20,
                          decoration:
                              !onHover0 ? null : TextDecoration.underline),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Belønning",
                style: GoogleFonts.tinos(
                    fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "${widget.price} kr",
                style: GoogleFonts.tinos(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
              height: 40,
              child: ElevatedButton(
                  onPressed: () async {
                    var uuid = const Uuid();
                    var mid = uuid.v4();
                    DatabaseReference messageRef = FirebaseDatabase.instance
                        .ref()
                        .child('messages')
                        .child(mid);
                    FirebaseAuth auth = FirebaseAuth.instance;
                    if (auth.currentUser != null) {
                      await messageRef.set({
                        "u1": FirebaseAuth.instance.currentUser?.uid,
                        "u2": widget.uid
                      });
                      Get.to(() => const Chattos());
                    } else {
                      Get.to(() => const Login());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.blue),
                  child: const Center(
                    child: Text('Ta kontakt'),
                  ))),
        ],
      ),
    );
  }
}

// LargeScreen Widget
class LargeBodyColumn extends StatelessWidget {
  const LargeBodyColumn({
    super.key,
    required this.img1,
    required this.title,
    required this.descprition,
    required this.price,
    required this.uid,
    required this.address,
    required this.zipcode,
  });

  final String img1;
  final String title;
  final String descprition;
  final String price;
  final String uid;
  final String address;
  final String zipcode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 150,
        ),
        Row(
          children: [
            Flexible(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: SizedBox(
                  child: Column(
                    children: [
                      // Job image
                      Container(
                          constraints: const BoxConstraints(minHeight: 350),
                          child: Image.network(
                            img1,
                            fit: BoxFit.cover,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          // Favorite
                          const SizedBox(
                              width: 200, height: 40, child: FavoriteButton()),
                          const SizedBox(
                            width: 30,
                          ),

                          // Copy button
                          SizedBox(
                            width: 100,
                            height: 40,
                            child: TextButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.ios_share,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      'Kopier',
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  ],
                                )),
                          )
                        ],
                      ),

                      // Divide line
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 5),
                        child: Container(
                          height: 2,
                          color: Colors.black12,
                        ),
                      ),

                      //Job Title
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          style: GoogleFonts.tinos(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                      ),

                      //Job Description
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Text(
                                'Beskrivelse av oppdraget',
                                style: GoogleFonts.tinos(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                descprition,
                                style: GoogleFonts.tinos(
                                  fontSize: 17,
                                ),
                              ),
                            ),

                            // Divide line
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 5),
                              child: Container(
                                height: 2,
                                color: Colors.black12,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // // //
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: SelectableText(
                                '${price}kr',
                                style: GoogleFonts.tinos(fontSize: 25),
                              ),
                            ),
                            SizedBox(
                                height: 40,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      var uuid = const Uuid();
                                      var mid = uuid.v4();
                                      FirebaseAuth auth = FirebaseAuth.instance;
                                      if (auth.currentUser != null) {
                                        final senderId = FirebaseAuth
                                            .instance.currentUser?.uid;
                                        final recipientId = uid;
                                        navnesen(senderId!, recipientId);

                                        Get.to(() => const Chattos());
                                      } else {
                                        Get.to(() => const Login());
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.blue),
                                    child: const Center(
                                      child: Text('Ta kontakt'),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: SelectableText(
                                '$address, $zipcode',
                                style: GoogleFonts.tinos(fontSize: 25),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: Colors.white),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.map_outlined,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        'Vis i Kart',
                                        style: TextStyle(color: Colors.blue),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorited = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            isFavorited = !isFavorited;
          });
        },
        style: ElevatedButton.styleFrom(
            side: BorderSide(
                width: 5, color: isFavorited ? Colors.blue : Colors.white10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: isFavorited ? Colors.blue : Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.white : Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Text(
                  isFavorited ? 'Lagt til favoritt' : 'Legg til favoritt',
                  style: TextStyle(
                      color: isFavorited ? Colors.white : Colors.blue)),
            )
          ],
        ));
  }
}

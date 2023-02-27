import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:webdesign/pages/chat/widgets/chat_page.dart';
import 'package:webdesign/pages/login/login.dart';

// ignore: must_be_immutable
class BodyRow extends StatelessWidget {
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

  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30),
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(maxWidth: 1052),
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: SizedBox(
                    width: 600,
                    child: Column(
                      children: [
                        // Job image
                        SizedBox(
                            width: 600,
                            height: 400,
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
                                width: 200,
                                height: 40,
                                child: FavoriteButton()),
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
                                        color:
                                            Color.fromRGBO(102, 82, 143, 1.0),
                                      ),
                                      Text(
                                        'Kopier',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                102, 82, 143, 1.0)),
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
                            width: 600,
                            height: 2,
                            color: Colors.black12,
                          ),
                        ),

                        //Job Title
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 600,
                          child: Text(
                            title,
                            style: GoogleFonts.tinos(
                                fontSize: 30, fontWeight: FontWeight.w700),
                          ),
                        ),

                        //Job Description
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 600,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(
                                  'Beskrivelse av oppdraget',
                                  style: GoogleFonts.tinos(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
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
                                  width: 600,
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

                // // //
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      constraints: const BoxConstraints(minWidth: 175),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 400),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color.fromRGBO(
                                        102, 82, 143, 1.0))),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      '${price}kr',
                                      style: GoogleFonts.tinos(fontSize: 30),
                                    ),
                                  ),
                                  Container(
                                    width: 350,
                                    height: 40,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          var uuid = const Uuid();
                                          var mid = uuid.v4();
                                          DatabaseReference messageRef =
                                              FirebaseDatabase.instance
                                                  .ref()
                                                  .child('messages')
                                                  .child(mid);
                                          FirebaseAuth auth =
                                              FirebaseAuth.instance;
                                          if (auth.currentUser != null) {
                                            await messageRef.set({
                                              "u1": FirebaseAuth
                                                  .instance.currentUser?.uid,
                                              "u2": uid
                                            });
                                            Get.to(() => const Chattos());
                                          } else {
                                            Get.to(() => const Login());
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    102, 82, 143, 1.0)),
                                        child: const Text("Ta Kontakt")),
                                  ),
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
                                border: Border.all(
                                    color: const Color.fromRGBO(
                                        102, 82, 143, 1.0))),
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
                                  Container(
                                    constraints: BoxConstraints(maxWidth: 350),
                                    height: 40,
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.map_outlined,
                                              color: Color.fromRGBO(
                                                  102, 82, 143, 1.0),
                                            ),
                                            Text(
                                              'Vis i Kart',
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      102, 82, 143, 1.0)),
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
                  ),
                )
              ],
            ),
          ],
        ),
      ),
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
                width: 5,
                color: isFavorited
                    ? const Color.fromRGBO(102, 82, 143, 1.0)
                    : Colors.white10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: isFavorited
                ? const Color.fromRGBO(102, 82, 143, 1.0)
                : Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited
                  ? Colors.white
                  : const Color.fromRGBO(102, 82, 143, 1.0),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Text(
                  isFavorited ? 'Lagt til favoritt' : 'Legg til favoritt',
                  style: TextStyle(
                      color: isFavorited
                          ? Colors.white
                          : const Color.fromRGBO(102, 82, 143, 1.0))),
            )
          ],
        ));
  }
}

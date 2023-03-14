import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:webdesign/main.dart';
import 'package:webdesign/pages/chat/widgets/large_chat.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/utils/responsive.dart';

import '../../../app_logic/services/message.dart';

final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;
final _realtimeData = FirebaseDatabase.instance.ref();

final _currentUser = _auth.currentUser?.uid;

String aid = '';
String uid = '';
String img1 = '';
String title = '';
String descprition = '';
String price = '';
String address = '';
String zipcode = '';

class BodyRow extends StatefulWidget {
  BodyRow({
    super.key,
  });

  @override
  State<BodyRow> createState() => _BodyRowState();
}

class _BodyRowState extends State<BodyRow> {
  Future<void> getAid() async {
    DocumentSnapshot<Object?> _currentUserSnapshot =
        await _fireStore.collection('Users').doc(_currentUser).get();
    aid = _currentUserSnapshot.get('aid').toString();
  }

  Future<Map<String, dynamic>> getView() async {
    await getAid();

    DataSnapshot _currentAdSnapshot =
        (await _realtimeData.child('adventures/$aid').get()) as DataSnapshot;

    return _currentAdSnapshot.value as Map<String, dynamic>? ?? {};
  }

  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getView(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: CircularProgressIndicator());
        } else {
          uid = snapshot.data?['uid']?.toString() ?? '';
          img1 = snapshot.data?['img1']?.toString() ?? '';
          title = snapshot.data?['title']?.toString() ?? '';
          descprition = snapshot.data?['descprition']?.toString() ?? '';
          price = snapshot.data?['price']?.toString() ?? '';
          address = snapshot.data?['address']?.toString() ?? '';
          zipcode = snapshot.data?['zipcode']?.toString() ?? '';

          return Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(maxWidth: 1052),
              child: !ResponsiveLayout.isSmallScreen(context)
                  ? LargeBodyColumn()
                  : SmallBodyColumn(),
            ),
          );
        }
      },
    );
  }
}

class SmallBodyColumn extends StatefulWidget {
  const SmallBodyColumn({
    super.key,
  });

  @override
  State<SmallBodyColumn> createState() => _SmallBodyColumnState();
}

class _SmallBodyColumnState extends State<SmallBodyColumn> {
  late Map<String, DocumentSnapshot> documentSnapshots;

  @override
  void initState() {
    super.initState();
    documentSnapshots = {};
    _fetchUserDocument();
  }

  Future<void> _fetchUserDocument() async {
    try {
      final userSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      if (userSnapshot.exists) {
        setState(() {
          documentSnapshots['user'] = userSnapshot;
        });
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      print('Error fetching user document: $e');
    }
  }

  bool onHover0 = false;
  @override
  Widget build(BuildContext context) {
    final authorIdentity = documentSnapshots.containsKey('user')
        ? documentSnapshots['user']!.data() as Map<String, dynamic>
        : null;
    final authorName = authorIdentity != null
        ? authorIdentity['firstname'] + ' ' + authorIdentity['lastname']
        : '';
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),

        // Main image
        Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          child: Image.network(img1, fit: BoxFit.cover),
        ),

        const SizedBox(
          height: 20,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            title,
            style: GoogleFonts.tinos(fontSize: 30, fontWeight: FontWeight.w700),
          ),
        ),

        // Description
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            descprition,
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
                    '${zipcode}, ${address}',
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
              style:
                  GoogleFonts.tinos(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "${price} kr",
              style:
                  GoogleFonts.tinos(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
            height: 40,
            child: ElevatedButton(
                onPressed: () async {
                  final authorId = uid;
                  String existingChatId = '';
                  List<DocumentSnapshot> results = [];

                  final Uid1querySnapshot = await FirebaseFirestore.instance
                      .collection('Messages')
                      .where("Uid1", whereIn: [uid, authorId]).get();

                  final Uid1matchUid = await FirebaseFirestore.instance
                      .collection('Messages')
                      .where('Uid2', isEqualTo: authorId)
                      .get();

                  final Uid1matchAuthorID = await FirebaseFirestore.instance
                      .collection('Messages')
                      .where('Uid2', isEqualTo: uid)
                      .get();

                  Uid1querySnapshot.docs.forEach((doc) {
                    if (doc.data()['Uid1'] == uid) {
                      // UID found in 'Uid1' field
                      print('${doc.id}: UID found');
                      results.addAll(Uid1matchUid.docs);
                    } else {
                      // Author ID found in 'Uid1' field

                      print('${doc.id}: author ID found');
                      results.addAll(Uid1matchAuthorID.docs);
                    }
                  });

                  print('Results:');
                  results.forEach((doc) {
                    print('${doc.id}: ${doc.data()}');
                    if (existingChatId == '') {
                      existingChatId = doc.id;
                    }
                  });

                  if (results.isNotEmpty) {
                    // take user to existing chat
                    Get.to(() => ChatUI(
                        chatGroupId: existingChatId,
                        secondUserName: authorName));
                  } else {
                    // new chat group
                    final messageRef =
                        FirebaseFirestore.instance.collection('Messages');
                    final currentUser = FirebaseAuth.instance.currentUser?.uid;

                    if (currentUser != null) {
                      try {
                        final newDocumentRef = messageRef.doc();
                        final newDocumentId = newDocumentRef.id;

                        newDocumentRef.set({
                          "Uid1": currentUser,
                          "Uid2": uid,
                        });

                        Get.to(() => ChatUI(
                              chatGroupId: newDocumentId,
                              secondUserName: authorName,
                            ));
                      } catch (e) {
                        // Handle the error here
                        print('Error creating new document: $e');
                      }
                    } else {
                      Get.to(() => Login());
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.blue),
                child: const Center(
                  child: Text('Ta kontakt'),
                ))),
        const SizedBox(
          height: 30,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 212, 235, 255)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipOval(
                      child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fprofile-circle-icon-512x512-dt9lf8um.png?alt=media&token=6b6eec31-abc3-43ad-ba01-69b374731ba9')),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        authorName,
                        style: GoogleFonts.tinos(fontSize: 25),
                      ),
                      TextButton(onPressed: () {}, child: Text('Vis profil'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// LargeScreen Widget
class LargeBodyColumn extends StatefulWidget {
  const LargeBodyColumn({
    super.key,
  });

  @override
  State<LargeBodyColumn> createState() => _LargeBodyColumnState();
}

class _LargeBodyColumnState extends State<LargeBodyColumn> {
  late Map<String, DocumentSnapshot> documentSnapshots;

  @override
  void initState() {
    super.initState();
    documentSnapshots = {};
    _fetchUserDocument();
  }

  Future<void> _fetchUserDocument() async {
    try {
      final userSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      if (userSnapshot.exists) {
        setState(() {
          documentSnapshots['user'] = userSnapshot;
        });
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      print('Error fetching user document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authorIdentity = documentSnapshots.containsKey('user')
        ? documentSnapshots['user']!.data() as Map<String, dynamic>
        : null;
    final authorName = authorIdentity != null
        ? authorIdentity['firstname'] + ' ' + authorIdentity['lastname']
        : '';
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
                                    final authorId = uid;
                                    String existingChatId = '';
                                    List<DocumentSnapshot> results = [];

                                    final Uid1querySnapshot =
                                        await FirebaseFirestore.instance
                                            .collection('Messages')
                                            .where("Uid1",
                                                whereIn: [uid, authorId]).get();

                                    final Uid1matchUid = await FirebaseFirestore
                                        .instance
                                        .collection('Messages')
                                        .where('Uid2', isEqualTo: authorId)
                                        .get();

                                    final Uid1matchAuthorID =
                                        await FirebaseFirestore.instance
                                            .collection('Messages')
                                            .where('Uid2', isEqualTo: uid)
                                            .get();

                                    Uid1querySnapshot.docs.forEach((doc) {
                                      if (doc.data()['Uid1'] == uid) {
                                        // UID found in 'Uid1' field
                                        print('${doc.id}: UID found');
                                        results.addAll(Uid1matchUid.docs);
                                      } else {
                                        // Author ID found in 'Uid1' field

                                        print('${doc.id}: author ID found');
                                        results.addAll(Uid1matchAuthorID.docs);
                                      }
                                    });

                                    print('Results:');
                                    results.forEach((doc) {
                                      print('${doc.id}: ${doc.data()}');
                                      if (existingChatId == '') {
                                        existingChatId = doc.id;
                                      }
                                    });

                                    if (results.isNotEmpty) {
                                      // take user to existing chat
                                      Get.to(() => ChatUI(
                                          chatGroupId: existingChatId,
                                          secondUserName: authorName));
                                    } else {
                                      // new chat group
                                      final messageRef = FirebaseFirestore
                                          .instance
                                          .collection('Messages');
                                      final currentUser = FirebaseAuth
                                          .instance.currentUser?.uid;

                                      if (currentUser != null) {
                                        try {
                                          final newDocumentRef =
                                              messageRef.doc();
                                          final newDocumentId =
                                              newDocumentRef.id;

                                          newDocumentRef.set({
                                            "Uid1": currentUser,
                                            "Uid2": uid,
                                          });

                                          Get.to(() => ChatUI(
                                                chatGroupId: newDocumentId,
                                                secondUserName: authorName,
                                              ));
                                        } catch (e) {
                                          // Handle the error here
                                          print(
                                              'Error creating new document: $e');
                                        }
                                      } else {
                                        Get.to(() => Login());
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: const Center(
                                    child: Text('Ta kontakt'),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    //Profil
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 212, 235, 255)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipOval(
                                  child: Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fprofile-circle-icon-512x512-dt9lf8um.png?alt=media&token=6b6eec31-abc3-43ad-ba01-69b374731ba9')),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText(
                                    authorName,
                                    style: GoogleFonts.tinos(fontSize: 25),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text('Vis profil'))
                                ],
                              ),
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
                          border: Border.all(color: Colors.blue)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: SelectableText(
                                '${address}, ${zipcode}',
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

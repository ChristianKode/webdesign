import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/pages/chat/smallChat.dart';
import 'package:webdesign/pages/chat/widgets/large_chat.dart';
import 'package:webdesign/pages/chat/widgets/small_chat.dart';
import 'package:webdesign/utils/responsive.dart';

class ChatList extends StatefulWidget {
  ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: ResponsiveLayout.isLargeScreen(context)
            ? 300
            : MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: const ChatGroupList(),
        ));
  }
}

String selectedChatId = "";

class ChatGroupList extends StatefulWidget {
  const ChatGroupList({Key? key}) : super(key: key);

  @override
  State<ChatGroupList> createState() => _chatGroupListState();
}

// ignore: camel_case_types
class _chatGroupListState extends State<ChatGroupList> {
  final fire = FirebaseFirestore.instance.collection('Messages');
  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
      future: Future.wait([
        fire.where('Uid1', whereIn: [uid]).get(),
        fire.where('Uid2', whereIn: [uid]).get(),
      ]).then(
        (List<QuerySnapshot<Map<String, dynamic>>> results) =>
            results.expand((querySnapshot) => querySnapshot.docs).toList(),
      ),
      builder: (BuildContext context,
          AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
              snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapshotList =
            snapshot.data!;
        if (querySnapshotList.isEmpty) {
          return const Text('Ingen chats funnet, start en chat via annonse');
        }

        List<String> documentIds = [];
        for (var documentSnapshot in querySnapshotList) {
          String documentId = documentSnapshot.id;
          Map<String, dynamic>? data = documentSnapshot.data();
          print(data);
          print('Found value in document with ID: $documentId');
          documentIds.add(documentId);
        }

        return Column(
          children: documentIds
              .map((documentId) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: ChatGroupCards(
                    documentId: documentId,
                  )))
              .toList(),
        );
      },
    );
  }
}

final fireStore = FirebaseFirestore.instance;

class ChatGroupCards extends StatefulWidget {
  final String documentId;

  ChatGroupCards({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<ChatGroupCards> createState() => _ChatGroupCardsState();
}

class _ChatGroupCardsState extends State<ChatGroupCards> {
  late Map<String, DocumentSnapshot> documentSnapshots;
  late Map<String, dynamic> jobValue;
  final _realtimeData = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    documentSnapshots = {};
    fireStore.collection('Messages').doc(widget.documentId).get().then((doc) {
      setState(() {
        documentSnapshots['message'] = doc;
      });

      final docdata =
          documentSnapshots['message']!.data() as Map<String, dynamic>;
      final String Uid1 = docdata['Uid1'];
      final String Uid2 = docdata['Uid2'];

      if (Uid1 == uid) {
        fireStore.collection('Users').doc(Uid2).get().then((value) {
          setState(() {
            documentSnapshots['user'] = value;
            print(value.toString());
          });
        });
      } else {
        fireStore.collection('Users').doc(Uid1).get().then((value) {
          setState(() {
            documentSnapshots['user'] = value;
            print(value.toString());
          });
        });
      }
    });
  }

  Future<String> findUser(String firstName, String lastName) async {
    final _firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('Users')
          .where('firstname', isEqualTo: firstName)
          .where('lastname', isEqualTo: lastName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        return 'No user found with the given first and last names.';
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (documentSnapshots.isEmpty ||
        documentSnapshots['message'] == null ||
        documentSnapshots['user'] == null) {
      return const SizedBox();
    }

    final docdata =
        documentSnapshots['message']!.data() as Map<String, dynamic>;
    final userdata = documentSnapshots['user']!.data() as Map<String, dynamic>;
    final String firstName = userdata['firstname'];
    final String lastName = userdata['lastname'];
    final secondUserName = firstName + ' ' + lastName;
    String secondUid = '';

    Future<void> getJobValue() async {
      String secondUid = '';
      try {
        // find user
        final value = await findUser(firstName, lastName);
        secondUid = value.toString();
        print(secondUid);

        // retrieve data from Firebase Realtime Database
        final _currentAdSnapshot =
            await _realtimeData.child('adventures/$secondUid').get();
        final jobValue = _currentAdSnapshot.value as Map<String, dynamic>;
        final img1 = jobValue['data']?['img1']?.toString() ?? '';
        print(img1);
        // use the value of img1
        // ...
      } catch (e) {
        print('Error: $e');
      }
    }

    return InkWell(
      onTap: () {
        selectedChatId = widget.documentId;
        ResponsiveLayout.isLargeScreen(context)
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatUI(
                          chatGroupId: selectedChatId,
                          secondUserName: secondUserName,
                        )),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SmallChatUI(
                          chatGroupId: selectedChatId,
                          secondUserName: secondUserName,
                        )));
      },
      child: ResponsiveLayout.isLargeScreen(context)
          ? Container(
              alignment: Alignment.centerLeft,
              width: 280,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(59, 0, 0, 0),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset:
                          Offset(0, 5), // changes the position of the shadow
                    ),
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  secondUserName,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    fontFamily: 'Segoe UI',
                  ),
                ),
              ),
            )
          : Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.90,
              height: 90,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(59, 0, 0, 0),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset:
                          Offset(0, 5), // changes the position of the shadow
                    ),
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          secondUserName,
                          style: const TextStyle(
                            fontSize: 24.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                            fontFamily: 'Segoe UI',
                          ),
                        ),
                        Text(
                          'Annonse',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

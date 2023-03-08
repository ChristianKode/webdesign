import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/pages/chat/widgets/large_chat.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200, color: Colors.white, child: const ChatGroupList());
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
          return Text('No matching documents found');
        }
        List<String> documentIds = [];
        for (var documentSnapshot in querySnapshotList) {
          String documentId = documentSnapshot.id;
          Map<String, dynamic>? data = documentSnapshot.data();
          print('Found value in document with ID: $documentId');
          documentIds.add(documentId);
        }

        return Column(
          children: documentIds
              .map((documentId) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: ChatGroupCards(documentId: documentId)))
              .toList(),
        );
      },
    );
  }
}

final fireStore = FirebaseFirestore.instance;

class ChatGroupCardsProvider extends ChangeNotifier {
  bool _onHover = false;

  bool get onHover => _onHover;

  set onHover(bool value) {
    _onHover = value;
    notifyListeners();
  }
}

class ChatGroupCards extends StatefulWidget {
  final String documentId;

  const ChatGroupCards({Key? key, required this.documentId}) : super(key: key);

  @override
  State<ChatGroupCards> createState() => _ChatGroupCardsState();
}

class _ChatGroupCardsState extends State<ChatGroupCards> {
  late Map<String, DocumentSnapshot> documentSnapshots;
  bool onHover = false;

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
          });
        });
      } else {
        fireStore.collection('Users').doc(Uid1).get().then((value) {
          setState(() {
            documentSnapshots['user'] = value;
          });
        });
      }
    });
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

    return InkWell(
      onTap: () {
        selectedChatId = widget.documentId;
        setState(() {
          onHover = true;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatUI(
                    chatGroupId: selectedChatId,
                  )),
        );
      },
      onHover: (value) => {setState(() {})},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: !onHover ? Colors.white : Color.fromARGB(20, 0, 0, 0),
              blurRadius: !onHover ? 2 : 0,
              offset: Offset(0.5, 5), // Shadow position
            )
          ],
        ),
        child: Text(
          secondUserName,
          style: TextStyle(),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        width: 200,
        color: Color.fromARGB(22, 0, 0, 0),
        child: const ChatGroupList());
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
                    child: InkWell(
                      onTap: () {
                        selectedChatId = documentId;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatUI(
                                    chatGroupId: selectedChatId,
                                  )),
                        );
                      },
                      child: Container(child: Text(documentId)),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}

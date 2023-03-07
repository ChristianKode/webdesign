import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return asd();
  }
}

Map<String, dynamic> data = [] as Map<String, dynamic>;

class asd extends StatefulWidget {
  const asd({super.key});

  @override
  State<asd> createState() => _asdState();
}

class _asdState extends State<asd> {
  final fire = FirebaseFirestore.instance.collection('messages');
  final uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: fire.where('Uid1', isEqualTo: uid).get(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return Text('Loading...');
        }
        QuerySnapshot<Map<String, dynamic>> querySnapshot = snapshot.data!;
        if (querySnapshot.docs.length == 0) {
          return Text('No matching document found');
        }
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            querySnapshot.docs[0];
        String documentId = documentSnapshot.id;
        Map<String, dynamic>? data = documentSnapshot.data();
        print('Found value in document with ID: $documentId');
        return Text(documentId);
      },
    );
  }
}

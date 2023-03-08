import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final String uid = FirebaseAuth.instance.currentUser!.uid;

final CollectionReference<Map<String, dynamic>> conversationRef =
    FirebaseFirestore.instance
        .collection('conversations')
        .doc('conversationId')
        .collection('messages');

Future<void> navnesen(String senderId, String text) async {
  await FirebaseFirestore.instance.collection('messages').doc('AMBSGSEf2m22wB2quUe4').collection('messages').add({
    'text': text,
    'senderId': senderId,
  });
}



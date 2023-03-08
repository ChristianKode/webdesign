import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final String uid = FirebaseAuth.instance.currentUser!.uid;

final CollectionReference<Map<String, dynamic>> conversationRef =
    FirebaseFirestore.instance
        .collection('conversations')
        .doc('conversationId')
        .collection('messages');

Future<void> navnesen(String senderId, String text, timestamp) async {
  await FirebaseFirestore.instance.collection('Messages').doc('0BFY9Ks3zxXFwJGzYinM').collection('messages').add({
    'text': text,
    'senderId': senderId,
    'timestamp' : timestamp
  });
}



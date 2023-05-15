import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final String uid = FirebaseAuth.instance.currentUser!.uid;
// Logic for loading conversations from database
final CollectionReference<Map<String, dynamic>> conversationRef =
    FirebaseFirestore.instance
        .collection('conversations')
        .doc('conversationId')
        .collection('messages');


Future<void> navnesen(
    String senderId, String text, timestamp, String docid) async {
  await FirebaseFirestore.instance
      .collection('Messages')
      .doc(docid)
      .collection('messages')
      .add({'text': text, 'senderId': senderId, 'timestamp': timestamp});
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final String uid = FirebaseAuth.instance.currentUser!.uid;
final messagesRef = FirebaseFirestore.instance
    .collection('messages')
    .doc('wbGLLFbLCI8hMYDzWlI5')
    .collection('messages');

Future<void> navnesen(String senderId, String recipientId) async {
  await FirebaseFirestore.instance.collection('messages').add({
    'senderId': senderId,
    'recipientId': recipientId,
  });
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

final Firestore = FirebaseFirestore.instance;

Future<String> getUserAid(String uid) async {
  DataSnapshot snapshot =
      Firestore.collection('Users').doc(uid).get() as DataSnapshot;

  String aid = snapshot.child('aid').value.toString();

  print(aid);
  return aid;
}

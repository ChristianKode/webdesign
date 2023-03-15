import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class CloudFirestoreServices {
  final _firestoreUsers = FirebaseFirestore.instance.collection('Users');
  final _firestoreMessages = FirebaseFirestore.instance.collection('Messages');

  Future<String> signUp(
      String uid, String firstname, String lastname, String telephone) async {
    try {
      await _firestoreUsers.doc(uid).set({
        'uid': uid,
        'firstname': firstname,
        'lastname': lastname,
        'telephone': telephone,
        'aid': ' '
      });
    } catch (e) {
      return e.toString();
    }
    return 'Success';
  }

  Future<String> getUserName(String uid) async {
    final dataSnapshot = await _firestoreUsers.doc(uid).get();
    String userName = '';

    final userData = dataSnapshot.data() as Map<dynamic, dynamic>;

    userName = userData['firstname'] + ' ' + userData['lastname'];

    return userName;
  }
}

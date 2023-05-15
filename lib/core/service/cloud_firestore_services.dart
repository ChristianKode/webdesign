import 'package:cloud_firestore/cloud_firestore.dart';

// CloudFireStoreServices class, aka database.
class CloudFirestoreServices {

  // Defines route for Users and Messages Collection in Firestore Cloud.
  final _firestoreUsers = FirebaseFirestore.instance.collection('Users');

   // Signup
  Future<String> signUp(
    // Adds credentials to database
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

  // Get username from uid
  Future<String> getUserName(String uid) async {
    final dataSnapshot = await _firestoreUsers.doc(uid).get();
    String userName = '';

    final userData = dataSnapshot.data() as Map<dynamic, dynamic>;

    userName = userData['firstname'] + ' ' + userData['lastname'];

    return userName;
  }
}

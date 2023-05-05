import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:webdesign/core/service/cloud_firestore_services.dart';

// Authetication Servicces Class
class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  // Notifies if the user state changes, such as login in or log out.
  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  // Login Logic.
  // Returns Innlogget or error message from Firebase.
  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Innlogget";
    } catch (e) {
      return e.toString();
    }
  }

  // Signup Logic.
  // If input is not empty, signup.
  // Returns ok or error message from Firebase.
  Future<String> signUp(String email, String password, String firstname,
      String lastname, String telephone) async {
    String ok = '';

    try {
      if (telephone.isNotEmpty &&
          firstname.isNotEmpty &&
          lastname.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty)
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

      String uid = FirebaseAuth.instance.currentUser!.uid;
      String ok = '';

      CloudFirestoreServices()
          .signUp(uid, firstname, lastname, telephone)
          .then((value) => ok = value);

      return ok;
    } catch (e) {
      return e.toString();
    }
  }

  // Forgot password logic.
  // Returns sent og error message from Firebase.
  // Firebase handles the email with password recovery.
  Future<String> forgotPass(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'sent';
    } catch (e) {
      return e.toString();
    }
  }

  // Logged in or not logic.
  // Checks if the user is currently loggen on.
  Future<bool> isLoggedIn() async {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }


}

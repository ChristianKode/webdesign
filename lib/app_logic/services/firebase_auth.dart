import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  // Login Logic
  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Innloggget";
    } catch (e) {
      return e.toString();
    }
  }

  // Signup Logic
  Future<String> signUp(String email, String password, String firstname, String lastname, String telephone) async {
    DatabaseReference ref =
    FirebaseDatabase.instance.ref("users");   
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

          String uid = FirebaseAuth.instance.currentUser!.uid;
          await ref.child(uid).set({
            "fornavn": firstname,
            "etternavn": lastname,
            "telefon": telephone,
            "uid": uid
          });
      return "registrert";
    } catch (e) {
      return e.toString();
    }
  }

  // Forgot password logic
  Future<String> forgotPass(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'sent';
    } catch (e) {
      return e.toString();
    }
  }

  // Logged in or not logic
  Future<bool> isLoggedIn() async {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }

  Future<String> getName(String uid) async {
    return uid;
  }
}

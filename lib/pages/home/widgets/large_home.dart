import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:webdesign/pages/home/widgets/home_top.dart';
import 'package:webdesign/pages/home/widgets69/home_info.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/widgets/navbarLoggedIn.dart';
import 'package:webdesign/widgets/navbarLoggedOut.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> isLoggedIn() async {
    final currentUser = await _auth.currentUser;
    return currentUser != null;
  }
}

class LargeHome extends StatelessWidget {
  LargeHome({super.key});

  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          FutureBuilder(
              future: _auth.isLoggedIn(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return NavBarIn();
                  } else {
                    return NavBarOut();
                  }
                } else {
                  return Login();
                }
              }),
          Top(),
        ]),
      ),
    );
  }
}

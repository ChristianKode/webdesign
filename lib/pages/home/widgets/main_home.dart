import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:webdesign/pages/home/widgets/home_top.dart';
import 'package:webdesign/pages/home/widgets/job_list.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/widgets/footer_overall.dart';
import 'package:webdesign/widgets/navbar.dart';

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
        child: Column(children: <Widget>[
          NavBar(),
          const Top(),
          JobList(),
          Container(
            height: 600,
            color: Colors.blue,
          ),
          const Footer()
        ]),
      ),
    );
  }
}

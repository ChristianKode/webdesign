import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:webdesign/pages/home/appbar.dart';
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context, scaffoldKey),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          const Top(),
          JobList(),
          
          const Footer()
        ]),
      ),
    );
  }
}

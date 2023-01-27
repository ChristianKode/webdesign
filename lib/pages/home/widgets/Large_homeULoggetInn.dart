import 'dart:html';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:webdesign/pages/home/widgets/home_info.dart';
import 'package:webdesign/widgets/navbarLoggedIn.dart';
import 'package:webdesign/widgets/navbarLoggedOut.dart';

class LargeHomeIn extends StatelessWidget {
  final TextEditingController mail = TextEditingController();
  final TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/home_background.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[NavBarIn(), HomeInfo()],
        ),
      ),
    );
  }
}
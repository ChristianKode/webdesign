import 'dart:html';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:webdesign/pages/home/widgets/adventues.dart';
import 'package:webdesign/pages/home/widgets/home_info.dart';
import 'package:webdesign/widgets/navbarLoggedIn.dart';
import 'package:webdesign/widgets/navbarLoggedOut.dart';

class LargeHomeIn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
                children: <Widget>[NavBarIn(), HomeInfo(),],
              ),
        
          );
        
      
    
  }
}
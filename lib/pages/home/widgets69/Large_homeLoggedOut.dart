import 'package:flutter/material.dart';
import 'package:webdesign/pages/home/widgets69/home_info.dart';
import 'package:webdesign/widgets/navbarLoggedOut.dart';

class LargeHomeOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/home_background.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[NavBarOut(), HomeInfo()],
        ),
      ),
    );
  }
}

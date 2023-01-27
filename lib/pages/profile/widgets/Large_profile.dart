import 'package:flutter/material.dart';
import 'package:webdesign/widgets/navbarLoggedIn.dart';

class LargeProfile extends StatelessWidget {
  const LargeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.amber, Colors.red] 
        )
      ),
        child: Column(
          children: <Widget>[NavBarIn()],
        ),
      ),
    );
  }
}
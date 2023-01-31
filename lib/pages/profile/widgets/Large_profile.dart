import 'package:flutter/material.dart';
import 'package:webdesign/pages/profile/profile.dart';
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
          colors: [Color.fromRGBO(240, 95, 87, 1.0), Color.fromRGBO(54, 9, 64, 1.0)] 
        )
      ),
        child: Column(
          children: <Widget>[NavBarIn(), ProfileContent()],
        ),
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
          alignment: Alignment.center,
          height: 400,
          width: 1200,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 1035, top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: Colors.black
                  ),
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image(image: const AssetImage("images/Profile.jpg"))),
                ),
              )
            ],
          )
        ),
      );
  }
}
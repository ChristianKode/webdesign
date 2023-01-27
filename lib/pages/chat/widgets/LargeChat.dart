import 'package:flutter/material.dart';
import 'package:webdesign/widgets/navbarLoggedIn.dart';

class LargeChat extends StatelessWidget {
  const LargeChat({super.key});

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
          children: <Widget>[NavBarIn(), ChatContent()],
        ),
      ),
    );
  }
}

class ChatContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
          alignment: Alignment.centerRight,
          height: 480,
          width: 700,
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
                ),
              )
            ],
          )
        ),
      );
  }
}
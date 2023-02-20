// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:webdesign/widgets/navbar.dart';


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
      child: Stack(
        children: [
          Container(
            alignment: Alignment.centerRight,
            height: 480,
            width: 900,
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
          Container(
            height: 480,
            width: 186,
            color: Colors.black,
          ),
          Container(
            height: 480,
            width: 185,
            color: Colors.white,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 50)),
            const SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                child: Image(image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2FProfile.jpg?alt=media&token=6c8c561b-8202-4e3b-9c6e-f8df074a5162")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 55, top: 10),
            child: TextButton(
             onPressed: () { 
              
              },
              child: const Text("Benjamin Csaplar")
            )
          ),
        ]
      ),
    );
  }
}


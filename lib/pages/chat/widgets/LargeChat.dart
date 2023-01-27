import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.amber, Colors.red] 
        )
      ),
    );
  }
}

class LargeChat extends StatelessWidget {
  const LargeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_login.jpg'),
                fit: BoxFit.cover),
          ),
          child: Row(children: [ChatView()])),
    );
  }
}
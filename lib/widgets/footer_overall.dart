import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
      child: Column(
        children: const [
          Text('KodeKlubben AS')
        ],
      ),
    );
  }
}
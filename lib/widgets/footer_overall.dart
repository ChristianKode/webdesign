import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      child: Column(
        children: [
          Center(child: Text('KodeKlubben AS')),
        ],
      ),
    );
  }
}

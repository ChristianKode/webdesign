import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: const [
          Center(child: Text('KodeKlubben AS')),
        ],
      ),
    );
  }
}

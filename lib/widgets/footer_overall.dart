import 'package:flutter/material.dart';

import '../utils/theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ungansatt UB',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: appColor)),
        ],
      ),
    );
  }
}

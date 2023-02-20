import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavWidget extends StatelessWidget {

  bool smallscreen = false;



  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          height: 80,
          width: 80,
          child:
          Image.network(
              "https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2FUngLogo.png?alt=media&token=672878c7-db3a-4a1a-950f-e9c3cb4e334c"),
        ),
        const SizedBox(
          width: 16,
        ),
        Text.rich(TextSpan(style: const TextStyle(fontSize: 40), children: [
          TextSpan(
              text: 'UNG',
              style: GoogleFonts.tinos(fontWeight: FontWeight.bold)),
          TextSpan(text: 'ANSATT', style: GoogleFonts.tinos())
        ]))
      ],
    );
  }
}

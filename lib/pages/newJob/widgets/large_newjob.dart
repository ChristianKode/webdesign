import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LargeNewJob extends StatelessWidget {
  const LargeNewJob({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/newjob_background.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          children: const [
            Nav(),
            BodyContent(),
          ],
        ),
      ),
    );
  }
}

class Nav extends StatelessWidget {
  const Nav({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: () {},
            child:
                (Text.rich(TextSpan(style: TextStyle(fontSize: 70), children: [
              TextSpan(
                  text: 'UNG',
                  style: GoogleFonts.tinos(fontWeight: FontWeight.bold)),
              TextSpan(text: 'ANSATT', style: GoogleFonts.tinos())
            ]))))
      ],
    );
  }
}

class BodyContent extends StatelessWidget {
  const BodyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

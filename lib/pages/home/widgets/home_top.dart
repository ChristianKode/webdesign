import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Top extends StatelessWidget {
  const Top({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(maxHeight: 900, minHeight: 700),
      width: double.maxFinite,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/home_background.jpg'),
              fit: BoxFit.cover)),
      child: Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text.rich(TextSpan(
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '  Søk blant',
                            style: GoogleFonts.tinos(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        TextSpan(
                            text: ' jobber',
                            style: GoogleFonts.tinos(
                                color: const Color.fromRGBO(102, 82, 143, 1.0)))
                      ])),
                  Text.rich(TextSpan(
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: 'som passer',
                            style:
                                GoogleFonts.tinos(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: ' deg',
                            style: GoogleFonts.tinos(
                                color: const Color.fromRGBO(102, 82, 143, 1.0)))
                      ])),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

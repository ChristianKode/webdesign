import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class Top extends StatelessWidget {
  const Top({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fhome_background.jpg?alt=media&token=70c845e5-5de0-4e6d-9ab8-f5239d5a4744'),
              fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 250),
            child: Container(
              alignment: Alignment.topLeft,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: SizedBox(width: 300, child: TextField()),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

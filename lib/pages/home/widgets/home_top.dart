import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class Top extends StatelessWidget {
   Top({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fhome_background.jpg?alt=media&token=70c845e5-5de0-4e6d-9ab8-f5239d5a4744'),
              fit: BoxFit.cover)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.25),
              child: Column(
                children: [
                  Text.rich(TextSpan(
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: 'Gjør det',
                            style: GoogleFonts.tinos(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        TextSpan(
                            text: ' enkelt,',
                            style: GoogleFonts.tinos(
                              color: Color.fromARGB(255, 20, 141, 255),
                            ))
                      ])),
                  Text.rich(TextSpan(
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '+47',
                            style: GoogleFonts.tinos(
                                fontWeight: FontWeight.bold,
                                color:
                                    const Color.fromARGB(255, 20, 141, 255))),
                        TextSpan(
                            text: ' 968 17 835', style: GoogleFonts.tinos())
                      ])),


                ],
              ),
            )
          ]),
    );
  }
}

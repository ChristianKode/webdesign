import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webdesign/core/utils/responsive/responsive.dart';


// Header, image and text
class Top extends StatelessWidget {
  const Top({super.key});

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
          crossAxisAlignment: !ResponsiveLayout.isSmallScreen(context)
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: !ResponsiveLayout.isSmallScreen(context)
                      ? MediaQuery.of(context).size.width * 0.25
                      : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SelectableText.rich(TextSpan(
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: 'Trenger du hjelp, ',
                              style: GoogleFonts.tinos(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          TextSpan(
                              text: 'ring her',
                              style: GoogleFonts.tinos(
                                color: const Color.fromARGB(255, 20, 141, 255),
                              ))
                        ])),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SelectableText.rich(TextSpan(
                        style: const TextStyle(
                            fontSize: 45, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: '+47 ',
                              style: GoogleFonts.tinos(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 20, 141, 255))),
                          TextSpan(
                              text: ' 484 50 986', style: GoogleFonts.tinos())
                        ])),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}

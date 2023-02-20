import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webdesign/utils/responsive.dart';

class HomeBodyInfo extends StatelessWidget {
  const HomeBodyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: 1500,
        height: 400,
        color: Color.fromARGB(255, 0, 75, 214),
        child: 
        !ResponsiveLayout.isSmallScreen(context) ?    Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text.rich(TextSpan(
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: '  Søk blant',
                          style: GoogleFonts.tinos(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      TextSpan(
                          text: ' jobber',
                          style: GoogleFonts.tinos(
                              color: const Color.fromRGBO(102, 82, 143, 1.0)))
                    ])),
                Text.rich(TextSpan(
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
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

                ElevatedButton(onPressed: (){}, child: Text('Vis annonser'))

                
              ],
            ),

            Column(
              children: [
                Container(
                  width: 300,
                  height: 300,
                  child: Image.network('https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fgarbage-recycle.png?alt=media&token=e66338fc-4139-428f-acc8-7c58d1bea75f',
                  fit: BoxFit.cover,),
                )
              ],
            )
          ],
        ) : 
                    Column(
              children: [
                Text.rich(TextSpan(
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: '  Søk blant',
                          style: GoogleFonts.tinos(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      TextSpan(
                          text: ' jobber',
                          style: GoogleFonts.tinos(
                              color: const Color.fromRGBO(102, 82, 143, 1.0)))
                    ])),
                Text.rich(TextSpan(
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
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

                ElevatedButton(onPressed: (){}, child: Text('Vis annonser'))

                
              ],
            ),
      
    );
  }
}
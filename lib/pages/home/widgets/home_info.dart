import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/home_background.jpg"),
                        fit: BoxFit.cover,
    
                        ),
                        ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120, right: 750),
                child: SizedBox(
                  width: 300,
                  height: 300,
                    child: Column(
                      children: [
                        Text.rich(TextSpan(style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold), children: [
                          TextSpan(
                            text: '  Søk blant',
                            style: GoogleFonts.tinos(fontWeight: FontWeight.bold, color: Colors.black)),
                          TextSpan(text: ' jobber', style: GoogleFonts.tinos(color: const Color.fromRGBO(102, 82, 143, 1.0)))
                          ]
                        )
                      ),
                      Text.rich(TextSpan(style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold), children: [
                          TextSpan(
                            text: 'som passer',
                            style: GoogleFonts.tinos(fontWeight: FontWeight.bold)),
                          TextSpan(text: ' deg', style: GoogleFonts.tinos(color: const Color.fromRGBO(102, 82, 143, 1.0))),
    
                          
                          ]
                        )
                      ),
                      TextField(
                        
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 1000,
                color: Colors.pink,
              )
            ],
          ),
        
      ),
    );
  }
}

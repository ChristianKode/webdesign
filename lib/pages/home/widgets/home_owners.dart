import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeOwners extends StatelessWidget {
  const HomeOwners({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 700,
      color: Color.fromARGB(255, 2, 0, 126),
      child: Center(
        child: Container(
          width: 1500,
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Container(
                width: 1000,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  
                  children: [
                    Text.rich(TextSpan(
                        style: const TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: 'UngAnsatt-',
                              style: GoogleFonts.tinos(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ])),
                    Text.rich(TextSpan(
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: 'Jobberfaring for deg',
                              style: GoogleFonts.tinos(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ])),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipPath(
                    clipper: MyCustomClipper(),
                    child: Container(
                      width: 450,
                      height: 400,
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2FMicrosoftTeams-image.png?alt=media&token=ac991ae8-fddd-4011-aef7-c5eadbad34f3',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width - 100, 0);
    path.lineTo(size.width, 100);
    path.lineTo(size.width, size.height);
    path.lineTo(100, size.height);
    path.lineTo(0, size.height - 100);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webdesign/utils/responsive.dart';

class HomeOwners extends StatelessWidget {
  const HomeOwners({super.key});

  @override
  Widget build(BuildContext context) {
    return !ResponsiveLayout.isSmallScreen(context)
        ? const LargeHomeOwnersWidget()
        : const SmallHomeOwnersWidget();
  }
}

class SmallHomeOwnersWidget extends StatelessWidget {
  const SmallHomeOwnersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      color: const Color.fromARGB(255, 67, 46, 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: 'UngAnsatt-',
                    style: GoogleFonts.tinos(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ])),
          Text.rich(TextSpan(
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: 'Jobberfaring for deg',
                    style: GoogleFonts.tinos(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ])),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text('Visjonen vår er å få ungdom ut i arbeid',
                style: GoogleFonts.tinos(fontSize: 30, color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Text(
              'og skape dem erfaring for resten av livet',
              style: GoogleFonts.tinos(fontSize: 30, color: Colors.white),
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Plukk etter preferansen din',
                  style: GoogleFonts.tinos(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class LargeHomeOwnersWidget extends StatelessWidget {
  const LargeHomeOwnersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      color: const Color.fromARGB(255, 67, 46, 140),
      child: SizedBox(
        width: 1500,
        height: 700,
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontSize: 35, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: 'Jobberfaring for deg',
                            style: GoogleFonts.tinos(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ])),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text('Visjonen vår er å få ungdom ut i arbeid',
                        style: GoogleFonts.tinos(
                            fontSize: 30, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      'og skape dem erfaring for resten av livet',
                      style:
                          GoogleFonts.tinos(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Plukk etter preferansen din',
                          style: GoogleFonts.tinos(
                              color: Colors.white, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Plukk etter preferansen din',
                            style: GoogleFonts.tinos(
                                color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: SizedBox(
                        height: 35,
                        width: 180,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(255, 44, 176, 110)),
                            onPressed: () {},
                            child: const Text(
                              'Utforsk',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Container(
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.width,
                child: ClipPath(
                  clipper: MyCustomClipper(),
                  child: SizedBox(
                    width: 400,
                    height: 350,
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2FMicrosoftTeams-image.png?alt=media&token=ac991ae8-fddd-4011-aef7-c5eadbad34f3',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
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

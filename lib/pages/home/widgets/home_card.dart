import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webdesign/pages/newJob/newjob.dart';
import 'package:webdesign/utils/responsive.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: const Color.fromARGB(7, 0, 0, 0),
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 80, bottom: 80, left: 20, right: 20),
          child: Container(
            width: 1500,
            height: !ResponsiveLayout.isSmallScreen(context) ? 300 : 500,
            color: const Color.fromARGB(255, 20, 141, 255),
            child: !ResponsiveLayout.isSmallScreen(context)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(TextSpan(
                              style: const TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: 'Søk blant',
                                    style: GoogleFonts.tinos(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                TextSpan(
                                    text: ' jobber',
                                    style: GoogleFonts.tinos(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255)))
                              ])),
                          Text.rich(TextSpan(
                              style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              children: [
                                TextSpan(
                                    text: 'som passer',
                                    style: GoogleFonts.tinos(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: ' deg',
                                    style: GoogleFonts.tinos(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255)))
                              ])),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: SizedBox(
                                height: 35,
                                width: 180,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white),
                                    onPressed: () {},
                                    child: const Text(
                                      'Vis meg',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 20, 141, 255),
                                      ),
                                    ))),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 300,
                            height: 300,
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fgarbage-recycle.png?alt=media&token=e66338fc-4139-428f-acc8-7c58d1bea75f',
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(
                          style: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: 'Opprett',
                                style: GoogleFonts.tinos(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            TextSpan(
                                text: ' annonser',
                                style: GoogleFonts.tinos(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255)))
                          ])),
                      Text.rich(TextSpan(
                          style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          children: [
                            TextSpan(
                                text: 'enkelt og ',
                                style: GoogleFonts.tinos(
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: ' greit',
                                style: GoogleFonts.tinos(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255)))
                          ])),
                      SizedBox(
                        height: 220,
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fgarbage-recycle.png?alt=media&token=e66338fc-4139-428f-acc8-7c58d1bea75f'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SizedBox(
                            height: 35,
                            width: 200,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                onPressed: () {
                                  Get.to(() => const NewJob());
                                },
                                child: const Text(
                                  'Vis meg',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 20, 141, 255),
                                  ),
                                ))),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

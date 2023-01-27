import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';


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
        child: SingleChildScrollView(
          child: Column(
            children: [Nav(), FillOut1()],
          ),
        ),
      ),
    );
  }
}


class Nav extends StatelessWidget {
  const Nav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {},
              child: (Text.rich(
                  TextSpan(style: const TextStyle(fontSize: 70), children: [
                TextSpan(
                    text: 'UNG',
                    style: GoogleFonts.tinos(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(
                    text: 'ANSATT',
                    style: GoogleFonts.tinos(
                        color: const Color.fromRGBO(102, 82, 143, 1.0)))
              ]))))
        ],
      ),
    );
  }
}

class FillOut1 extends StatelessWidget {
  FillOut1({super.key});

  //Controllers to save input
  final TextEditingController title = TextEditingController();
  final TextEditingController descprition = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Container(
          height: 500,
          width: 450,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text('Hva skal utføres?',
                  style: GoogleFonts.tinos(
                      fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: title,
                  decoration: const InputDecoration(
                    labelText: 'Overskrift',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(102, 82, 143, 1.0), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                width: 350,
                child: TextField(
                  controller: descprition,
                  decoration: const InputDecoration(
                    labelText: 'Beskrivelse',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(102, 82, 143, 1.0), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                  ),
                  minLines: 10,
                  maxLines: 10,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2)),
                        backgroundColor:
                            const Color.fromRGBO(102, 82, 143, 1.0)),
                    child: const Text(
                      'Kategoriser',
                      style: TextStyle(fontSize: 15),
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}

class FillOut2 extends StatelessWidget {
  const FillOut2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Container(
          height: 500,
          width: 600,
          decoration: const BoxDecoration(color: Colors.white),
        )
      ],
    );
  }
}

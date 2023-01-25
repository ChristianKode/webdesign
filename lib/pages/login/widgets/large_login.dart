import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../register/register.dart';

class LargeLogin extends StatelessWidget {
  const LargeLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_login.jpg'),
                fit: BoxFit.cover),
          ),
          child: Row(children: [LoginBox(), const LoginInfo()])),
    );
  }
}

class LoginInfo extends StatelessWidget {
  const LoginInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.only(left: 200, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              Text(
                '70"Neque porro quisquam est qui dolorem ipsum quia" ',
                style: GoogleFonts.tinos(
                  fontSize: 50,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(const Register());
                  },
                  child: (Text(
                    'Lag ny bruker her',
                    style: GoogleFonts.tinos(fontSize: 20),
                  ))),
              const SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/hvitlogo.png',
                  fit: BoxFit.contain,
                  height: 250,
                  width: 250,
                ),
              )
            ],
          ),
        ));
  }
}

class LoginBox extends StatelessWidget {
  LoginBox({
    super.key,
  });

  final TextEditingController mail = TextEditingController();
  final TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 150,
          ),
          Text.rich(TextSpan(style: const TextStyle(fontSize: 60), children: [
            TextSpan(
                text: 'UNG',
                style: GoogleFonts.tinos(fontWeight: FontWeight.bold)),
            TextSpan(text: 'ANSATT', style: GoogleFonts.tinos())
          ])),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
            child: SizedBox(
              width: 360,
              child: TextField(
                  controller: mail,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(102, 82, 143, 1.0), width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    )),
                    hintText: 'Epost',
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
            child: SizedBox(
              width: 360,
              child: TextField(
                controller: pass,
                obscureText: true,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(102, 82, 143, 1.0), width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  )),
                  hintText: 'Passord',
                ),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                print(mail.text);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                backgroundColor: const Color.fromRGBO(102, 82, 143, 1.0),
              ),
              child: const Text(
                'Logg på',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                
              },
              child: (Text(
                'Glemt passord?',
                style: GoogleFonts.tinos(fontSize: 20),
              ))),
        ],
      ),
    ));
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/app_logic/services/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:firebase_database/firebase_database.dart';

class LargeRegister extends StatelessWidget {
  const LargeRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/register_background.jpg'),
                fit: BoxFit.cover)),
        child: RegisterBox(),
      ),
    );
  }
}

class RegisterBox extends StatelessWidget {
  RegisterBox({
    super.key,
  });

  final TextEditingController fornavnCon = TextEditingController();
  final TextEditingController etternavnCon = TextEditingController();
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passwordCon = TextEditingController();
  final TextEditingController telefonCon = TextEditingController();

  bool ValidCredentials() {
    bool valid = false;
    if (fornavnCon.text.isNotEmpty & etternavnCon.text.isNotEmpty) {
      if (emailCon.text.contains('@')) {
        if (passwordCon.text.length > 6) {
          if (telefonCon.text.length > 8) {
            valid = true;
            print('true');
          }
        } else {
          //feil pass
          //valid = false;
        }
      } else {
        //feil epost
        //valid = false;
      }
    } else {
      //feil navn
      //valid = false;
    }
    return valid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 500,
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Text(
              'Velkommen',
              style: GoogleFonts.tinos(
                  fontSize: 50, color: const Color.fromRGBO(102, 82, 143, 1.0)),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                    child: SizedBox(
                      child: TextField(
                          controller: fornavnCon,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(102, 82, 143, 1.0),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            )),
                            hintText: 'Fornavn',
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                    child: SizedBox(
                      child: TextField(
                          controller: etternavnCon,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(102, 82, 143, 1.0),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            )),
                            hintText: 'Etternavn',
                          )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              child: SizedBox(
                child: TextField(
                  controller: emailCon,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(102, 82, 143, 1.0),
                              width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      hintText: 'Epost'),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                    child: SizedBox(
                      child: TextField(
                          controller: passwordCon,
                          obscureText: true,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(102, 82, 143, 1.0),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            )),
                            hintText: 'Passord',
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                    child: SizedBox(
                      child: TextField(
                          controller: telefonCon,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(102, 82, 143, 1.0),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            )),
                            hintText: 'Telefon',
                          )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 160,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    final String fornavn = fornavnCon.text;
                    final String etternavn = etternavnCon.text;
                    final String telefon = telefonCon.text;

                    DatabaseReference ref =
                        FirebaseDatabase.instance.ref("users");

                    context
                        .read<AuthService>()
                        .signUp(emailCon.text.trim(), passwordCon.text.trim())
                        .then((value) async {
                      User? user = FirebaseAuth.instance.currentUser;

                      String uid = FirebaseAuth.instance.currentUser!.uid;

                      await ref.child(uid).set({
                        "fornavn": fornavn,
                        "etternavn": etternavn,
                        "telefon": telefon,
                        "uid": uid
                      });

                      Get.to(() => const Login());
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      backgroundColor: const Color.fromRGBO(102, 82, 143, 1.0)),
                  child: const Text(
                    'Lag bruker',
                    style: TextStyle(fontSize: 15),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

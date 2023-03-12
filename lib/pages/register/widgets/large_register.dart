// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/app_logic/services/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:webdesign/pages/home/widgets/main_home.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

import '../../../widgets/appbar.dart';
import '../../../widgets/drawer.dart';

class LargeRegister extends StatelessWidget {
  LargeRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fbakgrunn.png?alt=media&token=5dec6ed3-4f53-469f-bf00-9d094e25cf07'),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 500,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Velkommen',
                style: GoogleFonts.tinos(fontSize: 50, color: Colors.blue),
              ),
              Flexible(
                child: Container(
                  width: 350,
                  height: 350,
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2FMobile%20login-amico.png?alt=media&token=a979210e-0052-4442-9434-b3985e40e387',
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 0),
                      child: SizedBox(
                        child: TextField(
                            controller: fornavnCon,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
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
                  const SizedBox(
                    height: 7,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 0),
                      child: SizedBox(
                        child: TextField(
                            controller: etternavnCon,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
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
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                child: SizedBox(
                  child: TextField(
                    controller: emailCon,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        hintText: 'Epost'),
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 0),
                      child: SizedBox(
                        child: TextField(
                            controller: passwordCon,
                            obscureText: true,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
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
                  const SizedBox(
                    height: 7,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 0),
                      child: SizedBox(
                        child: TextField(
                            controller: telefonCon,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
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
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 160,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () async {
                          String registerResult = await context
                              .read<AuthService>()
                              .signUp(
                                  emailCon.text.trim(),
                                  passwordCon.text.trim(),
                                  fornavnCon.text.trim(),
                                  etternavnCon.text.trim(),
                                  telefonCon.text.trim());

                          if (registerResult == 'Success') {
                            Get.to(() => LargeHome());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text('Noe gikk galt...'),
                                duration: const Duration(seconds: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side:
                                      BorderSide(color: Colors.blue, width: 2),
                                ),
                                action: SnackBarAction(
                                  label: 'Lukk',
                                  textColor: Colors.white, // set text color
                                  onPressed: ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar,
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            backgroundColor: Colors.blue),
                        child: const Text(
                          'Lag bruker',
                          style: TextStyle(fontSize: 15),
                        )),
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(LargeHome());
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          backgroundColor: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.blue,
                            ),
                            Text(
                              'Tilbake',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue),
                            ),
                          ],
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

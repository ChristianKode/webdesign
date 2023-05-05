// ignore_for_file: unused_import, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/core/service/authentication_services.dart';
import 'package:get/get.dart';
import 'package:webdesign/core/utils/responsive/theme.dart';
import 'package:webdesign/pages/home/widgets/main_home.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import '../../../core/utils/widgets/appbar.dart';
import '../../../core/utils/widgets/drawer.dart';

class LargeRegister extends StatelessWidget {
  const LargeRegister({super.key});

  @override
  Widget build(BuildContext context) {
    // Creates a visual scaffold for Material Design Widgets.
    return Scaffold(
      // Container decorated with an image for the background.
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fbakgrunn.png?alt=media&token=5dec6ed3-4f53-469f-bf00-9d094e25cf07'),
                // The image will cover the screen.
                fit: BoxFit.cover)),
                // RegisterBox widget displayed.
        child: RegisterBox(),
      ),
    );
  }
}

class RegisterBox extends StatelessWidget {
  RegisterBox({
    super.key,
  });

  // Controllers to track input.
  final TextEditingController fornavnCon = TextEditingController();
  final TextEditingController etternavnCon = TextEditingController();
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passwordCon = TextEditingController();
  final TextEditingController telefonCon = TextEditingController();

  // All the textfields have each controller.


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 500,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          // This Column includes the main components in this widget. A Column is vertical.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Velkommen',
                style: GoogleFonts.tinos(fontSize: 50, color: appColor),
              ),
              // Makes the image in the SizedBox flexible/responsive.
              Flexible(
                child: SizedBox(
                  width: 350,
                  height: 350,
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2FMobile%20login-amico.png?alt=media&token=a979210e-0052-4442-9434-b3985e40e387',
                  ),
                ),
              ),
              // A Row is needed to have to widgets horizontally.
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 0),
                      child: SizedBox(
                        child: TextField(
                            controller: fornavnCon,
                            // Decoration for the field, round corner and custom color.
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: appColor, width: 2),
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
                  // Space between the fields.
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
                                      BorderSide(color: appColor, width: 2),
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
              // Space between the fields.
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
                            borderSide: BorderSide(color: appColor, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        hintText: 'Epost'),
                  ),
                ),
              ),
              // Space between the fields.
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
                                      BorderSide(color: appColor, width: 2),
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
                  // Space between the fields.
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
                                      BorderSide(color: appColor, width: 2),
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
              // Space between the fields.
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
                          // Register function, connected to backend with Provider plugin. Await is important so it will wait for it to be finished.
                          String registerResult = await context
                              .read<AuthService>()
                              .signUp(
                                //Linking the controller inputs.
                                  emailCon.text.trim(),
                                  passwordCon.text.trim(),
                                  fornavnCon.text.trim(),
                                  etternavnCon.text.trim(),
                                  telefonCon.text.trim());

                          // .signUp will return Success or a Firebase error message.
                          // We can use this to information to check if the registration went through or not.

                          if (registerResult == 'Success') {
                            // In this case it went through so the user will be logged in and taken to home page.
                            Get.to(() => LargeHome());
                          } else {
                            // If not the user will get a snackbar.
                            // A Snackbar can be used to display error messages.
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                // Here is the style set for the snakbar.
                                behavior: SnackBarBehavior.floating,
                                content: const Text('Noe gikk galt...'),
                                duration: const Duration(seconds: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      color: appColor, width: 2),
                                ),
                                // This snackbar has a closing button.
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
                            backgroundColor: appColor),
                        child: const Text(
                          'Lag bruker',
                          style: TextStyle(fontSize: 15),
                        )),
                  ),
                  // Back button, if you set a button in a box or container it will take up its whole space.
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(LargeHome());
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: appColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          backgroundColor: Colors.white,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: appColor,
                            ),
                            Text(
                              'Tilbake',
                              style: TextStyle(fontSize: 15, color: appColor),
                            ),
                          ],
                        )),
                  )
                ],
              ),
              // Space between the fields.
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


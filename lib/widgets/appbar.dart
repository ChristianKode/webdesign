// ignore_for_file: sized_box_for_whitespace

import 'dart:js';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/app_logic/services/firebase_auth.dart';
import 'package:webdesign/pages/chat/widgets/large_chat.dart';
import 'package:webdesign/pages/home/widgets/main_home.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/pages/profile/profile_view.dart';
import '../main.dart';
import '../utils/responsive.dart';
import '../pages/newJob/newjob.dart';
import '../pages/register/register.dart';

class ProfilItem extends StatelessWidget {
  const ProfilItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: SizedBox(
        width: 90,
        height: 35,
        child: TextButton(
          onPressed: () {
            router.navigateTo(context, '/Profile',
                transition: TransitionType.fadeIn);
          },
          child: const Text(
            'Profil ',
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class NyAnnonseItem extends StatelessWidget {
  const NyAnnonseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: SizedBox(
        width: 120,
        height: 35,
        child: TextButton(
          onPressed: () {
            router.navigateTo(context, '/NewJob',
                transition: TransitionType.fadeIn);
          },
          child: const Text(
            'Ny Annonse ',
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: SizedBox(
          width: 90,
          height: 35,
          child: TextButton(
            onPressed: () {
              router.navigateTo(context, '/Chat',
                  transition: TransitionType.fadeIn);
            },
            child: const Text(
              'Chat ',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}

class LoginItem extends StatelessWidget {
  const LoginItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
          onPressed: () {
            router.navigateTo(context, '/Login',
                transition: TransitionType.fadeIn);
          },
          style: ElevatedButton.styleFrom(
            side: const BorderSide(color: Colors.blue),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            backgroundColor: Colors.white,
          ),
          child: const Text(
            'Logg på',
            style: TextStyle(fontSize: 15, color: Colors.blue),
          )),
    );
  }
}

class RegisterItem extends StatelessWidget {
  const RegisterItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
          onPressed: () {
            router.navigateTo(context, '/Register',
                transition: TransitionType.fadeIn);
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              backgroundColor: Colors.blue),
          child: const Text(
            'Bli med',
            style: TextStyle(fontSize: 15),
          )),
    );
  }
}

AppBar appBar(BuildContext context, GlobalKey<ScaffoldState> key) => AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 80,
      leadingWidth: !ResponsiveLayout.isSmallScreen(context) ? 85 : 60,
      leading: FutureBuilder(
          // Left side icon
          future: context.read<AuthService>().isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                // Logged in
                return !ResponsiveLayout.isSmallScreen(context)
                    ? Row(children: [
                        // Large screen
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2FLogoUngNY.png?alt=media&token=aaf84632-867b-4a02-a9c6-2efb3be7a417',
                            width: 75,
                          ),
                        ),
                      ])
                    : IconButton(
                        // Small screen
                        onPressed: () {
                          key.currentState?.openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black,
                        ));
              } else {
                // Logged out
                return !ResponsiveLayout.isSmallScreen(context)
                    ? Row(children: [
                        // Large screen
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2FLogoUngNY.png?alt=media&token=aaf84632-867b-4a02-a9c6-2efb3be7a417',
                            width: 75,
                          ),
                        ),
                      ])
                    : IconButton(
                        // Small screen
                        onPressed: () {
                          key.currentState?.openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black,
                        ));
              }
            } else {
              // Firebase error
              return Login();
            }
          }),
      title: FutureBuilder(
          // Main section of the custom appbar
          future: context.read<AuthService>().isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                // Logging In
                // Small or Wide Screen?
                return !ResponsiveLayout.isSmallScreen(context)
                    // Wide Screen
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onTap: () {
                                Get.to(() => LargeHome());
                              },
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text.rich(
                                  TextSpan(
                                      style: const TextStyle(fontSize: 40),
                                      children: [
                                        TextSpan(
                                            text: 'UNG',
                                            style: GoogleFonts.tinos(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: 'ANSATT',
                                            style: GoogleFonts.tinos(
                                                color: Colors.black))
                                      ]),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 760,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    right: 5, top: 11, bottom: 11),
                                child: NyAnnonseItem()),
                            Padding(
                                padding: const EdgeInsets.only(
                                    right: 5, top: 11, bottom: 11),
                                child: ChatItem()),
                            Padding(
                                padding: const EdgeInsets.only(
                                    right: 5, top: 11, bottom: 11),
                                child: ProfilItem()),
                          ],
                        ),
                      )

                    // Small Screen
                    : InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          Get.to(() => LargeHome());
                        },
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text.rich(
                            TextSpan(
                                style: const TextStyle(fontSize: 40),
                                children: [
                                  TextSpan(
                                      text: 'UNG',
                                      style: GoogleFonts.tinos(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  TextSpan(
                                      text: 'ANSATT',
                                      style: GoogleFonts.tinos(
                                          color: Colors.black))
                                ]),
                          ),
                        ),
                      );
              } else {
                // Logged Out
                // Small or Wide Screen
                return !ResponsiveLayout.isSmallScreen(context)

                    // Wide Screen
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onTap: () {
                                Get.to(() => LargeHome());
                              },
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text.rich(
                                  TextSpan(
                                      style: const TextStyle(fontSize: 40),
                                      children: [
                                        TextSpan(
                                            text: 'UNG',
                                            style: GoogleFonts.tinos(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: 'ANSATT',
                                            style: GoogleFonts.tinos(
                                                color: Colors.black))
                                      ]),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 675,
                            ),
                            Container(
                              width: 145,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, top: 11, bottom: 11),
                                  child: LoginItem()),
                            ),
                            SizedBox(
                              width: 145,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, top: 11, bottom: 11),
                                  child: RegisterItem()),
                            ),
                          ],
                        ),
                      )

                    // Small Screen
                    : InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          Get.to(() => LargeHome());
                        },
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text.rich(
                            TextSpan(
                                style: const TextStyle(fontSize: 40),
                                children: [
                                  TextSpan(
                                      text: 'UNG',
                                      style: GoogleFonts.tinos(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  TextSpan(
                                      text: 'ANSATT',
                                      style: GoogleFonts.tinos(
                                          color: Colors.black))
                                ]),
                          ),
                        ),
                      );
              }
            } else {
              // No connection with Firebase Auth. . .
              return Login();
            }
          }),
    );

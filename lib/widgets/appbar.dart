// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/app_logic/services/firebase_auth.dart';
import 'package:webdesign/pages/home/widgets/main_home.dart';
import 'package:webdesign/pages/login/login.dart';
import '../utils/responsive.dart';
import '../pages/chat/widgets/chat_page.dart';
import '../pages/newJob/newjob.dart';
import '../pages/profile/profile.dart';
import '../pages/register/register.dart';

profil() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 7),
    child: SizedBox(
      width: 90,
      height: 35,
      child: TextButton(
        onPressed: () {
          Get.to(const Profile());
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

nyAnnonse() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 7),
    child: SizedBox(
      width: 120,
      height: 35,
      child: TextButton(
        onPressed: () {
          Get.to(const NewJob());
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

chatItem() {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: SizedBox(
        width: 90,
        height: 35,
        child: TextButton(
          onPressed: () {
            Get.to(Chattos());
          },
          child: const Text(
            'Chat ',
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ));
}

logInItem() {
  return SizedBox(
    width: 100,
    height: 50,
    child: ElevatedButton(
        onPressed: () {
          Get.to(const Login());
        },
        style: ElevatedButton.styleFrom(
          side: const BorderSide(color: Colors.blue),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: Colors.white,
        ),
        child: const Text(
          'Logg på',
          style: TextStyle(fontSize: 15, color: Colors.blue),
        )),
  );
}

registerItem() {
  return SizedBox(
    width: 100,
    height: 50,
    child: ElevatedButton(
        onPressed: () {
          Get.to(const Register());
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

AppBar appBar(BuildContext context, GlobalKey<ScaffoldState> key) => AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 75,
      leadingWidth: 100,
      leading: FutureBuilder(
          future: context.read<AuthService>().isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                return !ResponsiveLayout.isSmallScreen(context)
                    ? Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2FLogoUngNY.png?alt=media&token=aaf84632-867b-4a02-a9c6-2efb3be7a417',
                            width: 75,
                          ),
                        ),
                      ])
                    : IconButton(
                        onPressed: () {
                          key.currentState?.openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black,
                        ));
              } else {
                return !ResponsiveLayout.isSmallScreen(context)
                    ? Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2FLogoUngNY.png?alt=media&token=aaf84632-867b-4a02-a9c6-2efb3be7a417',
                            width: 75,
                          ),
                        ),
                      ])
                    : IconButton(
                        onPressed: () {
                          key.currentState?.openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black,
                        ));
              }
            } else {
              return const Login();
            }
          }),
      title: FutureBuilder(
          future: context.read<AuthService>().isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                // Loggin In
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
                            Container(
                              width: MediaQuery.of(context).size.width - 800,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    right: 5, top: 11, bottom: 11),
                                child: nyAnnonse()),
                            Padding(
                                padding: const EdgeInsets.only(
                                    right: 5, top: 11, bottom: 11),
                                child: chatItem()),
                            Padding(
                                padding: const EdgeInsets.only(
                                    right: 5, top: 11, bottom: 11),
                                child: profil()),
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
                                    style:
                                        GoogleFonts.tinos(color: Colors.black))
                              ]),
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
                            Container(
                              width: MediaQuery.of(context).size.width - 750,
                            ),
                            Container(
                              width: 150,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5, top: 11, bottom: 11),
                                  child: logInItem()),
                            ),
                            SizedBox(
                              width: 150,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5, top: 11, bottom: 11),
                                  child: registerItem()),
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
                                    style:
                                        GoogleFonts.tinos(color: Colors.black))
                              ]),
                        ),
                      );
              }
            } else {
              // No connection with Firebase Auth. . .
              return const Login();
            }
          }),
    );

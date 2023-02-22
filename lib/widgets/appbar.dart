import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webdesign/pages/login/login.dart';
import '../utils/responsive.dart';
import '../pages/chat/widgets/chat_page.dart';
import '../pages/newJob/newjob.dart';
import '../pages/profile/profile.dart';
import '../pages/register/register.dart';

Profil() {
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

NyAnnonse() {
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

ChatItem() {
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

LogInItem() {
  return SizedBox(
    width: 100,
    height: 50,
    child: ElevatedButton(
        onPressed: () {
          Get.to(const Login());
        },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            backgroundColor: Colors.blue),
        child: const Text(
          'Logg på',
          style: TextStyle(fontSize: 15),
        )),
  );
}

RegisterItem() {
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
          'Registrer ',
          style: TextStyle(fontSize: 15),
        )),
  );
}

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> isLoggedIn() async {
    final currentUser = await _auth.currentUser;
    return currentUser != null;
  }
}

final Auth _auth = Auth();

AppBar appBar(BuildContext context, GlobalKey<ScaffoldState> key) => AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 75,
      leadingWidth: 100,
      leading: FutureBuilder(
          future: _auth.isLoggedIn(),
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
                        icon: Icon(
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
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                        ));
              }
            } else {
              return Login();
            }
          }),
      title: FutureBuilder(
          future: _auth.isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                return !ResponsiveLayout.isSmallScreen(context)
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text.rich(
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
                            Container(
                              width: MediaQuery.of(context).size.width - 800,
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    right: 5, top: 11, bottom: 11),
                                child: NyAnnonse()),
                            Padding(
                                padding: EdgeInsets.only(
                                    right: 5, top: 11, bottom: 11),
                                child: ChatItem()),
                            Padding(
                                padding: EdgeInsets.only(
                                    right: 5, top: 11, bottom: 11),
                                child: Profil()),
                          ],
                        ),
                      )
                    : Text.rich(
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
                                  style: GoogleFonts.tinos(color: Colors.black))
                            ]),
                      );
              } else {
                return !ResponsiveLayout.isSmallScreen(context)
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text.rich(
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
                            Container(
                              width: MediaQuery.of(context).size.width - 750,
                            ),
                            Container(
                              width: 150,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      right: 5, top: 11, bottom: 11),
                                  child: LogInItem()),
                            ),
                            Container(
                              width: 150,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      right: 5, top: 11, bottom: 11),
                                  child: RegisterItem()),
                            ),
                          ],
                        ),
                      )
                    : Text.rich(
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
                                  style: GoogleFonts.tinos(color: Colors.black))
                            ]),
                      );
              }
            } else {
              return Login();
            }
          }),
    );

// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webdesign/pages/chat/chat.dart';
import 'package:webdesign/pages/chat/widgets/chat_page.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/pages/newJob/newjob.dart';
import 'package:webdesign/pages/profile/profile.dart';
import 'package:webdesign/pages/register/register.dart';
import 'package:webdesign/utils/responsive.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> isLoggedIn() async {
    final currentUser = await _auth.currentUser;
    return currentUser != null;
  }
}

class NavBar extends StatelessWidget {
   NavBar({super.key});

    final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
              future: _auth.isLoggedIn(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return NavBarIn();
                  } else {
                    return NavBarOut();
                  }
                } else {
                  return Login();
                }
              });
  }
}



    Profil(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: SizedBox(
        width: 90,
        height: 35,
        child: TextButton(
            onPressed: () {
              Get.to(const Profile());
            }, child: const Text(
              'Profil ',
              style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

    NyAnnonse(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: SizedBox(
        width: 120,
        height: 35,
        child: TextButton(
            onPressed: () {
              Get.to(const NewJob());
            }, child: const Text(
              'Ny Annonse ',
              style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  ChatItem(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: SizedBox(
        width: 90,
        height: 35,
        child: TextButton(
            onPressed: () {
              Get.to(Chattos());
            }, child: const Text(
              'Chat ',
              style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      )
    );
  }

class NavBarIn extends StatelessWidget {
  const NavBarIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                if(!ResponsiveLayout.isSmallScreen(context))
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.asset("/images/LogoUng.png"),
                  )
                  else
                  SizedBox(
                  height: 80,
                  width: 80,
                  child: InkWell(
                    onTap: () {
                    },
                    child: const Icon(Icons.menu),
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                    Text.rich(TextSpan(style: const TextStyle(fontSize: 40), children: [
                      TextSpan(
                        text: 'UNG',
                        style: GoogleFonts.tinos(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'ANSATT', style: GoogleFonts.tinos())
                    ]
                  ),
                ),
              ],
            ),
            if(!ResponsiveLayout.isSmallScreen(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                NyAnnonse(), ChatItem(), Profil()]
            )
          ],
        ),
      ),
    );
  }
}

LogInItem(){
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
              backgroundColor: const Color.fromRGBO(102, 82, 143, 1.0)),
          child: const Text(
            'Logg på',
            style: TextStyle(fontSize: 15),
          )),
    );
  }

  RegisterItem(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: SizedBox(
        width: 120,
        height: 50,
        child: ElevatedButton(
            onPressed: () {
              Get.to(const Register());
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                backgroundColor: const Color.fromRGBO(102, 82, 143, 1.0)),
            child: const Text(
              'Registerer ',
              style: TextStyle(fontSize: 15),
            )),
      ),
    );
  }

class NavBarOut extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network("https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2FUngLogo.png?alt=media&token=672878c7-db3a-4a1a-950f-e9c3cb4e334c"),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                    Text.rich(TextSpan(style: const TextStyle(fontSize: 40), children: [
                      TextSpan(
                        text: 'UNG',
                        style: GoogleFonts.tinos(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'ANSATT', style: GoogleFonts.tinos())
                    ]
                  )
                )
              ],
            ),
            if(!ResponsiveLayout.isSmallScreen(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                LogInItem(), RegisterItem()]
            )
            else
            InkWell(
              onTap: () {
                
              },
              child: Icon(Icons.menu))
          ],
        ),
      ),
    );
  }
}
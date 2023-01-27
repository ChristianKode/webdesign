// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webdesign/main.dart';
import 'package:webdesign/pages/chat/chat.dart';
import 'package:webdesign/pages/chat/widgets/LargeChat.dart';
import 'package:webdesign/pages/home/widgets/Large_homeLoggedOut.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/pages/newJob/newjob.dart';
import 'package:webdesign/pages/profile/profile.dart';
import 'package:webdesign/pages/profile/widgets/Large_profile.dart';
import 'package:webdesign/pages/register/register.dart';
import 'package:webdesign/utils/responsive.dart';
import 'package:get/get.dart';

    Profil(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: SizedBox(
        width: 90,
        height: 35,
        child: TextButton(
            onPressed: () {
              Get.to(Profile());
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
              Get.to(NewJob());
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
              Get.to(Chat());
            }, child: const Text(
              'Chat ',
              style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      )
    );
  }

class NavBarIn extends StatelessWidget {

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
                  child: Image.asset("/images/LogoUng.png"),
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
                NyAnnonse(), ChatItem(), Profil()]
            )
            else
            Image.asset("images/menu.png", width: 26, height: 26,)
          ],
        ),
      ),
    );
  }
}
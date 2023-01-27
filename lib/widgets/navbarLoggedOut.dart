// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webdesign/main.dart';
import 'package:webdesign/pages/home/widgets/Large_homeLoggedOut.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/pages/register/register.dart';
import 'package:webdesign/utils/responsive.dart';
import 'package:get/get.dart';

    ChatItem(){
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

  JobbItem(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: SizedBox(
        width: 100,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: <Widget>[
              SizedBox(
                height: 80,
                width: 80,
                child: Image.asset("/images/hvitlogo.png"),
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
              ChatItem(), JobbItem()]
          )
          else
          Image.asset("images/menu.png", width: 26, height: 26,)
        ],
      ),
    );
  }
}
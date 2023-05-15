// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/core/service/authentication_services.dart';
import 'package:webdesign/core/utils/responsive/theme.dart';
import 'package:webdesign/pages/home/widgets/main_home.dart';

import '../../forgot/forgot.dart';

class SmallLogin extends StatelessWidget {
  const SmallLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [SmallLoginBox()]);
  }
}

// Same logic as Large-Login
class SmallLoginBox extends StatelessWidget {
  SmallLoginBox({super.key});
  final TextEditingController mail = TextEditingController();
  final TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text.rich(
                TextSpan(style: const TextStyle(fontSize: 60), children: [
              TextSpan(
                  text: 'UNG',
                  style: GoogleFonts.tinos(fontWeight: FontWeight.bold)),
              TextSpan(text: 'ANSATT', style: GoogleFonts.tinos())
            ])),
          ),
          Flexible(
            child: SizedBox(
              width: 450,
              height: 450,
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2FFingerprint-cuate.png?alt=media&token=634ca348-0c73-45b6-96d7-51d7465b92e2',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
            child: SizedBox(
              width: 360,
              child: TextField(
                  controller: mail,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: appColor, width: 2),
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
                      borderSide: BorderSide(color: appColor, width: 2),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    String loginResult = await context
                        .read<AuthService>()
                        .login(mail.text.trim(), pass.text.trim());
                    if (loginResult == 'Innlogget') {
                      Get.to(() => LargeHome());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: const Text('Noe gikk galt...'),
                          duration: const Duration(seconds: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: appColor, width: 2),
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
                    backgroundColor: appColor,
                  ),
                  child: const Text(
                    'Logg på',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(width: 10),
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
          TextButton(
              onPressed: () {
                Get.to(() => const Forgot());
              },
              child: (Text(
                'Glemt passord?',
                style: GoogleFonts.tinos(fontSize: 20),
              ))),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}

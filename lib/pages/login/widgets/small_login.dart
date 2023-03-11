import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/app_logic/services/firebase_auth.dart';
import 'package:webdesign/pages/home/widgets/main_home.dart';

import '../../forgot/forgot.dart';

class SmallLogin extends StatelessWidget {
  const SmallLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://www.pexels.com/photo/milky-way-illustration-1169754/'),
                fit: BoxFit.cover),
          ),
          child: Row(children: [SmallLoginBox()])),
    );
  }
}

class SmallLoginBox extends StatelessWidget {
  SmallLoginBox({super.key});
  final TextEditingController mail = TextEditingController();
  final TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 150,
          ),
          Text.rich(TextSpan(style: const TextStyle(fontSize: 60), children: [
            TextSpan(
                text: 'UNG',
                style: GoogleFonts.tinos(fontWeight: FontWeight.bold)),
            TextSpan(text: 'ANSATT', style: GoogleFonts.tinos())
          ])),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
            child: SizedBox(
              width: 360,
              child: TextField(
                  controller: mail,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
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
                      borderSide: BorderSide(color: Colors.blue, width: 2),
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
          SizedBox(
            width: 150,
            height: 40,
            child: ElevatedButton(
              onPressed: () async {
                String loginResult = await context
                    .read<AuthService>()
                    .login(mail.text.trim(), pass.text.trim());
                if (loginResult == 'innlogget') {
                  Get.to(() => LargeHome());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('Noe gikk galt...'),
                      duration: const Duration(seconds: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.blue, width: 2),
                      ),
                      action: SnackBarAction(
                        label: 'Lukk',
                        textColor: Colors.white, // set text color
                        onPressed:
                            ScaffoldMessenger.of(context).hideCurrentSnackBar,
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Logg på',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Get.to(() => const Forgot());
              },
              child: (Text(
                'Glemt passord?',
                style: GoogleFonts.tinos(fontSize: 20),
              ))),
        ],
      ),
    );
  }
}

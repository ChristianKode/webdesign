import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/core/service/authentication_services.dart';

import '../../../core/utils/widgets/appbar.dart';
import '../../../core/utils/widgets/drawer.dart';
import '../../login/login.dart';

// Forgot password page
// Firebase handles email for password recovery
class LargeForgot extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  LargeForgot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context, scaffoldKey),
      drawer: const Drawer(
        child: SideDrawer(),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fforgot_background.jpg?alt=media&token=711bea7e-5724-4412-9712-169dca4b5bfa'),
                fit: BoxFit.cover)),
        child: ForgotPassBox(),
      ),
    );
  }
}

class ForgotPassBox extends StatelessWidget {
  ForgotPassBox({
    super.key,
  });

  final TextEditingController mailCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          Text(
            'Tilbakestill Passord',
            style: GoogleFonts.tinos(
              fontSize: 50,
              color: const Color.fromRGBO(102, 82, 143, 1.0),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
            child: SizedBox(
              width: 360,
              child: TextField(
                controller: mailCon,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(102, 82, 143, 1.0), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    hintText: 'Epost'),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 160,
            height: 40,
            child: ElevatedButton(
                onPressed: () {
                  // Logic located backend
                  final String mail = mailCon.text;

                  context.read<AuthService>().forgotPass(mail);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    backgroundColor: const Color.fromRGBO(102, 82, 143, 1.0)),
                child: const Text(
                  'Send Epost',
                  style: TextStyle(fontSize: 15),
                )),
          ),
          TextButton(
              onPressed: () {
                Get.to(const Login());
              },
              child: Text.rich(
                  TextSpan(style: const TextStyle(fontSize: 15), children: [
                TextSpan(text: 'Ferdig? ', style: GoogleFonts.tinos()),
                TextSpan(
                    text: 'Logg på',
                    style: GoogleFonts.tinos(fontWeight: FontWeight.bold))
              ]))),
        ],
      ),
    );
  }
}

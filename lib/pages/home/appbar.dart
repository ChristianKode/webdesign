import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/widgets/navbar.dart';

import '../../utils/responsive.dart';

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
    leading: FutureBuilder(
        future: _auth.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return !ResponsiveLayout.isSmallScreen(context)
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 20,
                          child: Image.network('https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2FLogoUng.png?alt=media&token=2106cc32-fff9-4b25-aa6f-083164444e68',
                          fit: BoxFit.cover,),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    )
                  : IconButton(
                      onPressed: () {
                        key.currentState?.openDrawer();
                      },
                      icon: Icon(Icons.menu));
            } else {
              return !ResponsiveLayout.isSmallScreen(context)
                  ? Row(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.asset("/images/LogoUng.png"),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text.rich(
                          TextSpan(
                              style: const TextStyle(fontSize: 40),
                              children: [
                                TextSpan(
                                    text: 'UNG',
                                    style: GoogleFonts.tinos(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: 'ANSATT', style: GoogleFonts.tinos())
                              ]),
                        ),
                      ],
                    )
                  : IconButton(
                      onPressed: () {
                        key.currentState?.openDrawer();
                      },
                      icon: Icon(Icons.menu));
            }
          } else {
            return Login();
          }
        }));

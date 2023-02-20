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
      backgroundColor: Colors.green,
      toolbarHeight: 75,
      leadingWidth: 100,
      leading: FutureBuilder(
          future: _auth.isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                return !ResponsiveLayout.isSmallScreen(context)
                    ? Row(
                        children: [],
                      )
                    : IconButton(
                        onPressed: () {
                          key.currentState?.openDrawer();
                        },
                        icon: Icon(
                          Icons.menu_book,
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
                      ])
                    : IconButton(
                        onPressed: () {
                          key.currentState?.openDrawer();
                        },
                        icon: Icon(
                          Icons.menu_open,
                        ));
              }
            } else {
              return Login();
            }
          }),
    );

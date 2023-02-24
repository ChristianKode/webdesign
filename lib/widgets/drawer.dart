import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/app_logic/services/firebase_auth.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/pages/register/register.dart';
import 'package:webdesign/utils/responsive.dart';
import 'package:webdesign/widgets/appbar.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<AuthService>().isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {

              // Logged in
              return LoggedInDrawer();
            } else {

              // Logged out
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [LoggedOutDrawer()],
              );
            }
          } else {
            return Text('3');
          }
        });
  }
}

class LoggedInDrawer extends StatefulWidget {
  const LoggedInDrawer({super.key});

  @override
  State<LoggedInDrawer> createState() => _LoggedInDrawerState();
}

class _LoggedInDrawerState extends State<LoggedInDrawer> {
  bool onHover0 = false;
  bool onHover1 = false;
  bool onHover2 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            color: Colors.blue,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2
                      )
                    ),
                    child: ClipOval(
                      
                      child: Icon(Icons.person_rounded, size: 100,),
                      
                      
                
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      
    );
  }
}

class LoggedOutDrawer extends StatefulWidget {
  const LoggedOutDrawer({super.key});

  @override
  State<LoggedOutDrawer> createState() => _LoggedOutDrawerState();
}

class _LoggedOutDrawerState extends State<LoggedOutDrawer> {
  bool onHover0 = false;
  bool onHover1 = false;
  bool onHover2 = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              height: 45,
              width: 120,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const Register());
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7))),
                child: Text('Bli med', style: GoogleFonts.tinos(fontSize: 22)),
              ),
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onHover: (value) {
              setState(() {
                onHover0 = value;
              });
            },
            onTap: () {
              Get.to(() => Login());
            },
            child: Text(
              "Logg på",
              style: GoogleFonts.tinos(
                color: !onHover0 ? Color.fromARGB(204, 0, 0, 0) : Colors.blue,
                fontSize: 17,
              ),
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onHover: (value) {
              setState(() {
                onHover1 = value;
              });
            },
            onTap: () {
              Get.to(() => Login());
            },
            child: Text(
              "Annonser",
              style: GoogleFonts.tinos(
                color: !onHover1 ? Color.fromARGB(204, 0, 0, 0) : Colors.blue,
                fontSize: 17,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 14),
            child: Container(
              color: Colors.black,
              width: 250,
              height: 1,
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onHover: (value) {
              setState(() {
                onHover2 = value;
              });
            },
            onTap: () {
              Get.to(() => Login());
            },
            child: Text(
              "Hjem",
              style: GoogleFonts.tinos(
                color: !onHover2 ? Color.fromARGB(204, 0, 0, 0) : Colors.blue,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

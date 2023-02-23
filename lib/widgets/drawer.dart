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
                return Text('1');
              } else {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoggedOutDrawer()
                      
                    ],
                  ),
                );
              }
            } else {
              return Text('3');
            }
          });
    
  }
}

class LoggedInDrawer extends StatelessWidget {
  const LoggedInDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
                onPressed: (){
                Get.to(() => Register());
              }, 
              child: Text('Bli med', style: GoogleFonts.tinos(fontSize: 22)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
                )
              ),),
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
            child: Text("Logg på", style: GoogleFonts.tinos(
              color: !onHover0 ? Color.fromARGB(204, 0, 0, 0): Colors.blue,
              fontSize: 17,
             
              ),),
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
            child: Text("Annonser", style: GoogleFonts.tinos(
              color: !onHover1 ? Color.fromARGB(204, 0, 0, 0): Colors.blue,
              fontSize: 17,
             
              ),),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 18),
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


            child: Text("Hjem", style: GoogleFonts.tinos(
              color: !onHover2 ? Color.fromARGB(204, 0, 0, 0): Colors.blue,
              fontSize: 17,
             
              ),),
          ),
          
        ],
      ),
    );
  }
}
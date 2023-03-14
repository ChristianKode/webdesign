// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/app_logic/services/firebase_auth.dart';
import 'package:webdesign/pages/chat/widgets/large_chat.dart';
import 'package:webdesign/pages/home/widgets/main_home.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/pages/newJob/newjob.dart';
import 'package:webdesign/pages/profile/profile_view.dart';
import 'package:webdesign/pages/register/register.dart';

import '../main.dart';

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
              return const LoggedInDrawer();
            } else {
              // Logged out
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_constructors
                children: const [LoggedOutDrawer()],
              );
            }
          } else {
            return const Text('3');
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
  String userName = '';
  String userMail = '';
  bool onHover0 = false;
  bool onHover1 = false;
  bool onHover2 = false;
  bool onHover3 = false;
  bool onHover4 = false;
  bool onHover5 = false;

  Future<void> getName() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('Users').doc(uid);
    final dataSnapshot = await userRef.get();

    if (dataSnapshot.exists) {
      final userData = dataSnapshot.data() as Map<dynamic, dynamic>;

      setState(() {
        userName = userData['firstname'] + ' ' + userData['lastname'];
        userMail = FirebaseAuth.instance.currentUser!.email!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

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
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.white, width: 2)),
                  child: ClipOval(
                      child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fprofile-circle-icon-512x512-dt9lf8um.png?alt=media&token=6b6eec31-abc3-43ad-ba01-69b374731ba9')),
                ),
              ),
              SelectableText(
                userName,
                style: const TextStyle(fontSize: 22, color: Colors.white),
              ),
              SelectableText(
                userMail,
                style:
                    const TextStyle(color: Color.fromARGB(216, 255, 255, 255)),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 15),
          child: SizedBox(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  hoverColor: Colors.transparent,
                  onHover: (value) => {
                    setState(() {
                      onHover0 = value;
                    })
                  },
                  onTap: () {
                    router.navigateTo(context, '/main_home',
                        transition: TransitionType.fadeIn);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.home_outlined),
                      ),
                      Text(
                        'Hjem',
                        style: TextStyle(
                            color: !onHover0 ? Colors.black : Colors.blue),
                      )
                    ],
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onHover: (value) => {
                    setState(() {
                      onHover1 = value;
                    })
                  },
                  onTap: () {
                    router.navigateTo(context, '/NewJob',
                        transition: TransitionType.fadeIn);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.add_business_outlined),
                      ),
                      Text(
                        'Ny annonse',
                        style: TextStyle(
                            color: !onHover1 ? Colors.black : Colors.blue),
                      )
                    ],
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onHover: (value) => {
                    setState(() {
                      onHover2 = value;
                    })
                  },
                  onTap: () {
                    router.navigateTo(context, '/Chat',
                        transition: TransitionType.fadeIn);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.chat_outlined),
                      ),
                      Text(
                        'Meldinger',
                        style: TextStyle(
                            color: !onHover2 ? Colors.black : Colors.blue),
                      )
                    ],
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onHover: (value) => {
                    setState(() {
                      onHover3 = value;
                    })
                  },
                  onTap: () {
                    router.navigateTo(context, '/Profile',
                        transition: TransitionType.fadeIn);
                  },
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.favorite_border_outlined),
                      ),
                      Text(
                        'Favoritter',
                        style: TextStyle(
                            color: !onHover3 ? Colors.black : Colors.blue),
                      )
                    ],
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onHover: (value) => {
                    setState(() {
                      onHover4 = value;
                    })
                  },
                  onTap: () {
                    router.navigateTo(context, '/Profile',
                        transition: TransitionType.fadeIn);
                  },
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.settings_outlined),
                      ),
                      Text(
                        'Innstillinger',
                        style: TextStyle(
                            color: !onHover4 ? Colors.black : Colors.blue),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 250,
                    height: 0.8,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onHover: (value) => {
                    setState(() {
                      onHover5 = value;
                    })
                  },
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    router.navigateTo(context, '/main_home',
                        transition: TransitionType.fadeIn);
                  },
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.logout_outlined),
                      ),
                      Text(
                        'Logg ut',
                        style: TextStyle(
                            color: !onHover5 ? Colors.black : Colors.blue),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
            child: SizedBox(
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text(
              "Logg på",
              style: GoogleFonts.tinos(
                color: !onHover0
                    ? const Color.fromARGB(204, 0, 0, 0)
                    : Colors.blue,
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text(
              "Annonser",
              style: GoogleFonts.tinos(
                color: !onHover1
                    ? const Color.fromARGB(204, 0, 0, 0)
                    : Colors.blue,
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
              Get.to(() => LargeHome());
            },
            child: Text(
              "Hjem",
              style: GoogleFonts.tinos(
                color: !onHover2
                    ? const Color.fromARGB(204, 0, 0, 0)
                    : Colors.blue,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/app_logic/services/firebase_auth.dart';
import 'package:webdesign/pages/chat/widgets/chat_page.dart';
import 'package:webdesign/pages/home/widgets/main_home.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/pages/newJob/newjob.dart';
import 'package:webdesign/pages/register/register.dart';

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
    final userRef = FirebaseDatabase.instance.ref().child('users').child(uid);
    final dataSnapshot = await userRef.get();
    final userData = dataSnapshot.value as Map<dynamic, dynamic>;

    setState(() {
      userName = userData['fornavn'] + ' ' + userData['etternavn'];
      userMail = FirebaseAuth.instance.currentUser!.email!;
    });
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
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2)),
                  child: const ClipOval(
                    child: Icon(
                      Icons.person_rounded,
                      size: 100,
                    ),
                  ),
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
          child: Container(
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
                  onTap: () {},
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
                    Get.to(() => const NewJob());
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
                    Get.to(() => const Chattos());
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
                    // Soon Favoritter
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
                  onTap: () {},
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LargeHome()));
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
              Get.to(() => const Login());
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
              Get.to(() => const Login());
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
              Get.to(() => const Login());
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

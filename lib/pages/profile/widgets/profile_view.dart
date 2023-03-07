import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:webdesign/pages/profile/widgets/Large_profile.dart';
import 'package:webdesign/utils/responsive.dart';
import 'package:webdesign/widgets/appbar.dart';
import 'package:webdesign/widgets/drawer.dart';

final String currentUid = FirebaseAuth.instance.currentUser!.uid;
final userRef =
    FirebaseDatabase.instance.ref().child('users').child(currentUid);
String name = firstName + lastName;
String firstName = "";
String lastName = "";
bool onHover0 = false;
bool onHover1 = false;
bool onHover2 = false;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context, scaffoldKey),
      drawer: const Drawer(
        child: SideDrawer(),
      ),
      body: SingleChildScrollView(
        child: !ResponsiveLayout.isSmallScreen(context)
            ? const LargeProfile()
            : const SmallProfile(),
      ),
    );
  }
}

class LargeProfile extends StatefulWidget {
  const LargeProfile({super.key});

  @override
  State<LargeProfile> createState() => _LargeProfileState();
}

class _LargeProfileState extends State<LargeProfile> {
  bool onHover0 = false;
  bool onHover1 = false;
  bool onHover2 = false;

  Future<void> getname() async {
    final dataSnapshot = await userRef.get();
    final userData = dataSnapshot.value as Map<dynamic, dynamic>;

    setState(() {
      final firstName = userData['fornavn'];
      final lastName = userData['etternavn'];
      fornavn = firstName;
      etternavn = lastName;
    });
  }

  @override
  void initState() {
    super.initState();
    getname();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Page Header

        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Center(
            child: SizedBox(
              height: 300,
              width: 1000,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, top: 25, right: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Min Side'),
                          ElevatedButton(
                              onPressed: () {}, child: const Text("Logg ut"))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ClipOval(
                              child: Image.network(
                                  'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fprofile-circle-icon-512x512-dt9lf8um.png?alt=media&token=6b6eec31-abc3-43ad-ba01-69b374731ba9')),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$fornavn $etternavn',
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                FirebaseAuth.instance.currentUser!.email
                                    .toString(),
                                style: const TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Body
        Container(
          constraints: BoxConstraints(minHeight: 280),
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(7, 0, 0, 0),
          child: Container(
            width: 1000,
            height: 1000,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 320,
                  height: 250,
                  color: Colors.white,
                  child: Column(
                    children: [Text('Endre profil')],
                  ),
                ),
                Container(
                  width: 320,
                  height: 250,
                  color: Colors.white,
                  child: Column(
                    children: [Text('Favoritter')],
                  ),
                ),
                Container(
                  width: 320,
                  height: 250,
                  color: Colors.white,
                  child: Column(
                    children: [Text('Mine annonser')],
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

class SmallProfile extends StatefulWidget {
  const SmallProfile({super.key});

  @override
  State<SmallProfile> createState() => _SmallProfileState();
}

class _SmallProfileState extends State<SmallProfile> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

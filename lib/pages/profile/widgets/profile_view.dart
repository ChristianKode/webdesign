import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
  ProfileView({super.key});

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
      drawer: Drawer(
        child: SideDrawer(),
      ),
      body: SingleChildScrollView(
        child: !ResponsiveLayout.isSmallScreen(context)
            ? LargeProfile()
            : SmallProfile(),
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
      final FirstName = userData['fornavn'];
      final LastName = userData['etternavn'];
      final tlf = userData['telefon'];
      firstName = FirstName;
      lastName = LastName;
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

        Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Center(
            child: Container(
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
                          Text('Min Side'),
                          Container(
                            child: ElevatedButton(
                                onPressed: () {}, child: Text("Logg ut")),
                          )
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
                                firstName + ' ' + lastName,
                                style: TextStyle(
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
          child: SizedBox(
            width: 1000,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraingts) {
                if (constraingts.maxWidth > 900) {
                  // Wide Screen
                  return Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // First box
                        Flexible(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onHover: (value) => {
                              setState(() {
                                onHover0 = value;
                              })
                            },
                            onTap: () {},
                            child: Flexible(
                                child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(19, 0, 0, 0),
                                    blurRadius: 4,
                                    offset: Offset(4, 8), // Shadow position
                                  ),
                                ],
                              ),
                              width: 300,
                              height: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.person_2_outlined,
                                              size: 50,
                                              color: Colors.blue,
                                            ),
                                            Text(
                                              'Endre profil',
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Text(
                                          'Se profilen din detaljert og endre dine opplysninger',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color:
                                        !onHover0 ? Colors.black : Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                            )),
                          ),
                        ),

                        // Spacing
                        const SizedBox(
                          width: 40,
                        ),

                        // Second box
                        Flexible(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onHover: (value) => {
                              setState(() {
                                onHover1 = value;
                              })
                            },
                            onTap: () {},
                            child: Flexible(
                                child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(19, 0, 0, 0),
                                    blurRadius: 4,
                                    offset: Offset(4, 8), // Shadow position
                                  ),
                                ],
                              ),
                              width: 300,
                              height: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.favorite_border_outlined,
                                              size: 50,
                                              color: Colors.blue,
                                            ),
                                            Text(
                                              'Favoritter',
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Text(
                                          'Se dine personlige favoritter som har blitt lagret',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color:
                                        !onHover1 ? Colors.black : Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                            )),
                          ),
                        ),

                        // Spacing
                        const SizedBox(
                          width: 40,
                        ),

                        // Third box
                        Flexible(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onHover: (value) => {
                              setState(() {
                                onHover2 = value;
                              })
                            },
                            onTap: () {},
                            child: Flexible(
                                child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(19, 0, 0, 0),
                                    blurRadius: 4,
                                    offset: Offset(4, 8), // Shadow position
                                  ),
                                ],
                              ),
                              width: 300,
                              height: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.add_business_outlined,
                                              size: 50,
                                              color: Colors.blue,
                                            ),
                                            Text(
                                              'Mine Annonser',
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Text(
                                          'Se og hold oversikt over annonsene dine',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color:
                                        !onHover0 ? Colors.black : Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Small Screen
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(19, 0, 0, 0),
                                blurRadius: 4,
                                offset: Offset(4, 8), // Shadow position
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(19, 0, 0, 0),
                                blurRadius: 4,
                                offset: Offset(4, 8), // Shadow position
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(19, 0, 0, 0),
                                blurRadius: 4,
                                offset: Offset(4, 8), // Shadow position
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  );
                }
              },
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

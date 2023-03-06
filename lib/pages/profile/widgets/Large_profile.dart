// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:webdesign/utils/responsive.dart';
import 'package:webdesign/widgets/appbar.dart';


TextEditingController nameController = TextEditingController();
final userRef = FirebaseDatabase.instance.ref().child('users').child(uid);
String ttele = "";
String fornavn= "";
final String uid = FirebaseAuth.instance.currentUser!.uid;
final databaseRef = FirebaseDatabase.instance.ref().child(uid);
final TextEditingController navn = TextEditingController();
final TextEditingController etterNavn = TextEditingController();
bool isEditEnabled = false;

class LargeProfile extends StatelessWidget {
  const LargeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context, scaffoldKey),
      drawer: const Drawer(),
      body: const Padding(
        padding: EdgeInsets.only(top: 50),
        child: ProfileContent(),
      ),
    );
  }
}

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Future<void> getname() async {

    final dataSnapshot = await userRef.get();
    final userData = dataSnapshot.value as Map<dynamic, dynamic>;

    setState(() {
      final firstName = userData['fornavn'];
      final tlf = userData['telefon'];
      fornavn = firstName;
      ttele = tlf;
    });
  }

  @override
  void initState() {
    super.initState();
    getname();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  nameCard() {
    if (isEditEnabled == true) {
      // Editable version of the card
      return Stack(
        children: [
          Container(
            height: 100,
            width: 225,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: SizedBox(
              width: 100,
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter name here',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Color.fromRGBO(102, 82, 143, 1.0)),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: () async {
                if (nameController.text != "") {
                  setState(() {
                    isEditEnabled = false;
                    fornavn = nameController.text; // Add this line to update the name variable
                  });

                  Map<String, dynamic> updateData = {'fornavn': fornavn};

                  await userRef.update(updateData);
                }
              },
              icon: const Icon(Icons.save),
            ),
          ),
        ],
      );
    } else {
      // Non-editable version of the card
      return Stack(
        children: [
          Container(
            height: 100,
            width: 225,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: SelectableText(
                fornavn,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Color.fromRGBO(102, 82, 143, 1.0)),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isEditEnabled = true;
                });
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return !ResponsiveLayout.isSmallScreen(context)
        ? Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                height: 800,
                constraints: const BoxConstraints(minWidth: 1000),
                width: MediaQuery.of(context).size.width * 0.55,
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(
                          text: 'Profil',
                        ),
                        Tab(
                          text: 'Favoritter',
                        ),
                        Tab(
                          text: 'Mine Annonser',
                        )
                      ],
                      unselectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(102, 82, 143, 1.0)),
                      labelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                      labelColor: const Color.fromRGBO(102, 82, 143, 1.0),
                      indicatorColor: const Color.fromRGBO(102, 82, 143, 1.0),
                      indicatorWeight: 5,
                    ),
                    Expanded(
                        child: TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            height: 1200,
                            width: 1400,
                            color: Colors.blue,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: nameCard()),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 800,
                          width: 1400,
                          color: Colors.yellow,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                width: 350,
                                color: Colors.green,
                                child: Text(ttele),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 800,
                          width: 1400,
                          color: Colors.green,
                          child: const Text("Mine Annonser"),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          )
        : Center(
            child: SizedBox(
            height: 800,
            width: MediaQuery.of(context).size.width * 0.90,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      text: 'Profil',
                    ),
                    Tab(
                      text: 'Favoritter',
                    ),
                    Tab(
                      text: 'Mine Annonser',
                    )
                  ],
                  unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(102, 82, 143, 1.0)),
                  labelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                  labelColor: const Color.fromRGBO(102, 82, 143, 1.0),
                  indicatorColor: const Color.fromRGBO(102, 82, 143, 1.0),
                  indicatorWeight: 5,
                ),
                Expanded(
                    child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      height: 800,
                      width: 1400,
                      color: Colors.blue,
                      child: const Text("Profil"),
                    ),
                    Container(
                      height: 800,
                      width: 1400,
                      color: Colors.yellow,
                      child: const Text("Favoritter"),
                    ),
                    Container(
                      height: 800,
                      width: 1400,
                      color: Colors.green,
                      child: const Text("Mine Annonser"),
                    ),
                  ],
                ))
              ],
            ),
          ));
  }
}

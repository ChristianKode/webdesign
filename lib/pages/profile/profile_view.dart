import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webdesign/pages/profile/widgets/profile_components.dart';
import 'package:webdesign/core/utils/responsive/responsive.dart';
import 'package:webdesign/core/utils/widgets/appbar.dart';
import 'package:webdesign/core/utils/widgets/drawer.dart';
import 'package:webdesign/core/utils/widgets/footer_overall.dart';

final String? currentUid = FirebaseAuth.instance.currentUser?.uid;
final userRef = FirebaseFirestore.instance.collection('Users').doc(currentUid);
String userName = '';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  Future<void> getName() async {
    final dataSnapshot = await userRef.get();

    if (dataSnapshot.exists) {
      final userData = dataSnapshot.data() as Map<dynamic, dynamic>;

      setState(() {
        userName = userData['firstname'] + ' ' + userData['lastname'];
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar(context, scaffoldKey),
        drawer: const Drawer(
          child: SideDrawer(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              headerInfo(userName, context),
              Container(
                color: const Color.fromARGB(6, 0, 0, 0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    !ResponsiveLayout.isSmallScreen(context)
                        ? const LargeProfile()
                        : const SmallProfile(),
                  ],
                ),
              ),
              const Footer()
            ],
          ),
        ),
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
  @override
  Widget build(BuildContext context) {
    double height = 250;
    double width = 320;
    return
        // Body
        SizedBox(
      width: 1000,
      height: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            width: 10,
          ),
          minSide(width, height),
          const SizedBox(
            width: 15,
          ),
          favoritter(width, height),
          const SizedBox(
            width: 15,
          ),
          mineAnnonser(width, height),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
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
    double height = 200;
    double width = MediaQuery.of(context).size.width - 40;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          minSide(width, height),
          const SizedBox(
            height: 20,
          ),
          favoritter(width, height),
          const SizedBox(
            height: 20,
          ),
          mineAnnonser(width, height),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

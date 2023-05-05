import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webdesign/core/service/cloud_firestore_services.dart';
import 'package:webdesign/pages/profile/widgets/profile_components.dart';
import 'package:webdesign/core/utils/responsive/responsive.dart';
import 'package:webdesign/core/utils/widgets/appbar.dart';
import 'package:webdesign/core/utils/widgets/drawer.dart';
import 'package:webdesign/core/utils/widgets/footer_overall.dart';

// Sets the user's id from Firebase.
final String? currentUid = FirebaseAuth.instance.currentUser?.uid;

// Sets the user's reference from the database, called collection in Firebase
final userRef = FirebaseFirestore.instance.collection('Users').doc(currentUid);

// Creates userName variable, will be useful later.
String userName = '';

// Root widget for this page.
// It needs to be Stateful, meaning it can redraw it self under running.
// Will be later explained why.
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      // Creates a visual scaffold for Material Design widgets.
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar(context, scaffoldKey),
        drawer: const Drawer(
          child: SideDrawer(),
        ),
        // Futurebuilder is needed to get the Username from the database. 
        // A Futurebuilder creates a widget based on the latest snapshot from a "Future".
        body: FutureBuilder(
          // This returns the username from the currentUid it gets.
            future: CloudFirestoreServices().getUserName(currentUid!),
            builder: (_, snapshot) {
              // Passes the snapshotdata to the userName variable.
              userName = snapshot.data!;
              // SingleChildScrollView make the widget scrollable.
              return SingleChildScrollView(
                // Vertical Column for components like Header Widget, Main Body Widgets and the Footer Widget.
                child: Column(
                  children: [
                    // Header from the widgets folder
                    // Context describes the part of the user interface represented by this widget.
                    headerInfo(userName, context),
                    Container(
                      color: const Color.fromARGB(6, 0, 0, 0),
                      // Width of the current window size.
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Adds responsiveness.
                          !ResponsiveLayout.isSmallScreen(context)
                              ? const LargeProfile()
                              : const SmallProfile(),
                        ],
                      ),
                    ),
                    const Footer()
                  ],
                ),
              );
            }),
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
    // Sets the size for the menu items.
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
          // Widgets - Profile settings menu.
          // Height and Width are required fields for these widgets
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
    // Body
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          // Widgets - Profile settings menu
          // Height and Width are required fields for these widgets
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

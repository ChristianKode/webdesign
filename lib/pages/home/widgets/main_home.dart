import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:webdesign/core/utils/widgets/appbar.dart';
import 'package:webdesign/pages/home/widgets/home_card.dart';
import 'package:webdesign/pages/home/widgets/home_owners.dart';
import 'package:webdesign/pages/home/widgets/home_top.dart';
import 'package:webdesign/pages/home/widgets/home_job_list.dart';
import 'package:webdesign/core/utils/widgets/drawer.dart';
import 'package:webdesign/core/utils/widgets/footer_overall.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> isLoggedIn() async {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }
}

class LargeHome extends StatelessWidget {
  LargeHome({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

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
        body: const SingleChildScrollView(
          child: Column(children: <Widget>[
            Top(),
            HomeCard(),
            JobList(),
            HomeOwners(),
            Footer()
          ]),
        ),
      ),
    );
  }
}

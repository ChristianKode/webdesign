import 'package:flutter/material.dart';
import 'package:webdesign/pages/newJob/widgets/large_newjob.dart';
import 'package:webdesign/widgets/appbar.dart';
import 'package:webdesign/widgets/drawer.dart';

class SmallNewJob extends StatelessWidget {
  SmallNewJob({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context, scaffoldKey),
      drawer: const Drawer(
        child: SideDrawer(),
      ),
      body: FillOut(),
    );
  }
}

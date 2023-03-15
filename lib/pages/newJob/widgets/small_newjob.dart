import 'package:flutter/material.dart';
import 'package:webdesign/pages/newJob/widgets/large_newjob.dart';
import 'package:webdesign/core/utils/widgets/appbar.dart';
import 'package:webdesign/core/utils/widgets/drawer.dart';

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
      body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fnewjob_background.jpg?alt=media&token=3c5212e1-dcbf-4a61-a6c8-bb13c9b9bb9e'),
                  fit: BoxFit.cover)),
          child: const FillOut()),
    );
  }
}

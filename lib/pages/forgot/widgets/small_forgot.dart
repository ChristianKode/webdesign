import 'package:flutter/material.dart';
import 'package:webdesign/pages/forgot/widgets/large_forgot.dart';

import '../../../core/utils/widgets/appbar.dart';
import '../../../core/utils/widgets/drawer.dart';

class SmallForgot extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SmallForgot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context, scaffoldKey),
      drawer: const Drawer(
        child: SideDrawer(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fforgot_background.png?alt=media&token=5503a57d-7467-4bea-9b0e-3fd4f0b2e743'),
              fit: BoxFit.cover),
        ),
        child: ForgotPassBox(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webdesign/pages/login/widgets/large_login.dart';
import 'package:webdesign/pages/login/widgets/small_login.dart';
import 'package:webdesign/utils/responsivebody.dart';
import 'package:webdesign/widgets/appbar.dart';
import 'package:webdesign/widgets/drawer.dart';

class Login extends StatelessWidget {
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        largeScreen: LargeLogin(),
        mediumScreen: LargeLogin(),
        smallScreen: SmallLogin(),
      ),
    );
  }
}

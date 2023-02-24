import 'package:flutter/material.dart';
import 'package:webdesign/pages/login/widgets/large_login.dart';
import 'package:webdesign/pages/login/widgets/small_login.dart';
import 'package:webdesign/utils/responsivebody.dart';



class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
        largeScreen: LargeLogin(),
        mediumScreen: LargeLogin(),
        smallScreen: SmallLogin());
  }
}

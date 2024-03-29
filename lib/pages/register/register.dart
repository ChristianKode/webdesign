import 'package:flutter/material.dart';
import 'package:webdesign/pages/register/widgets/large_register.dart';
import 'package:webdesign/pages/register/widgets/small_register.dart';
import 'package:webdesign/core/utils/responsive/responsivebody.dart';


// The ResponsiveWidget checks which widget to display, depends on screen size.
class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
        largeScreen: LargeRegister(),
        mediumScreen: LargeRegister(),
        smallScreen: SmallRegister());
  }
}

import 'package:flutter/material.dart';
import 'package:webdesign/pages/forgot/widgets/large_forgot.dart';
import 'package:webdesign/pages/forgot/widgets/small_forgot.dart';

import '../../utils/responsivebody.dart';

class Forgot extends StatelessWidget {
  const Forgot({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      largeScreen: LargeForgot(), 
    mediumScreen: LargeForgot(), 
    smallScreen: SmallForgot());
  }
}
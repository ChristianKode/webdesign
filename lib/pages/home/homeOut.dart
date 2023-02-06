import 'package:flutter/material.dart';
import 'package:webdesign/pages/home/widgets69/Large_homeLoggedOut.dart';
import 'package:webdesign/pages/home/widgets69/Small_homeLoggedOut.dart';
import 'package:webdesign/utils/responsivebody.dart';

class HomeOut extends StatelessWidget {
  const HomeOut({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: LargeHomeOut(),
        mediumScreen: LargeHomeOut(),
        smallScreen: const SmallHomeOut());
  }
}

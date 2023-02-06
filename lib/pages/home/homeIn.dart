import 'package:flutter/material.dart';
import 'package:webdesign/pages/home/widgets/large_home.dart';
import 'package:webdesign/pages/home/widgets69/Large_homeULoggetInn.dart';
import 'package:webdesign/pages/home/widgets69/Small_homeLoggedIn.dart';
import 'package:webdesign/utils/responsivebody.dart';

class HomeIn extends StatelessWidget {
  const HomeIn({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: LargeHome(),
        mediumScreen: LargeHome(),
        smallScreen: const SmallHomeIn());
  }
}

import 'package:flutter/material.dart';
import 'package:webdesign/pages/chat/widgets/LargeChat.dart';
import 'package:webdesign/pages/chat/widgets/SmallChat.dart';
import 'package:webdesign/pages/home/widgets/Large_homeLoggedOut.dart';
import 'package:webdesign/pages/home/widgets/Large_homeULoggetInn.dart';
import 'package:webdesign/pages/home/widgets/Small_homeLoggedOut.dart';
import 'package:webdesign/pages/login/widgets/large_login.dart';
import 'package:webdesign/utils/responsivebody.dart';


class HomeOut extends StatelessWidget {
  const HomeOut({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: LargeHomeOut(),
        mediumScreen: LargeHomeOut(),
        smallScreen: SmallHomeOut());
  }
}

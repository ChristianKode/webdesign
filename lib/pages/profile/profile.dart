import 'package:flutter/material.dart';
import 'package:webdesign/pages/chat/widgets/LargeChat.dart';
import 'package:webdesign/pages/chat/widgets/SmallChat.dart';
import 'package:webdesign/pages/login/widgets/large_login.dart';
import 'package:webdesign/pages/profile/widgets/Large_profile.dart';
import 'package:webdesign/utils/responsivebody.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: LargeProfile(),
        mediumScreen: LargeProfile(),
        smallScreen: SmallChat());
  }
}

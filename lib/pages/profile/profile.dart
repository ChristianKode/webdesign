import 'package:flutter/material.dart';
import 'package:webdesign/pages/profile/widgets/profile_view.dart';
import 'package:webdesign/utils/responsivebody.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
        largeScreen: ProfileView(),
        mediumScreen: ProfileView(),
        smallScreen: ProfileView());
  }
}

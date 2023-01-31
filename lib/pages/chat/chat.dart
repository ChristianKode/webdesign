import 'package:flutter/material.dart';
import 'package:webdesign/pages/chat/widgets/LargeChat.dart';
import 'package:webdesign/pages/chat/widgets/SmallChat.dart';
import 'package:webdesign/utils/responsivebody.dart';


class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
        largeScreen: LargeChat(),
        mediumScreen: LargeChat(),
        smallScreen: SmallChat());
  }
}

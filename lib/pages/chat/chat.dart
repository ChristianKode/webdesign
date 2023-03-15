import 'package:flutter/material.dart';
import 'package:webdesign/pages/chat/smallChat.dart';
import 'package:webdesign/core/utils/responsive/responsivebody.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
        largeScreen: Chat(), mediumScreen: Chat(), smallScreen: SmallChat());
  }
}

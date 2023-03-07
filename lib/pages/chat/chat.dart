import 'package:flutter/material.dart';
import 'package:webdesign/pages/chat/widgets/large_chat.dart';
import 'package:webdesign/pages/chat/widgets/small_chat.dart';
import 'package:webdesign/utils/responsivebody.dart';


class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: ChatUI(),
        mediumScreen: ChatUI(),
        smallScreen: const SmallChat());
  }
}

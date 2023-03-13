import 'package:flutter/material.dart';
import 'package:webdesign/pages/chat/widgets/small_chat.dart';

class SmallChat extends StatelessWidget {
  const SmallChat({super.key});

  @override
  Widget build(BuildContext context) {
    return SmallChatUI(
      chatGroupId: '',
      secondUserName: '',
    );
  }
}

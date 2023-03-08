// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, use_key_in_widget_constructors, unused_import, unused_local_variable

import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:webdesign/app_logic/services/message.dart';
import 'package:webdesign/pages/chat/widgets/group_chat_list.dart';
import 'package:webdesign/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webdesign/widgets/drawer.dart';

final _focusNode = FocusNode();
final String uid = FirebaseAuth.instance.currentUser!.uid;
// Order messages by timestamp in descending order

final String messageText = messageController.text;
final TextEditingController messageController = TextEditingController();
final senderId = uid; // Replace with the current user's ID
const recipientId = 'user2'; // Replace with the recipient's user ID
/*final newMessageRef = messagesRef.add({
  'text': messageText,
  'senderId': uid,
  'timestamp': FieldValue.serverTimestamp(),
});*/

class ChatUI extends StatefulWidget {
  String chatGroupId = 'asd';

  ChatUI({required this.chatGroupId, Key? key}) : super(key: key);

  @override
  _ChatUIState createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    String docid = widget.chatGroupId.isEmpty ? 'asd' : widget.chatGroupId;

    final messagesRef = FirebaseFirestore.instance
        .collection('Messages')
        .doc(docid)
        .collection('messages')
        .where('senderId', isEqualTo: uid) // Filter messages by senderId
        .orderBy('timestamp', descending: false);

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context, scaffoldKey),
      drawer: const Drawer(child: SideDrawer()),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ChatList(),
          Container(
            width: 800,
            height: 800,
            color: Colors.blue,
            child: Column(
              children: [
                Expanded(
                  child: widget.chatGroupId.isEmpty
                      ? Text('data')
                      : StreamBuilder<QuerySnapshot>(
                          stream: messagesRef.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final messages = snapshot.data!.docs;

                            if (messages.isEmpty) {
                              return const Center(
                                child: Text('No messages found.'),
                              );
                            }

                            return ListView.builder(
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                final text = message['text'];
                                final senderId = message['senderId'];
                                final timestamp = message['timestamp'];

                                // Check if the message was sent by the current user
                                final isCurrentUser = senderId == uid;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  // Align the message to the right if sent by the current user, or to the left if sent by another user
                                  child: Align(
                                    alignment: isCurrentUser
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: isCurrentUser
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        SelectableText(
                                          text,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${DateFormat.yMd().add_jm().format(timestamp.toDate())}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
                FocusScope(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            focusNode: _focusNode,
                            controller: _messageController,
                            decoration: const InputDecoration(
                              hintText: 'Type your message',
                            ),
                            onSubmitted: (value) async {
                              final text = _messageController.text.trim();
                              if (text.isNotEmpty) {
                                final timestamp = Timestamp.now();
                                final senderId =
                                    uid; // Replace with the current user's ID
                                const recipientId =
                                    'user2'; // Replace with the recipient's user ID

                                navnesen(senderId, text, timestamp, docid);
                                _messageController.clear();
                                _focusNode
                                    .requestFocus(); // Request focus after sending message
                              }
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () async {
                            final text = _messageController.text.trim();
                            if (text.isNotEmpty) {
                              final timestamp = Timestamp.now();
                              final senderId =
                                  uid; // Replace with the current user's ID
                              const recipientId =
                                  'user2'; // Replace with the recipient's user ID

                              navnesen(senderId, text, timestamp, docid);
                              _messageController.clear();
                            }
                          },
                          autofocus: true,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

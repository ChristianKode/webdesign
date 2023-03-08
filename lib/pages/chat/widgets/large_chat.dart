// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, use_key_in_widget_constructors, unused_import, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webdesign/app_logic/services/message.dart';
import 'package:webdesign/pages/chat/widgets/group_chat_list.dart';
import 'package:webdesign/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webdesign/widgets/drawer.dart';

final _focusNode = FocusNode();
final String uid = FirebaseAuth.instance.currentUser!.uid;
final messagesRef = FirebaseFirestore.instance
    .collection('Messages')
    .doc('0BFY9Ks3zxXFwJGzYinM')
    .collection('messages')
    .where('senderId', isEqualTo: uid) // Filter messages by senderId
    .orderBy('timestamp',
        descending: true); // Order messages by timestamp in descending order

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
  @override
  _ChatUIState createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  final _messageController = TextEditingController();

  Future<List<QueryDocumentSnapshot>> getMessages(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Messages')
        .doc('0BFY9Ks3zxXFwJGzYinM')
        .collection('messages')
        .where('senderId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

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
                  child: StreamBuilder<QuerySnapshot>(
                    stream: messagesRef.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
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

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Text(
                              '$text (from: $senderId, timestamp: $timestamp)',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
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

                                navnesen(senderId, text, timestamp);
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

                              navnesen(senderId, text, timestamp);
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

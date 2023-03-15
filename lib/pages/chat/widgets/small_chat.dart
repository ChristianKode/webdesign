import 'dart:async';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webdesign/app_logic/services/message.dart';
import 'package:webdesign/pages/chat/smallChat.dart';
import 'package:webdesign/pages/chat/widgets/group_chat_list.dart';
import 'package:webdesign/utils/responsive.dart';
import 'package:webdesign/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webdesign/widgets/drawer.dart';
import 'dart:ui' as ui;

StreamController<bool> _smallChatChangedController =
    StreamController<bool>.broadcast();
final _focusNode = FocusNode();
final ScrollController _scrollController = ScrollController();
final String messageText = messageController.text;
final TextEditingController messageController = TextEditingController();
final senderId = uid; // Replace with the current user's ID
const recipientId = 'user2'; // Replace with the recipient's user ID

class SmallChatUI extends StatefulWidget {
  late String chatGroupId;
  late String secondUserName;

  SmallChatUI(
      {required this.chatGroupId, required this.secondUserName, Key? key})
      : super(key: key);

  @override
  _SmallChatUIState createState() => _SmallChatUIState();
}

class _SmallChatUIState extends State<SmallChatUI> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _smallChatChangedController.close();
    super.dispose();
  }

  void _chatChanged() {
    _smallChatChangedController.sink.add(true);
  }

  @override
  Widget build(BuildContext context) {
    void goBack() {
      Navigator.pop(context);
    }

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    String docid = widget.chatGroupId.isEmpty ? 'asd' : widget.chatGroupId;
    String _currentName = widget.secondUserName;

    final messagesRef = FirebaseFirestore.instance
        .collection('Messages')
        .doc(docid)
        .collection('messages')
        .where('senderId') // Filter messages by senderId
        .orderBy('timestamp', descending: false);

    return Scaffold(
        body: Row(
      children: [
        Flexible(
          child: Container(
            color: Colors.grey.shade300,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 870,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                  // Show the name of the user you are chatting with
                  widget.chatGroupId.isEmpty
                      ? const SizedBox()
                      : Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            onTap: goBack,
                                            child: Icon(Icons.arrow_back)),
                                        Text(
                                          widget.secondUserName,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.09,
                                        )
                                      ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 25,
                                    height: 2,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    final textSpan = TextSpan(
                                      text: widget.secondUserName,
                                      style: TextStyle(fontSize: 16),
                                    );
                                    final textPainter = TextPainter(
                                      textDirection: ui.TextDirection.ltr,
                                      text: textSpan,
                                    )..layout(maxWidth: constraints.maxWidth);

                                    return Container(
                                      width: textPainter.width + 300,
                                      height: 1,
                                      color: Colors.blue,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                  Expanded(
                    child: widget.chatGroupId.isEmpty
                        ? NoSelectedChats()
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

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _scrollController.jumpTo(
                                    _scrollController.position.maxScrollExtent);
                              });

                              // Add a listener to the stream that scrolls to the bottom whenever a new event is emitted
                              messagesRef.snapshots().listen((_) {
                                _scrollController.jumpTo(
                                    _scrollController.position.maxScrollExtent);
                              });

                              return Flexible(
                                child: ListView.builder(
                                  controller: _scrollController,
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
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: isCurrentUser
                                                ? Colors.blue.shade400
                                                : Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: isCurrentUser
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                            children: [
                                              SelectableText(
                                                text,
                                                style: isCurrentUser
                                                    ? const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                      )
                                                    : const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                      ),
                                              ),
                                              isCurrentUser
                                                  ? Text(
                                                      '${DateFormat.yMd().add_jm().format(timestamp.toDate())}',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : Text(
                                                      '${DateFormat.yMd().add_jm().format(timestamp.toDate())}',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                  widget.chatGroupId.isEmpty
                      ? SizedBox.shrink()
                      : FocusScope(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey.shade200),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Flexible(
                                  child: TextField(
                                    focusNode: _focusNode,
                                    controller: _messageController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Skriv din melding',
                                    ),
                                    onSubmitted: (value) async {
                                      final text =
                                          _messageController.text.trim();
                                      if (text.isNotEmpty) {
                                        final timestamp = Timestamp.now();
                                        final senderId =
                                            uid; // Replace with the current user's ID
                                        const recipientId =
                                            'user2'; // Replace with the recipient's user ID

                                        navnesen(
                                            senderId, text, timestamp, docid);
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

                                      navnesen(
                                          senderId, text, timestamp, docid);
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
          ),
        ),
      ],
    ));
  }
}

class NoSelectedChats extends StatelessWidget {
  const NoSelectedChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      child: Column(
        children: [
          Image.network(
              'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2F5203102_5203102.jpg?alt=media&token=f12e93e6-cc6e-4f90-8927-7712ec00c475'),
          const Text(
            'Har du ingen oppdrag å fullføre?',
            style: TextStyle(fontSize: 30),
          ),
          TextButton(
              onPressed: () {},
              child: const Text(
                'Sjekk ut populære oppdrag her',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ))
        ],
      ),
    );
  }
}

// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, use_key_in_widget_constructors, unused_import, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webdesign/app_logic/services/message.dart';
import 'package:webdesign/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final String uid = FirebaseAuth.instance.currentUser!.uid;
final messagesRef = FirebaseFirestore.instance
    .collection('messages')
    .doc('wbGLLFbLCI8hMYDzWlI5')
    .collection('messages');
final String messageText = messageController.text;
final TextEditingController messageController = TextEditingController();

final newMessageRef = messagesRef.add({
  'text': messageText,
  'senderId': uid,
  'timestamp': FieldValue.serverTimestamp(),
});

class Chattos extends StatelessWidget {
  const Chattos({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context, scaffoldKey),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Container(
                  height: 1000,
                  width: 1000,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 200),
                child: ElevatedButton(
                  onPressed: () async {
                    final text = messageController.text;
                    final senderId =
                        uid; // Replace with the current user's ID
                    const recipientId =
                        'user2'; // Replace with the recipient's user ID
              
                    navnesen(senderId, recipientId);
                  }, child: const Icon(Icons.send),
                ),
              ),
              SizedBox(
                  width: 900,
                  child: TextField(
                    controller: messageController,
                    decoration:
                        const InputDecoration(hintText: 'Type your message here'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

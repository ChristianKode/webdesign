// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webdesign/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference messagesRef =
    FirebaseFirestore.instance.collection('messages');
final TextEditingController messageController = TextEditingController();

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
          child: Center(
            child: Container(
              padding: EdgeInsets.only(top: 300),
              height: 1000,
              width: 1000,
              color: Colors.blue,
            ),
          ),
        ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../widgets/appbar.dart';
import 'message.dart';

class Chattos extends StatefulWidget {
  const Chattos({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _chatpageState createState() => _chatpageState();
}

// ignore: camel_case_types
class _chatpageState extends State<Chattos> {
  String? email = FirebaseAuth.instance.currentUser?.email;
  _chatpageState();

  final fs = FirebaseFirestore.instance;
  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context, scaffoldKey),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.79,
                child: messages(
                  email: email as String,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: message,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue[100],
                        hintText: 'message',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        message.text = value!;
                      },
                      onFieldSubmitted: (value) {
                        if (message.text.isNotEmpty) {
                          fs.collection('Messages').doc().set({
                            'message': message.text.trim(),
                            'time': DateTime.now(),
                            'email': email,
                          });

                          message.clear();
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (message.text.isNotEmpty) {
                        fs.collection('Messages').doc().set({
                          'message': message.text.trim(),
                          'time': DateTime.now(),
                          'email': email,
                        });

                        message.clear();
                      }
                    },
                    icon: const Icon(Icons.send_sharp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

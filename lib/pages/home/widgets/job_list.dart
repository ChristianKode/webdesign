import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class JobList extends StatelessWidget {
  JobList({super.key});

  List<dynamic> _data = [];

  @override
  void initState() {
    _loadData();
  }

  _loadData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users");
    ref.once().then((DataSnapshot snapshot) {
          _data = snapshot.value as dynamic;
        } as FutureOr Function(DatabaseEvent value));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_data[index]['aid']),
            ),
          );
        });
  }
}

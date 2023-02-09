import 'dart:async';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class JobList extends StatefulWidget {
  const JobList({super.key});

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  final databaseRef = FirebaseDatabase.instance.ref().child("adventures");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: FirebaseAnimatedList(
          query: databaseRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            return Container(
              color: Colors.pink,
              child: ListTile(
                  subtitle: Text(snapshot.child("title").value.toString()),
                  title: Text(snapshot.child("uid").value.toString())),
            );
          },
        ),
      ),
    );
  }
}

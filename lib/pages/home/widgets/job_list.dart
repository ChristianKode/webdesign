import 'dart:async';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class JobList extends StatefulWidget {
  const JobList({super.key});

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  final databaseRef = FirebaseDatabase.instance.ref().child("adventures");
  ScrollController _scrollController = ScrollController();
  String downloadURL = '';

    Future<void> downloadURLExample(String aid) async {
    downloadURL = await FirebaseStorage.instance
        .ref()
        .child(aid)
        .child('/')
        .getDownloadURL();

        
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      

      
      
      child:
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          
          Container(
            child: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
                  _scrollController.animateTo(
                  _scrollController.offset - 150,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
            },),
          ),
            
            Expanded(
              child: Container(
                height: 300,
                child: FirebaseAnimatedList(
                  physics: ScrollPhysics(parent: ClampingScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  query: databaseRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 250,
                        color: Colors.white60,
                        child: ListTile(
                          
                          
                            subtitle: Text(snapshot.child("title").value.toString()),
                            title: Text(snapshot.child("price").value.toString() + "kr"),
                            leading: Image.network(downloadURLExample(snapshot.child("aid").value.toString()) as String,
                            height: 50,
                            width: 50,)
                            
                            
                            ),
                        
                      ),
                    );
                  },
                ),
              
                      ),
            ),
          IconButton(icon: Icon(Icons.arrow_forward), onPressed: (){
                _scrollController.animateTo(
                  _scrollController.offset + 150,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
            },),
          
        ],
      ),
    );
  }
}

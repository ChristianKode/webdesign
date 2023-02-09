import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class JobList extends StatelessWidget {
   JobList({super.key});

    late Map<dynamic, dynamic> ads;


  void getData() async{
     DatabaseReference ref = FirebaseDatabase.instance.ref();
    

    ref.child('adventures').once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> ads = snapshot.value as Map;
      if(ads != null){
        print(ads.keys);
      }

      
    } as FutureOr Function(DatabaseEvent value));


  }

  @override
  Widget build(BuildContext context) {
    return Container(
          color: Colors.white70,
          height: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Container(
              width: 300,
              color: Colors.red,
              child: Column(
                children: [
                  ElevatedButton(onPressed: (){
                    DatabaseReference ref = FirebaseDatabase.instance.ref('adventures');

                    ref.get().then((DataSnapshot snapshot) {
                      ads = snapshot.value as Map;
                      if (ads != null) {
                        //print(ads.values);
                      } else {
                        print("No data found");
                      }

                      //List<dynamic> first = ads.values.first;

                      //print(first as String);
                      

                    });
                    }, child: Text('asd'))
                ],
              ),
            ),
                        Container(
              width: 300,
              color: Colors.blue,
            ),
                        Container(
              width: 300,
              color: Colors.green,
            ),
                        Container(
              width: 300,
              color: Colors.yellow,
            )
          ]),

        
        
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:webdesign/pages/chat/widgets/chat_page.dart';
import 'package:webdesign/widgets/navbar.dart';

class JobView extends StatefulWidget {
  String aid = '';
  String uid = '';
  String img1 = '';
  String title = '';
  String descprition = '';
  String price = '';
  String address = '';
  String zipcode = '';
  JobView({super.key, 
  required this.aid,
  required this.uid,
  required this.img1,
  required this.title,
  required this.descprition,
  required this.price,
  required this.address,
  required this.zipcode});

  @override
  State<JobView> createState() => _JobViewState();
}

class _JobViewState extends State<JobView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(),
          BodyRow(
            aid: widget.aid, 
            uid: widget.uid, 
            img1: widget.img1, 
            title: widget.title, 
            descprition: widget.descprition, 
            price: widget.price, 
            address: widget.address, 
            zipcode: widget.zipcode)


        ],
      ),
    );
  }
}

class BodyRow extends StatelessWidget {
  String aid = '';
  String uid = '';
  String img1 = '';
  String title = '';
  String descprition = '';
  String price = '';
  String address = '';
  String zipcode = '';
  BodyRow({super.key, 
  required this.aid,
  required this.uid,
  required this.img1,
  required this.title,
  required this.descprition,
  required this.price,
  required this.address,
  required this.zipcode});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              Container(
                width: 500,
                height: 400,
                child: Image.network(img1, fit: BoxFit.cover,)
                ,
              ),
              Text(title)
            ],
          )),

        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 300,
              height: 150,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Color.fromRGBO(102, 82, 143, 1.0))),
              child: ElevatedButton(onPressed: ()async{
                    var uuid = Uuid();
                    var mid = uuid.v4();
                DatabaseReference messageRef = FirebaseDatabase.instance.ref().child('messages').child(mid);

                await messageRef.set({
                  "u1": FirebaseAuth.instance.currentUser?.uid,
                  "u2": uid
                });


                Get.to(() =>Chattos());
              }, child: const Text("Ta Kontakt")),
            )
          ],
        ))
      ],
    );
  }
}
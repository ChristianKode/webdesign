import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:webdesign/pages/chat/widgets/chat_page.dart';
import 'package:webdesign/pages/login/login.dart';
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
    return  Container(
      alignment: Alignment.center,
      width: 1300,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Container(
              width: 600,
              child: Column(
                children: [
                  Container(
                    width: 600,
                    height: 400,
                    child: Image.network(img1, fit: BoxFit.cover,)),

                  Container(
                    alignment: Alignment.centerLeft,
                    width: 600,
                    child: Text(title, style: GoogleFonts.tinos(fontSize: 30, fontWeight: FontWeight.w700),),
                  )  
                ],
              ),
            ),
          ),
    
          Container(width: 600,child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Color.fromRGBO(102, 82, 143, 1.0))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
    
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(price + 'kr', style: GoogleFonts.tinos(fontSize: 30),),
                      ),
                      SizedBox(
                        width: 350,
                        height: 40,
                        child: ElevatedButton(onPressed: ()async{
                              var uuid = Uuid();
                              var mid = uuid.v4();
                          DatabaseReference messageRef = FirebaseDatabase.instance.ref().child('messages').child(mid);
                          FirebaseAuth auth = FirebaseAuth.instance;

                          
                          
                          


                          if (true){
                          
                          await messageRef.set({
                            "u1": FirebaseAuth.instance.currentUser?.uid,
                            "u2": uid
                          });
                      
                      
                          Get.to(() =>Chattos());}
                          else{
                            Get.to(() =>Login());
                          }
                          
                        }, 
                        style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: const Color.fromRGBO(102, 82, 143, 1.0)),
                        child: const Text("Ta Kontakt")),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
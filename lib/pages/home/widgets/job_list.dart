import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webdesign/pages/job/job_view.dart';

class JobList extends StatefulWidget {
  const JobList({super.key});

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  final databaseRef = FirebaseDatabase.instance.ref().child("adventures");
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(maxWidth: 1500),
        height: 500,
        color: Color.fromARGB(111, 255, 234, 201),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  _scrollController.animateTo(
                    _scrollController.offset - 150,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  );
                },
              ),
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
                    return InkWell(
                      onTap: () {
                        String aid = snapshot.child('aid').value.toString();
                        String uid = snapshot.child('uid').value.toString();
                        String img1 = snapshot.child('img1').value.toString();
                        String title = snapshot.child('title').value.toString();
                        String descprition =
                            snapshot.child('descprition').value.toString();
                        String price = snapshot.child('price').value.toString();
                        String address =
                            snapshot.child('address').value.toString();
                        String zipcode =
                            snapshot.child('zipcode').value.toString();

                        Get.to(() => JobView(
                            aid: aid,
                            uid: uid,
                            img1: img1,
                            title: title,
                            descprition: descprition,
                            price: price,
                            address: address,
                            zipcode: zipcode));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red,
                                  blurRadius: 4,
                                  offset: Offset(4, 8), // Shadow position
                                ),
                              ],
                            ),
                            alignment: Alignment.topCenter,
                            width: 338,
                            child: ListTile(
                              
                              title: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          topLeft: Radius.circular(5)),
                                      child: Image.network(
                                        snapshot.child('img1').value.toString(),
                                        height: 220,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      snapshot.child('title').value.toString(),
                                      style: GoogleFonts.tinos(fontSize: 20),
                                    ),
                                    Text(
                                      snapshot.child('price').value.toString() +
                                          ' kr',
                                      style: GoogleFonts.tinos(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                _scrollController.animateTo(
                  _scrollController.offset + 150,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

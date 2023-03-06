// ignore: file_names
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webdesign/pages/job/job_view.dart';

class JobList extends StatefulWidget {
  const JobList({super.key});

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  final databaseRef = FirebaseDatabase.instance.ref().child("adventures");
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 0, left: 0),
        child: Container(
          color: const Color.fromARGB(7, 0, 0, 0),
          constraints: const BoxConstraints(maxWidth: 1500),
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      _scrollController.animateTo(
                        _scrollController.offset - 350,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    },
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 350,
                      child: FirebaseAnimatedList(
                        physics: const ScrollPhysics(
                            parent: ClampingScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        query: databaseRef,
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          return InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onTap: () {
                                String aid =
                                    snapshot.child('aid').value.toString();
                                String uid =
                                    snapshot.child('uid').value.toString();
                                String img1 =
                                    snapshot.child('img1').value.toString();
                                String title =
                                    snapshot.child('title').value.toString();
                                String descprition = snapshot
                                    .child('descprition')
                                    .value
                                    .toString();
                                String price =
                                    snapshot.child('price').value.toString();
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
                                padding: const EdgeInsets.only(
                                    right: 35, bottom: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(20, 0, 0, 0),
                                        blurRadius: 2,
                                        offset:
                                            Offset(0.5, 5), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              topLeft: Radius.circular(5)),
                                          child: Image.network(
                                            snapshot
                                                .child('img1')
                                                .value
                                                .toString(),
                                            height: 270,
                                            width: 320,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          snapshot
                                              .child('title')
                                              .value
                                              .toString(),
                                          style: GoogleFonts.tinos(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          '${snapshot.child('price').value} kr',
                                          style:
                                              GoogleFonts.tinos(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      _scrollController.animateTo(
                        _scrollController.offset + 350,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    },
                  ),
                  const SizedBox(
                    width: 30,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

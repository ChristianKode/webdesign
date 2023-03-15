// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webdesign/pages/job/job_view.dart';
import 'package:webdesign/pages/login/login.dart';

class JobList extends StatefulWidget {
  const JobList({super.key});

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  String? currentUid = FirebaseAuth.instance.currentUser?.uid;
  DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref().child("adventures");
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (MediaQuery.of(context).size.width < 736) {
        containerWidth -= 80;
      }
      if (MediaQuery.of(context).size.width > 736) {
        containerWidth = 310;
      }
      return Container(
        color: const Color.fromARGB(7, 0, 0, 0),
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1500),
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                            String uid = snapshot.child('uid').value.toString();
                            if (uid == currentUid) {
                              return const SizedBox.shrink();
                            }
                            return InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                onTap: () async {
                                  if (FirebaseAuth.instance.currentUser !=
                                      null) {
                                    final fire = FirebaseFirestore.instance;
                                    final aid =
                                        snapshot.child('aid').value.toString();

                                    await fire
                                        .collection('Users')
                                        .doc(currentUid)
                                        .update({'aid': aid});

                                    Get.to(() => const JobView());
                                  } else {
                                    Get.to(() => const Login());
                                  }
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 12),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(5)),
                                            child: Image.network(
                                              snapshot
                                                  .child('img1')
                                                  .value
                                                  .toString(),
                                              width: containerWidth,
                                              height: 270,
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
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:webdesign/pages/chat/widgets/chat_page.dart';
import 'package:webdesign/pages/job/widgets/jobBodyRow.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/widgets/footer_overall.dart';

import '../../widgets/appbar.dart';

class JobView extends StatefulWidget {
  String aid = '';
  String uid = '';
  String img1 = '';
  String title = '';
  String descprition = '';
  String price = '';
  String address = '';
  String zipcode = '';
  JobView(
      {super.key,
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context, scaffoldKey),
      drawer: const Drawer(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BodyRow(
                      aid: widget.aid,
                      uid: widget.uid,
                      img1: widget.img1,
                      title: widget.title,
                      descprition: widget.descprition,
                      price: widget.price,
                      address: widget.address,
                      zipcode: widget.zipcode),
                  Footer()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

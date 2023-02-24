import 'package:flutter/material.dart';
import 'package:webdesign/pages/job/widgets/job_body_row.dart';
import 'package:webdesign/widgets/footer_overall.dart';

import '../../widgets/appbar.dart';

// ignore: must_be_immutable
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
                  const Footer()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

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
    return Column(
      children: [
        Text(widget.aid),
        Text(widget.uid),
        Text(widget.title),
        Text(widget.price)
      ],
    );
  }
}
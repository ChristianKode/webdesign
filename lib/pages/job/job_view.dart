import 'package:flutter/material.dart';
import 'package:webdesign/pages/job/widgets/job_body_row.dart';
import 'package:webdesign/widgets/drawer.dart';
import 'package:webdesign/widgets/footer_overall.dart';

import '../../widgets/appbar.dart';

// ignore: must_be_immutable
class JobView extends StatefulWidget {
  JobView({
    super.key,
  });

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
      drawer: const Drawer(
        child: SideDrawer(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [BodyRow(), const Footer()],
              ),
            ),
          )
        ],
      ),
    );
  }
}

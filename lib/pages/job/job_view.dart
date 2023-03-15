import 'package:flutter/material.dart';
import 'package:webdesign/pages/job/widgets/job_body_row.dart';
import 'package:webdesign/core/utils/widgets/drawer.dart';
import 'package:webdesign/core/utils/widgets/footer_overall.dart';

import '../../core/utils/widgets/appbar.dart';

// ignore: must_be_immutable
class JobView extends StatefulWidget {
  const JobView({
    super.key,
  });

  @override
  State<JobView> createState() => _JobViewState();
}

class _JobViewState extends State<JobView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar(context, scaffoldKey),
        drawer: const Drawer(
          child: SideDrawer(),
        ),
        body: const Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [BodyRow(), Footer()],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../widgets/appbar.dart';

class SmallProfile extends StatelessWidget {
  const SmallProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context, scaffoldKey),
      drawer: const Drawer(),
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}

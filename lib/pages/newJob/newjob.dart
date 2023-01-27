import 'package:flutter/material.dart';
import 'package:webdesign/pages/newJob/widgets/large_newjob.dart';
import 'package:webdesign/pages/newJob/widgets/small_newjob.dart';
import 'package:webdesign/utils/responsivebody.dart';

class NewJob extends StatelessWidget {
  const NewJob({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
        largeScreen: LargeNewJob(),
        mediumScreen: LargeNewJob(),
        smallScreen: SmallNewJob());
  }
}

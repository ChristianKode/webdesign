import 'package:flutter/material.dart';
import 'package:webdesign/pages/newJob/widgets/large_newjob.dart';
import 'package:webdesign/pages/newJob/widgets/small_newjob.dart';
import 'package:webdesign/core/utils/responsive/responsivebody.dart';

class NewJob extends StatelessWidget {
  const NewJob({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: LargeNewJob(),
        mediumScreen: LargeNewJob(),
        smallScreen: SmallNewJob());
  }
}

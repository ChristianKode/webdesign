import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

final dynamicLinkParams = DynamicLinkParameters(
  link: Uri.parse(" https://ungansatt123.page.link"),
  uriPrefix: "https://ungansatt123.page.link",
  androidParameters:
      const AndroidParameters(packageName: "com.example.app.android"),
  iosParameters: const IOSParameters(bundleId: "com.example.app.ios"),
);
Future<Uri> DynamicLink() async =>
    await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/app_logic/services/firebase_auth.dart';
import 'package:webdesign/pages/chat/widgets/large_chat.dart';
import 'package:webdesign/pages/forgot/forgot.dart';
import 'package:webdesign/pages/home/widgets/main_home.dart';
import 'package:webdesign/pages/job/job_view.dart';
import 'package:webdesign/pages/job/widgets/job_body_row.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/pages/newJob/newjob.dart';
import 'package:webdesign/pages/profile/profile.dart';
import 'package:webdesign/pages/register/register.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // iOS requires you run in release mode to test dynamic links ("flutter run --release").
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      title: 'Dynamic Links Example',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MyApp(),
        '/helloworld': (BuildContext context) => MyApp(),
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _HomeState();
}

class _HomeState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (_) => AuthService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges,
            initialData: null,
          )
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'UngAnsatt',
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => LargeHome()),
            GetPage(name: '/main_home', page: () => LargeHome()),
            GetPage(name: '/Register', page: () => const Register()),
            GetPage(name: '/Login', page: () => Login()),
            GetPage(name: '/Forgot', page: () => const Forgot()),
            GetPage(name: '/NewJob', page: () => const NewJob()),
            GetPage(name: '/Profile', page: () => const Profile()),
            GetPage(name: '/Chat', page: () => const Chat()),
            GetPage(name: '/JobView', page: () => JobView())
          ],
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LargeHome(),
        ));
  }
}

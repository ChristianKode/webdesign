import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/app_logic/services/firebase_auth.dart';
import 'package:webdesign/pages/chat/chat.dart';
import 'package:webdesign/pages/chat/widgets/chat_page.dart';
import 'package:webdesign/pages/forgot/forgot.dart';
import 'package:webdesign/pages/home/widgets/main_home.dart';
import 'package:webdesign/pages/job/job_view.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/pages/newJob/newjob.dart';
import 'package:webdesign/pages/profile/profile.dart';
import 'package:webdesign/pages/register/register.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui' as ui;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
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
                GetPage(name: '/', page: () =>  LargeHome()),
                GetPage(name: '/main_home', page: () => LargeHome()),
                GetPage(name: '/Register', page: () => const Register()),
                GetPage(name: '/Login', page: () => const Login()),
                GetPage(name: '/Forgot', page: () => const Forgot()),
                GetPage(name: '/NewJob', page: () => const NewJob()),
                GetPage(name: '/Profile', page: () => const Profile()),
                GetPage(name: '/Chattos', page: () => Chattos()),
                GetPage(name: '/JobView', page: () => JobView(aid: "", uid: "", img1: "", title: "", descprition: "", price: "", address: "", zipcode: "")),
              ],
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: LargeHome(),
              
              )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/app_logic/services/firebase_auth.dart';
import 'package:webdesign/pages/chat/chat.dart';
import 'package:webdesign/pages/forgot/forgot.dart';
import 'package:webdesign/pages/home/homeIn.dart';
import 'package:webdesign/pages/home/homeOut.dart';
import 'package:webdesign/pages/home/widgets/large_home.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/pages/newJob/newjob.dart';
import 'package:webdesign/pages/profile/profile.dart';
import 'package:webdesign/pages/register/register.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              GetPage(name: '/', page: () => const HomeIn()),
              GetPage(name: '/HomeIn', page: () => HomeIn()),
              GetPage(name: '/Register', page: () => const Register()),
              GetPage(name: '/Login', page: () => const Login()),
              GetPage(name: '/Forgot', page: () => const Forgot()),
              GetPage(name: '/NewJob', page: () => const NewJob()),
              GetPage(name: '/Profile', page: () => const Profile()),
              GetPage(name: '/Chat', page: () => const Chat()),
            ],
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: LargeHome()));
  }
}

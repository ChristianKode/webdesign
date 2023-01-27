import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/app_logic/services/firebase_auth.dart';
import 'package:webdesign/pages/forgot/forgot.dart';
import 'package:webdesign/pages/home/home_viewLoggedOut.dart';
import 'package:webdesign/pages/home/home_viewULoggetInn.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/pages/register/register.dart';
import 'package:webdesign/widgets/navbarLoggedIn.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
              GetPage(name: '/', page: () => HomeOut()),
              GetPage(name: '/HomeIn', page: () => HomeIn()),
              GetPage(name: '/Register', page: () => Register()),
              GetPage(name: '/Login', page: () => Login()),
              GetPage(name: '/Forgot', page: () => Forgot()),
            ],
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomeOut()));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webdesign/app_logic/services/firebase_auth.dart';
import 'package:webdesign/pages/chat/widgets/large_chat.dart';
import 'package:webdesign/pages/forgot/forgot.dart';
import 'package:webdesign/pages/home/widgets/main_home.dart';
import 'package:webdesign/pages/job/job_view.dart';
import 'package:webdesign/pages/login/login.dart';
import 'package:webdesign/pages/newJob/newjob.dart';
import 'package:webdesign/pages/profile/profile_view.dart';
import 'package:webdesign/pages/register/register.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';

final router = FluroRouter();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  router.define('/',
      handler: Handler(handlerFunc: (context, params) => LargeHome()));
  router.define('/main_home',
      handler: Handler(handlerFunc: (context, params) => LargeHome()));
  router.define('/Register',
      handler: Handler(handlerFunc: (context, params) => const Register()));
  router.define('/Login',
      handler: Handler(handlerFunc: (context, params) => const Login()));
  router.define('/Forgot',
      handler: Handler(handlerFunc: (context, params) => const Forgot()));
  router.define('/NewJob',
      handler: Handler(handlerFunc: (context, params) => const NewJob()));
  router.define('/Profile',
      handler: Handler(handlerFunc: (context, params) => const ProfileView()));
  router.define('/Chat',
      handler: Handler(handlerFunc: (context, params) => const Chat()));
  router.define('/JobView',
      handler: Handler(handlerFunc: (context, params) => const JobView()));

  runApp(MyApp(
    router: router,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required router});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        onGenerateRoute: router.generator,
        debugShowCheckedModeBanner: false,
        title: 'UngAnsatt',
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}

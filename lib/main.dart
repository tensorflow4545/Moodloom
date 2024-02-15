import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:HappyLink/User_View/views/SplashScreen/SplashScreen.dart';
import 'package:HappyLink/User_View/views/SplashScreen/firstSplashScreen.dart';

import 'package:HappyLink/data/firebase_api.dart';
import 'package:HappyLink/firebase_options.dart';
import 'package:HappyLink/utils/Theme_services.dart';
import 'package:HappyLink/utils/theme_controller.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("some notification recieved");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PushNotificationService().setupFirebase();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  Get.lazyPut(() => ThemeService());
  Get.lazyPut(() => ThemeController());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? isLoggedin = prefs.getString('FireToken') ?? '';
  runApp((isLoggedin.isNotEmpty) ? MyApp() : LoggedIn());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool? isDoctor = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDoctor = prefs.getBool('userType');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class LoggedIn extends StatelessWidget {
  LoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Spscreen(),
    );
  }
}

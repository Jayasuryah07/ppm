import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'Screens/GetStartedScreen/GetStartedPage.dart';
import 'Screens/HomeScreen/HomePage.dart';
import 'Screens/LoginScreen/LoginPage.dart';
import 'Screens/SplashScreen/SplashPage.dart';
import 'Screens/SplashScreen/splash_common_page.dart';
import 'Utils/ConstHelper.dart';
import 'Utils/SharedPrefHelper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: 'AIzaSyBGRV8gbm8T-3Vtub6LLNMC_bxgBG7HcDM',
          appId: '1:599295240072:android:6f560f191411e8e35bbc3d',
          messagingSenderId: '599295240072',
          projectId: 'pp-milan',
          storageBucket: 'pp-milan.firebasestorage.app',
        ),
      );
    } else {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyDqiEU-q24qR7HHRojofr9JE3TgBjTy_AI',
          appId: '1:599295240072:ios:01a4043d8e42bab55bbc3d',
          messagingSenderId: '599295240072',
          projectId: 'ppmilan-bngags',
          storageBucket: 'pp-milan.firebasestorage.app',
          iosClientId: '599295240072-osbohkk9gfscs67s9iqdai750qev0gsf.apps.googleusercontent.com',
          iosBundleId: 'com.ppm.agsolutions',
        ),
      );
    }
    await FirebaseMessaging.instance.requestPermission();
    print("✅ Firebase initialized successfully");
  } catch (e) {
    print("❌ Firebase Initialization Failed: $e");
  }

  await SharedPrefHelper.sharedPrefHelper.initSharedPref();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  configLoading();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
      statusBarColor:ConstHelper.orangeColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor:ConstHelper.orangeColor,
    ));
    return GetMaterialApp(
      title: 'PP Milan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      initialRoute: '/',
      navigatorKey: ConstHelper.navigatorKey,
      builder: EasyLoading.init(),
      routes: {
        '/' : (p0) => const SplashCommonPage(),
        'getStarted' : (p0) => const GetStartedPage(),
        'login' : (p0) => const LoginPage(),
        'home' : (p0) => const HomePage(),
      },
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false;
}

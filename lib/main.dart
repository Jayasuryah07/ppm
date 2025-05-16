import 'package:firebase_core/firebase_core.dart';
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
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyAuJ6X5u24c11z90nDHOIwJ-SqCaz14QF4',
      appId: '1:787219854027:android:e26108dddd780a17a3a14e',
      messagingSenderId: '787219854027',
      projectId: 'ppmilan-77fd2',
      storageBucket: 'ppmilan-77fd2.firebasestorage.app',
    ),
  );
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:ConstHelper.orangeColor,
      statusBarIconBrightness: Brightness.light,
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

/*
import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Data/Providers/session_manager.dart';
import '../../Data/Services/api_service.dart';
import '../../RoutesManagment/routes.dart';
import '../../View/auth/login_screen.dart';
import '../Screens/HomeScreen/HomePage.dart';
import 'ConstHelper.dart';
import 'SharedPrefHelper.dart';
import 'network_connectivity.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool isChecking = false;

  /// Timer for 5 seconds to check connection
  @override
  void initState() {
    super.initState();
    */
/* Timer.periodic(Duration(seconds: 5), (timer) {
      if (mounted) checkConnection();
    });*//*

  }

  /// check network connection
  Future<void> checkConnection() async {
    setState(() => isChecking = true);

    if (await ConstHelper.checkInternet()) {
      print("Internet connection found");
      bool login = SharedPrefHelper.sharedPreferences.getBool('login') ?? false;
      try{
        if(login){
          await homeController.getUserData();
          EasyLoading.dismiss();
          Get.off(()=>const HomePage(),);

        }else{
          Get.offNamed('getStarted');
        }
      }catch(e){
        Get.offNamed('getStarted');
      }
    } else {
      print("Internet connection ::::::::not:::::::::: found");
      setState(() => isChecking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img_no_internet.png',
                  width: Get.width * 0.05,
                  height: Get.width * 0.05,
                  //  repeat: true,
                ),
                const SizedBox(height: 24),
                const Text(
                  "You're offline",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Please check your internet connection to explore deco panel.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: isChecking ? null : checkConnection,
                  icon: const Icon(Icons.refresh),
                  label: isChecking
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text("Retry Connection"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                */
/* OutlinedButton.icon(
                  onPressed: () {
                  //  AppSettings.openAppSettings();
                  },
                  icon: const Icon(Icons.settings),
                  label: const Text("Open Internet Settings"),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),*//*

              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/

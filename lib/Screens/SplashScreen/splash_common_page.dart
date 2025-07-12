import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';
import '../../Controllers/HomeController.dart';
import '../../Utils/SharedPrefHelper.dart';
import '../HomeScreen/HomePage.dart';


class SplashCommonPage extends StatefulWidget {
  const SplashCommonPage({super.key});

  @override
  State<SplashCommonPage> createState() => _SplashCommonPageState();
}

class _SplashCommonPageState extends State<SplashCommonPage> {
  AppUpdateInfo? _updateInfo;
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForUpdate();
    // checkAndRequestCameraPermissions(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserData(context);
    });
  }

  Future<void> checkForUpdate() async {
    try {
      if (Platform.isAndroid) {
        _updateInfo = await InAppUpdate.checkForUpdate();
        if (_updateInfo?.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          startFlexibleUpdate();
        }
      }
    } catch (e) {
      print("Error checking for updates: $e");
    }
  }

  // Start a flexible update
  Future<void> startFlexibleUpdate() async {
    try {
      await InAppUpdate.startFlexibleUpdate();
      await InAppUpdate.completeFlexibleUpdate();
      print("Update installed successfully.");
    } catch (e) {
      print("Error during update: $e");
    }
  }

  Future<void> getUserData(BuildContext context) async {
    /*if (!(await ConstHelper.checkInternet())) {
      //  networkDialog(context);
      Get.to(const NoInternetScreen());
      return;
    }*/
    bool login = SharedPrefHelper.sharedPreferences.getBool('login') ?? false;
    try{
      if(login){
        await homeController.getUserData();
        EasyLoading.dismiss();
        Get.off(()=>const HomePage(),);

      }else{
        EasyLoading.dismiss();
        Get.offNamed('getStarted');
      }
    }catch(e){
      EasyLoading.dismiss();
      Get.offNamed('getStarted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/image/AGS_LOGO.png",
                  height: Get.height * 0.15,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                RichText(
                  text: TextSpan(
                    text: "AG ",
                    style: GoogleFonts.roboto(
                      fontSize: Get.height / 28,
                      color: const Color(0xFF076894),
                      fontWeight: FontWeight.w900,
                    ),
                    children: [
                      TextSpan(
                        text: "Solutions",
                        style: GoogleFonts.roboto(
                          fontSize: Get.height / 28,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFF076894),
            child: Text(
              "WEBSITE | WEB APPLICATION\nMOBILE APPLICATION | DIGITAL MARKETING",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: Get.height / 50,
                color: const Color(0xFFffffff),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.15,
          ),
        ],
      ),
    );
  }
}

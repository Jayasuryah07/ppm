import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utils/ConstHelper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 3,), () => Get.offNamed('getStarted'),);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstHelper.whiteColor,
        body: Center(
          child: Image.asset(
            "assets/image/applogo.png",
            width: Get.width/2,
          ),
        ),
      ),
    );
  }
}

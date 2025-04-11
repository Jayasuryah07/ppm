import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SplashPage.dart';

class SplashCommonPage extends StatefulWidget {
  const SplashCommonPage({super.key});

  @override
  State<SplashCommonPage> createState() => _SplashCommonPageState();
}

class _SplashCommonPageState extends State<SplashCommonPage> {
  @override
  void initState() {
    super.initState();
    // Set the timer for 2 seconds before navigating to the next screen
    Timer(const Duration(seconds: 3,), () => Get.offNamed('getStarted'),);
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../Controllers/HomeController.dart';
import '../../Utils/ConstHelper.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("About Us", style: TextStyle(fontSize: 20,
            color: ConstHelper.blackColor,
            fontWeight: FontWeight.bold,),),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              'assets/image/drawerIconSVG.svg', height: Get.width / 18,
              width: Get.width / 18,),
          ),
          centerTitle: true,
          backgroundColor: ConstHelper.whiteColor,
          surfaceTintColor: ConstHelper.whiteColor,
          elevation: 10,
          shadowColor: ConstHelper.greyColor.withOpacity(0.1),
          actions: [
            IconButton(
              onPressed: () async {
                Get.back();
                await Future.delayed(const Duration(milliseconds: 300,),);
                homeController.advancedDrawerController.hideDrawer();
              },
              icon: SvgPicture.asset(
                'assets/image/homeSVG.svg', height: Get.width / 18,
                width: Get.width / 18,
                color: ConstHelper.orangeColor,),
            ),
          ],
          // elevation: 3,
          // shadowColor: Colors.grey.shade50.withOpacity(0.3),
        ),
        backgroundColor: ConstHelper.whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.width / 15,),
              Center(
                child: Image.asset(
                  'assets/image/applogo.png',
                  height: Get.width / 1.6,
                  width: Get.width / 1.6,
                ),
              ),
              SizedBox(height: Get.width / 20,),
              Text(
                "PP Milan",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: ConstHelper.orangeColor,
                  fontSize: Get.height / 45,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Tag line here",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: ConstHelper.blackColor,
                  fontSize: Get.height / 60,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              commonAboutUsWidget(
                title: "8867171060",
                imageIconData: Icons.call_rounded,
                isIcon: true,
                context: context,
              ),
              commonAboutUsWidget(
                title: "info@ppmilan.in",
                imageIconData: Icons.email_outlined,
                isIcon: true,
                context: context,
              ),
              commonAboutUsWidget(
                title: "www.ppmilan.in",
                imageIconData: Icons.public,
                isIcon: true,
                context: context,
              ),
              commonAboutUsWidget(
                title: "www.google.com",
                imageIconData: Icons.location_on_outlined,
                isIcon: true,
                context: context,
              ),
              // Container(
              //   width: Get.width,
              //   color: ConstHelper.greyColor.withOpacity(0.1),
              //   padding: EdgeInsets.symmetric(vertical: Get.width / 30,),
              //   alignment: Alignment.center,
              //   child: Text(
              //     'Business Booster Club',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       color: ConstHelper.orangeColor,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
              // SizedBox(height: Get.width / 20,),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: Get.width / 30,),
              //   child: Text(
              //     'I am flexible, reliable and possess excellent time keeping skills. I am an enthusiastic, self-motivated, reliable, responsible and hard working person. I am a mature team worker and adaptable to all challenging situations. I am able to work well both in a team environment as well as using own initiative.',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       color: ConstHelper.blackColor,
              //       fontSize: 15,
              //     ),
              //   ),
              // ),
              // SizedBox(height: Get.width / 20,),
              // Container(
              //   width: Get.width,
              //   color: ConstHelper.greyColor.withOpacity(0.1),
              //   padding: EdgeInsets.symmetric(vertical: Get.width / 30,),
              //   alignment: Alignment.center,
              //   child: Text(
              //     'Our Directors',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       color: ConstHelper.orangeColor,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
              // SizedBox(height: Get.width / 20,),
              // Center(
              //   child: SizedBox(
              //     width: Get.width / 3.6,
              //     child: Column(
              //       children: [
              //         Container(
              //           height: Get.width / 3.6,
              //           width: Get.width / 3.6,
              //           decoration: BoxDecoration(
              //             color: ConstHelper.whiteColor,
              //             shape: BoxShape.circle,
              //             boxShadow: [
              //               BoxShadow(
              //                 color: ConstHelper.greyColor.withOpacity(0.6),
              //                 offset: Offset(0, 1),
              //                 blurRadius: 1,
              //               ),
              //             ],
              //             image: DecorationImage(
              //                 fit: BoxFit.cover,
              //                 image: AssetImage(
              //                   'assets/image/applogo.png',
              //                 )
              //             ),
              //           ),
              //         ),
              //         SizedBox(height: Get.width / 60,),
              //         Text(
              //           'Bhupendra Kotwal',
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             color: ConstHelper.blackColor,
              //             fontSize: 16,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: Get.width / 20,),
              // GestureDetector(
              //   onTap: () {
              //     launchUrl(Uri.parse("https://ppmilan.in"));
              //   },
              //   child: Center(
              //     child: Container(
              //       decoration: BoxDecoration(
              //         color: ConstHelper.orangeColor,
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //       padding: EdgeInsets.symmetric(
              //         horizontal: Get.width / 12, vertical: Get.width / 50,),
              //       child: Text(
              //         'Know More',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           color: ConstHelper.whiteColor,
              //           fontSize: 16,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: Get.width / 15,),
            ],
          ),
        ),
      ),
    );
  }

  Widget commonAboutUsWidget({bool isIcon = false,
    String? title,
    dynamic imageIconData,
    BuildContext? context}) {
    return Padding(
      padding:
      EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                !isIcon
                    ? Image.asset(imageIconData)
                    : Icon(
                  imageIconData,
                  color: ConstHelper.orangeColor,
                  size: Get.height * 0.045,
                ),
              ],
            ),
          ),
          SizedBox(
            width: Get.width * 0.04,
          ),
          Expanded(
            flex: 4,
            child: Text(
              title ?? "",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: ConstHelper.blackColor,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
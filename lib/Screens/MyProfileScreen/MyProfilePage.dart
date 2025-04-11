import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Controllers/HomeController.dart';

import '../../Utils/ConstHelper.dart';
import 'EditProfilePage.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Profile",style: TextStyle(fontSize: 20,color: ConstHelper.blackColor,fontWeight: FontWeight.bold,),),
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: SvgPicture.asset('assets/image/drawerIconSVG.svg',height: Get.width/18,width: Get.width/18,),
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
              icon: SvgPicture.asset('assets/image/homeSVG.svg',height: Get.width/18,width: Get.width/18,color: ConstHelper.orangeColor,),
            ),
          ],
          // elevation: 3,
          // shadowColor: Colors.grey.shade50.withOpacity(0.3),
        ),
        backgroundColor: ConstHelper.whiteColor,
        body: Obx(() => Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width/20,),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.width/30,),
                Center(
                  child: Container(
                    height: Get.width/1.6,
                    width: Get.width/1.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ConstHelper.blackColor.withOpacity(0.8),
                          ConstHelper.orangeColor.withOpacity(0.8),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.all(Get.width/80),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: CachedNetworkImage(
                        imageUrl: homeController.userData.value.profilePhoto != null && homeController.userData.value.profilePhoto!.trim().isNotEmpty ? '${ConstHelper.userImagesPath}${homeController.userData.value.profilePhoto!}' : ConstHelper.profileImagePath,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: ConstHelper.whiteColor,
                          ),
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(color: ConstHelper.orangeColor,),
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: ConstHelper.whiteColor,
                          ),
                          child: Image.asset(
                            'assets/image/imageNotFound.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.width/15,),
                Center(
                  child: Text(
                    homeController.userData.value.name == null || homeController.userData.value.name!.trim().isEmpty ? ConstHelper.nameNotAvailableMsg : homeController.userData.value.name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ConstHelper.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Center(
                  child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                          children: [
                            TextSpan(
                              text: 'User ID : ',
                              style: TextStyle(
                                color: ConstHelper.blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: homeController.userData.value.id == null || homeController.userData.value.id == 0 ? ConstHelper.naMsg : homeController.userData.value.id!.toString(),
                              style: TextStyle(
                                color: ConstHelper.orangeColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ]
                      )
                  ),
                ),
                SizedBox(height: Get.width/12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/image/personWithRoundedSVG.svg',height: Get.width/25,width: Get.width/25,color: ConstHelper.blackColor,),
                        SizedBox(width: Get.width/30,),
                        Flexible(
                          child: Text(
                            'Personal Information',
                            style: headingTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/20,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Date of Birth',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileDateOfBirth == null || homeController.userData.value.profileDateOfBirth!.year <= 0 ? ConstHelper.naMsg : DateFormat('dd | MMM | yyyy').format(homeController.userData.value.profileDateOfBirth!),
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Date of Time',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileTimeOfBirth == null || homeController.userData.value.profileTimeOfBirth!.trim().isEmpty ? ConstHelper.naMsg : DateFormat('hh:mm a').format(DateFormat('h:m').parse(homeController.userData.value.profileTimeOfBirth!)),
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Place of Birth',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profilePlaceOfBirth == null || homeController.userData.value.profilePlaceOfBirth!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profilePlaceOfBirth!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Height',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileHeight == null || homeController.userData.value.profileHeight!.trim().isEmpty ? ConstHelper.naMsg : '${homeController.userData.value.profileHeight![0]} ft ${homeController.userData.value.profileHeight!.substring(1)} Inch',
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Gender',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileGender == null || homeController.userData.value.profileGender!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileGender!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Email',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.email == null || homeController.userData.value.email!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.email!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Mobile No',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileMobile == null || homeController.userData.value.profileMobile!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileMobile!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Whatsapp No',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileWhatsapp == null || homeController.userData.value.profileWhatsapp!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileWhatsapp!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Main Contact No',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileMainContactNum == null || homeController.userData.value.profileMainContactNum!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileMainContactNum!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Have you been married before?',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileHaveMarriedBefore == null || homeController.userData.value.profileHaveMarriedBefore!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileHaveMarriedBefore!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Physical Disability',
                                style: titleTextStyle,
                              ),
                              Text(
                                '(if any)',
                                style: valueTextStyle,
                              ),
                            ],
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profilePhysicalDisablity == null || homeController.userData.value.profilePhysicalDisablity!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profilePhysicalDisablity!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    myDividerWidget(),
                  ],
                ),
                SizedBox(height: Get.width/60,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/image/occupationSVG.svg',height: Get.width/25,width: Get.width/25,color: ConstHelper.blackColor,),
                        SizedBox(width: Get.width/30,),
                        Flexible(
                          child: Text(
                            'Occupation Details',
                            style: headingTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/20,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Qualification',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileEducation == null || homeController.userData.value.profileEducation!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileEducation!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Occupation',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileOccupation == null || homeController.userData.value.profileOccupation!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileOccupation!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: Get.width/90,),
                    // Row(
                    //   // crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         'Organization',
                    //         style: titleTextStyle,
                    //       ),
                    //     ),
                    //     threeDotWidget(),
                    //     Expanded(
                    //       child: Text(
                    //         ConstHelper.naMsg,
                    //         style: valueTextStyle,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: Get.width/90,),
                    // Row(
                    //   // crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         'Org. Type',
                    //         style: titleTextStyle,
                    //       ),
                    //     ),
                    //     threeDotWidget(),
                    //     Expanded(
                    //       child: Text(
                    //         ConstHelper.naMsg,
                    //         style: valueTextStyle,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: Get.width/90,),
                    // Row(
                    //   // crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         'Annual Income',
                    //         style: titleTextStyle,
                    //       ),
                    //     ),
                    //     threeDotWidget(),
                    //     Expanded(
                    //       child: Text(
                    //         ConstHelper.naMsg,
                    //         style: valueTextStyle,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    myDividerWidget(),
                  ],
                ),
                SizedBox(height: Get.width/60,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/image/familySVG.svg',height: Get.width/25,width: Get.width/25,color: ConstHelper.blackColor,),
                        SizedBox(width: Get.width/30,),
                        Flexible(
                          child: Text(
                            'Family Details',
                            style: headingTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/20,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Father Name',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileFatherFullName == null || homeController.userData.value.profileFatherFullName!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileFatherFullName!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Reference Name',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileRefContactName == null || homeController.userData.value.profileRefContactName!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileRefContactName!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '̌Reference Mobile No',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileRefContactMobile == null || homeController.userData.value.profileRefContactMobile!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileRefContactMobile!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Working City',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileWorkingCity == null || homeController.userData.value.profileWorkingCity!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileWorkingCity!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Permanent Address',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profilePermanentAddress == null || homeController.userData.value.profilePermanentAddress!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profilePermanentAddress!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Important Note',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileNote == null || homeController.userData.value.profileNote!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileNote!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    myDividerWidget(),
                  ],
                ),
                SizedBox(height: Get.width/60,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/image/kundaliSVG.svg',height: Get.width/25,width: Get.width/25,color: ConstHelper.blackColor,),
                        SizedBox(width: Get.width/30,),
                        Flexible(
                          child: Text(
                            'Kundali',
                            style: headingTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/20,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Gotra',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileGotra == null || homeController.userData.value.profileGotra!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileGotra!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.width/90,),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Community',
                            style: titleTextStyle,
                          ),
                        ),
                        threeDotWidget(),
                        Expanded(
                          child: Text(
                            homeController.userData.value.profileComunityName == null || homeController.userData.value.profileComunityName!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileComunityName!,
                            style: valueTextStyle,
                          ),
                        ),
                      ],
                    ),
                    // myDividerWidget(),
                  ],
                ),
                SizedBox(height: Get.width/30,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width/8,),
                  child: InkWell(
                    onTap: () {
                      Get.to(Editprofilepage());
                    },
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: ConstHelper.orangeColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: Get.width/30,),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: ConstHelper.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.width/20,),
              ],
            ),
          ),
        ),),
      ),
    );
  }


  TextStyle headingTextStyle = TextStyle(
    color: ConstHelper.blackColor,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  TextStyle titleTextStyle = TextStyle(
    color: ConstHelper.blackColor,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  TextStyle valueTextStyle = TextStyle(
    color: ConstHelper.cementColor,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  Widget threeDotWidget() => Padding(
    padding: EdgeInsets.only(right: Get.width/30,left: Get.width/90,),
    child: Text(
      ':',
      style: titleTextStyle,
    ),
  );

  Widget myDividerWidget() => Column(
    children: [
      SizedBox(height: Get.width/20,),
      Divider(color: ConstHelper.cementColor,),
      SizedBox(height: Get.width/20,),
    ],
  );
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Controllers/HomeController.dart';
import '../../Models/MembersDataModel.dart';
import '../../Utils/ApiHelper.dart';
import '../../Utils/ConstHelper.dart';
import 'package:url_launcher/url_launcher.dart';

class MembersDataShowPage extends StatefulWidget {
  const MembersDataShowPage({super.key});

  @override
  State<MembersDataShowPage> createState() => _MembersDataShowPageState();
}

class _MembersDataShowPageState extends State<MembersDataShowPage> {

  HomeController homeController = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile",style: TextStyle(fontSize: 20,color: ConstHelper.blackColor,fontWeight: FontWeight.bold,),),
          leading: IconButton(
            onPressed: () async {
              Get.back();
              await Future.delayed(const Duration(milliseconds: 300,),);
              homeController.advancedDrawerController.hideDrawer();
            },
            icon: Icon(Icons.arrow_back,size: Get.width/18,color: ConstHelper.orangeColor,),
          ),
          centerTitle: true,
          backgroundColor: ConstHelper.whiteColor,
          surfaceTintColor: ConstHelper.whiteColor,
          elevation: 10,
          shadowColor: ConstHelper.greyColor.withOpacity(0.1),
          // elevation: 3,
          // shadowColor: Colors.grey.shade50.withOpacity(0.3),
        ),
        backgroundColor: ConstHelper.whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width/20,),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.width/25,),
                  // Center(
                  //   child: Container(
                  //     height: Get.width/1.6,
                  //     width: Get.width/1.6,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(12),
                  //       gradient: LinearGradient(
                  //         begin: Alignment.topCenter,
                  //         end: Alignment.bottomCenter,
                  //         colors: [
                  //         colors: [
                  //           ConstHelper.blackColor.withOpacity(0.8),
                  //           ConstHelper.orangeColor.withOpacity(0.8),
                  //         ],
                  //       ),
                  //     ),
                  //     padding: EdgeInsets.all(Get.width/80),
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(9),
                  //       child: CachedNetworkImage(
                  //         imageUrl: homeController.selectedMembersData.value.profilePhoto == null || homeController.selectedMembersData.value.profilePhoto!.trim().isEmpty ? ConstHelper.noProfileImagePath : '${ConstHelper.userImagesPath}${homeController.selectedMembersData.value.profilePhoto!}',
                  //         fit: BoxFit.cover,
                  //         placeholder: (context, url) => Container(
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(9),
                  //             color: ConstHelper.whiteColor,
                  //           ),
                  //           alignment: Alignment.center,
                  //           child: CircularProgressIndicator(color: ConstHelper.orangeColor,),
                  //         ),
                  //         errorWidget: (context, url, error) => Container(
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(9),
                  //             color: ConstHelper.whiteColor,
                  //           ),
                  //           child: Image.asset(
                  //             'assets/image/imageNotFound.png',
                  //             fit: BoxFit.cover,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: Get.width/1.6,
                          width: Get.width/1.6,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            border: Border.all(color: ConstHelper.orangeColor,width: 3,),
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: homeController.selectedMembersData.value.profilePhoto == null || homeController.selectedMembersData.value.profilePhoto!.trim().isEmpty ? ConstHelper.profileImagePath : '${ConstHelper.userImagesPath}${homeController.selectedMembersData.value.profilePhoto!}',
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
                      ],
                    ),
                  ),
                  SizedBox(height: Get.width/30,),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ConstHelper.orangeColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: 0,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(onPressed: (){
                          ConstHelper.constHelper.showNetworkImageInDialog(imgPath: homeController.selectedMembersData.value.profilePhoto == null || homeController.selectedMembersData.value.profilePhoto!.trim().isEmpty ? '' : homeController.selectedMembersData.value.profilePhoto!,);
                        }, icon: Icon(Icons.photo_outlined,color: ConstHelper.whiteColor,size: Get.width/15,),),
                        IconButton(onPressed: () async {
                          try {
                            if(homeController.selectedMembersData.value.profileMobile != null || homeController.selectedMembersData.value.profileMobile!.trim().isNotEmpty)
                              {
                                Uri uri = Uri.parse('whatsapp://send?phone=+91 ${homeController.selectedMembersData.value.profileMobile}');
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(uri);
                                }
                                else {
                                  ConstHelper.errorDialog(text: ConstHelper.somethingErrorMsg, seconds: 10,);
                                }
                              }
                            else {
                              ConstHelper.errorDialog(text: ConstHelper.mobileNoNotAvailableMsg, seconds: 10,);
                            }
                          } catch(error) {
                            ConstHelper.errorDialog(text: ConstHelper.somethingErrorMsg, seconds: 10,);
                          }
                        }, icon: Image.asset('assets/image/whatsapp_outlined.png',color: ConstHelper.whiteColor,height: Get.width/15,width: Get.width/15,),),
                        IconButton(onPressed: () async {
                          EasyLoading.show(status: ConstHelper.pleaseWaitMsg,);
                          await Future.delayed(Duration(milliseconds: 200,),);
                          if(!(await ConstHelper.checkInternet()))
                          {
                            EasyLoading.dismiss();
                            ConstHelper.errorDialog(text: ConstHelper.internetMsg, seconds: 10,);
                          }
                          else if(homeController.profileShorted.value)
                          {
                            try {
                              await ApiHelper.apiHelper.unSetMyShortlistProfile(profileId: (homeController.selectedMembersData.value.id ?? 0).toString(),).then((data) async {
                                List<MembersDataModel> allShortlistedDataList = await ApiHelper.apiHelper.getAllShortlistedDataList();
                                homeController.profileShorted.value = allShortlistedDataList.where((element) => element.id == homeController.selectedMembersData.value.id,).toList().isNotEmpty;
                                if(data['code'] == 200)
                                  {
                                    homeController.allShortlistedDataList.value = await ApiHelper.apiHelper.getAllShortlistedDataList();
                                    EasyLoading.dismiss();
                                    ConstHelper.successDialog(text: data['msg'] ?? 'Profile Removed from Shortlist.', seconds: 10,);
                                  }
                                else
                                  {
                                    EasyLoading.dismiss();
                                    ConstHelper.errorDialog(text: data['msg'] ?? ConstHelper.somethingErrorMsg, seconds: 10,);
                                  }
                              },);
                            } catch(error) {
                              EasyLoading.dismiss();
                              ConstHelper.errorDialog(text: ConstHelper.somethingErrorMsg, seconds: 10,);
                            }
                          }
                          else
                          {
                            try {
                              await ApiHelper.apiHelper.setMyShortlistProfile(profileId: (homeController.selectedMembersData.value.id ?? 0).toString(),).then((data) async {
                                List<MembersDataModel> allShortlistedDataList = await ApiHelper.apiHelper.getAllShortlistedDataList();
                                homeController.profileShorted.value = allShortlistedDataList.where((element) => element.id == homeController.selectedMembersData.value.id,).toList().isNotEmpty;
                                if(data['code'] == 200)
                                {
                                  EasyLoading.dismiss();
                                  ConstHelper.successDialog(text: data['msg'] ?? 'Profile Shortlisted Successfully.', seconds: 10,);
                                }
                                else
                                {
                                  EasyLoading.dismiss();
                                  ConstHelper.errorDialog(text: data['msg'] ?? ConstHelper.somethingErrorMsg, seconds: 10,);
                                }
                              },);
                            } catch(error) {
                              EasyLoading.dismiss();
                              ConstHelper.errorDialog(text: ConstHelper.somethingErrorMsg, seconds: 10,);
                            }
                          }
                        }, icon: Icon(homeController.profileShorted.value ? Icons.star_rounded : Icons.star_border_rounded,color: ConstHelper.whiteColor,size: Get.width/11,),),
                       /* IconButton(onPressed: (){

                        }, icon: Icon(Icons.person_off_outlined,color: ConstHelper.whiteColor,size: Get.width/15,),),
                      */],
                    ),
                  ),
                  // Center(
                  //   child: Text(
                  //     homeController.selectedMembersData.value.name == null || homeController.selectedMembersData.value.name!.trim().isEmpty ? ConstHelper.nameNotAvailableMsg : homeController.selectedMembersData.value.name!,
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //       color: ConstHelper.blackColor,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  // ),
                  // Center(
                  //   child: Text.rich(
                  //     textAlign: TextAlign.center,
                  //     TextSpan(
                  //       children: [
                  //         TextSpan(
                  //           text: 'User ID : ',
                  //           style: TextStyle(
                  //             color: ConstHelper.blackColor,
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 14,
                  //           ),
                  //         ),
                  //         TextSpan(
                  //           text: homeController.selectedMembersData.value.token == null || homeController.selectedMembersData.value.token!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.token!,
                  //           style: TextStyle(
                  //             color: ConstHelper.orangeColor,
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 14,
                  //           ),
                  //         ),
                  //       ]
                  //     )
                  //   ),
                  // ),
                  SizedBox(height: Get.width/15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'User ID',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ConstHelper.blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                      Text(
                        homeController.selectedMembersData.value.id == null || homeController.selectedMembersData.value.id == 0 ? ConstHelper.naMsg : homeController.selectedMembersData.value.id!.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ConstHelper.blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Center(
                        child: Text(
                          homeController.selectedMembersData.value.name == null || homeController.selectedMembersData.value.name!.trim().isEmpty ? ConstHelper.nameNotAvailableMsg : homeController.selectedMembersData.value.name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ConstHelper.orangeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.width/20,),
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
                              homeController.selectedMembersData.value.profileDateOfBirth == null || homeController.selectedMembersData.value.profileDateOfBirth!.year <= 0 ? ConstHelper.naMsg : DateFormat('dd | MMM | yyyy').format(homeController.selectedMembersData.value.profileDateOfBirth!),
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
                              homeController.selectedMembersData.value.profileTimeOfBirth == null || homeController.selectedMembersData.value.profileTimeOfBirth!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.profileTimeOfBirth!,
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
                              homeController.selectedMembersData.value.profilePlaceOfBirth == null || homeController.selectedMembersData.value.profilePlaceOfBirth!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.profilePlaceOfBirth!,
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
                              homeController.selectedMembersData.value.profileHeight == null || homeController.selectedMembersData.value.profileHeight!.trim().isEmpty ? ConstHelper.naMsg : '${homeController.selectedMembersData.value.profileHeight![0]} ft ${homeController.selectedMembersData.value.profileHeight!.substring(1)} Inch',
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
                              homeController.selectedMembersData.value.profilePhysicalDisablity == null || homeController.selectedMembersData.value.profilePhysicalDisablity!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.profilePhysicalDisablity!,
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
                              homeController.selectedMembersData.value.profileEducation == null || homeController.selectedMembersData.value.profileEducation!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.profileEducation!,
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
                              homeController.selectedMembersData.value.profileOccupation == null || homeController.selectedMembersData.value.profileOccupation!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.profileOccupation!,
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
                              homeController.selectedMembersData.value.profileFatherFullName == null || homeController.selectedMembersData.value.profileFatherFullName!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.profileFatherFullName!,
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
                      //         'Mother Name',
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
                      // SizedBox(height: homeController.selectedMembersData.value.profileFatherFullName == null || homeController.selectedMembersData.value.profileFatherFullName!.trim().isEmpty ? 0 : Get.width/90,),
                      // homeController.selectedMembersData.value.profileFatherFullName == null || homeController.selectedMembersData.value.profileFatherFullName!.trim().isEmpty ? SizedBox() : Row(
                      //   // crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       child: Text(
                      //         homeController.selectedMembersData.value.profileFatherFullName!,
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
                      // // SizedBox(height: Get.width/90,),
                      // // Row(
                      // //   // crossAxisAlignment: CrossAxisAlignment.start,
                      // //   children: [
                      // //     Expanded(
                      // //       child: Text(
                      // //         'Suman Khautan',
                      // //         style: titleTextStyle,
                      // //       ),
                      // //     ),
                      // //     threeDotWidget(),
                      // //     Expanded(
                      // //       child: Text(
                      // //         '1213243567',
                      // //         style: valueTextStyle,
                      // //       ),
                      // //     ),
                      // //   ],
                      // // ),
                      // SizedBox(height: Get.width/90,),
                      // Row(
                      //   // crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       child: Text(
                      //         'Brother',
                      //         style: titleTextStyle,
                      //       ),
                      //     ),
                      //     threeDotWidget(),
                      //     Expanded(
                      //       child: Text.rich(
                      //         TextSpan(
                      //           children: [
                      //             TextSpan(
                      //               text: 'M-${ConstHelper.naMsg}',
                      //               style: valueTextStyle,
                      //             ),
                      //             TextSpan(
                      //               text: '      ',
                      //               style: valueTextStyle,
                      //             ),
                      //             TextSpan(
                      //               text: 'Un M-${ConstHelper.naMsg}',
                      //               style: valueTextStyle,
                      //             ),
                      //           ]
                      //         )
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
                      //         'Sister',
                      //         style: titleTextStyle,
                      //       ),
                      //     ),
                      //     threeDotWidget(),
                      //     Expanded(
                      //       child: Text.rich(
                      //         TextSpan(
                      //           children: [
                      //             TextSpan(
                      //               text: 'M-${ConstHelper.naMsg}',
                      //               style: valueTextStyle,
                      //             ),
                      //             TextSpan(
                      //               text: '      ',
                      //               style: valueTextStyle,
                      //             ),
                      //             TextSpan(
                      //               text: 'Un M-${ConstHelper.naMsg}',
                      //               style: valueTextStyle,
                      //             ),
                      //           ]
                      //         )
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: Get.width/90,),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Current Address (Rent - 5yrs)',
                              style: titleTextStyle,
                            ),
                          ),
                          threeDotWidget(),
                          Expanded(
                            child: Text(
                              homeController.selectedMembersData.value.profilePermanentAddress == null || homeController.selectedMembersData.value.profilePermanentAddress!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.profilePermanentAddress!,
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
                              'Native Place',
                              style: titleTextStyle,
                            ),
                          ),
                          threeDotWidget(),
                          Expanded(
                            child: Text(
                              ConstHelper.naMsg,
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
                              homeController.selectedMembersData.value.profileComunityName == null || homeController.selectedMembersData.value.profileComunityName!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.profileComunityName!,
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
                              'Gotra',
                              style: titleTextStyle,
                            ),
                          ),
                          threeDotWidget(),
                          Expanded(
                            child: Text(
                              homeController.selectedMembersData.value.profileGotra == null || homeController.selectedMembersData.value.profileGotra!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.profileGotra!,
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
                              homeController.selectedMembersData.value.profileRefContactName == null || homeController.selectedMembersData.value.profileRefContactName!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.profileRefContactName!,
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
                              'Reference Mobile No',
                              style: titleTextStyle,
                            ),
                          ),
                          threeDotWidget(),
                          Expanded(
                            child: Text(
                              homeController.selectedMembersData.value.profileRefContactMobile == null || homeController.selectedMembersData.value.profileRefContactMobile!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.profileRefContactMobile!,
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
                              homeController.selectedMembersData.value.profileMainContactNum == null || homeController.selectedMembersData.value.profileMainContactNum!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.profileMainContactNum!,
                              style: valueTextStyle,
                            ),
                          ),
                        ],
                      ),
                      myDividerWidget(),
                    ],
                  ),
                  // SizedBox(height: Get.width/60,),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         SvgPicture.asset('assets/image/kundaliSVG.svg',height: Get.width/25,width: Get.width/25,color: ConstHelper.blackColor,),
                  //         SizedBox(width: Get.width/30,),
                  //         Flexible(
                  //           child: Text(
                  //             'Kundali',
                  //             style: headingTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: Get.width/20,),
                  //     Row(
                  //       // crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Expanded(
                  //           child: Text(
                  //             'Gotra',
                  //             style: titleTextStyle,
                  //           ),
                  //         ),
                  //         threeDotWidget(),
                  //         Expanded(
                  //           child: Text(
                  //             homeController.selectedMembersData.value.profileGotra == null || homeController.selectedMembersData.value.profileGotra!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.profileGotra!,
                  //             style: valueTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: Get.width/90,),
                  //     Row(
                  //       // crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Expanded(
                  //           child: Text(
                  //             'Matching Janampatri',
                  //             style: titleTextStyle,
                  //           ),
                  //         ),
                  //         threeDotWidget(),
                  //         Expanded(
                  //           child: Text(
                  //             ConstHelper.naMsg,
                  //             style: valueTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: Get.width/90,),
                  //     Row(
                  //       // crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Expanded(
                  //           child: Text(
                  //             'Marry in Same Gotra',
                  //             style: titleTextStyle,
                  //           ),
                  //         ),
                  //         threeDotWidget(),
                  //         Expanded(
                  //           child: Text(
                  //             ConstHelper.naMsg,
                  //             style: valueTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: Get.width/90,),
                  //     Row(
                  //       // crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Expanded(
                  //           child: Text(
                  //             'Are you Manglik',
                  //             style: titleTextStyle,
                  //           ),
                  //         ),
                  //         threeDotWidget(),
                  //         Expanded(
                  //           child: Text(
                  //             ConstHelper.naMsg,
                  //             style: valueTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: Get.width/90,),
                  //     Row(
                  //       // crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Expanded(
                  //           child: Text(
                  //             'Will you Marry Manglik',
                  //             style: titleTextStyle,
                  //           ),
                  //         ),
                  //         threeDotWidget(),
                  //         Expanded(
                  //           child: Text(
                  //             ConstHelper.naMsg,
                  //             style: valueTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     myDividerWidget(),
                  //   ],
                  // ),
                  // SizedBox(height: Get.width/60,),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         SvgPicture.asset('assets/image/partnerSVG.svg',height: Get.width/25,width: Get.width/25,color: ConstHelper.blackColor,),
                  //         SizedBox(width: Get.width/30,),
                  //         Flexible(
                  //           child: Text(
                  //             'Partner Preference',
                  //             style: headingTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: Get.width/20,),
                  //     Row(
                  //       // crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Expanded(
                  //           child: Text(
                  //             'P. Spouse Can Be',
                  //             style: titleTextStyle,
                  //           ),
                  //         ),
                  //         threeDotWidget(),
                  //         Expanded(
                  //           child: Text(
                  //             ConstHelper.naMsg,
                  //             style: valueTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: Get.width/90,),
                  //     Row(
                  //       // crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Expanded(
                  //           child: Text(
                  //             'P. Spouse Can Be',
                  //             style: titleTextStyle,
                  //           ),
                  //         ),
                  //         threeDotWidget(),
                  //         Expanded(
                  //           child: Text(
                  //             ConstHelper.naMsg,
                  //             style: valueTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: Get.width/90,),
                  //     Row(
                  //       // crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Expanded(
                  //           child: Text(
                  //             'Desired Edu. of P. Spouse',
                  //             style: titleTextStyle,
                  //           ),
                  //         ),
                  //         threeDotWidget(),
                  //         Expanded(
                  //           child: Text(
                  //             ConstHelper.naMsg,
                  //             style: valueTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: Get.width/90,),
                  //     Row(
                  //       // crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Expanded(
                  //           child: Text(
                  //             'Bride Permitted To Work After Marriage',
                  //             style: titleTextStyle,
                  //           ),
                  //         ),
                  //         threeDotWidget(),
                  //         Expanded(
                  //           child: Text(
                  //             ConstHelper.naMsg,
                  //             style: valueTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: Get.width/90,),
                  //     Row(
                  //       // crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Expanded(
                  //           child: Text(
                  //             'Current City',
                  //             style: titleTextStyle,
                  //           ),
                  //         ),
                  //         threeDotWidget(),
                  //         Expanded(
                  //           child: Text(
                  //             ConstHelper.naMsg,
                  //             style: valueTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: Get.width/90,),
                  //     Row(
                  //       // crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Expanded(
                  //           child: Text(
                  //             'Resident After Marriage',
                  //             style: titleTextStyle,
                  //           ),
                  //         ),
                  //         threeDotWidget(),
                  //         Expanded(
                  //           child: Text(
                  //             ConstHelper.naMsg,
                  //             style: valueTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     myDividerWidget(),
                  //   ],
                  // ),
                  SizedBox(height: Get.width/60,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/image/aboutMeRoundedSVG.svg',height: Get.width/25,width: Get.width/25,color: ConstHelper.blackColor,),
                          SizedBox(width: Get.width/30,),
                          Flexible(
                            child: Text(
                              'Important Note',
                              style: headingTextStyle,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.width/20,),
                      Text(
                        homeController.selectedMembersData.value.profileNote == null || homeController.selectedMembersData.value.profileNote!.trim().isEmpty ? ConstHelper.naMsg : homeController.selectedMembersData.value.profileNote!,
                        style: valueTextStyle,
                      ),
                      // myDividerWidget(),
                    ],
                  ),
                  // SizedBox(height: Get.width/60,),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         SvgPicture.asset('assets/image/ruppeSVG.svg',height: Get.width/25,width: Get.width/25,color: ConstHelper.blackColor,),
                  //         SizedBox(width: Get.width/30,),
                  //         Flexible(
                  //           child: Text(
                  //             'Budget Info',
                  //             style: headingTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: Get.width/20,),
                  //     Row(
                  //       // crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Expanded(
                  //           child: Text(
                  //             'Budget',
                  //             style: titleTextStyle,
                  //           ),
                  //         ),
                  //         threeDotWidget(),
                  //         Expanded(
                  //           child: Text(
                  //             ConstHelper.naMsg,
                  //             style: valueTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: Get.width/20,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SvgPicture.asset('assets/image/yagnArrowLeftSVG.svg',height: Get.width/30,width: Get.width/30,),
                  //     SizedBox(width: Get.width/30,),
                  //     SvgPicture.asset('assets/image/yagnSVG.svg',height: Get.width/4,width: Get.width/4,),
                  //     SizedBox(width: Get.width/30,),
                  //     SvgPicture.asset('assets/image/yagnArrowRightSVG.svg',height: Get.width/30,width: Get.width/30,),
                  //   ],
                  // ),
                  SizedBox(height: Get.width/20,),
                ],
              ),
            ),
          ),
        ),
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

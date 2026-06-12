import 'dart:developer';

import 'package:age_calculator/age_calculator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controllers/HomeController.dart';

import '../../Models/MembersDataModel.dart';
import '../AboutUsScreen/AboutUsPage.dart';
import '../FeedbackScreen/FeedbackPage.dart';
import '../LoginScreen/LoginPage.dart';

import '../../Utils/ApiHelper.dart';
import '../../Utils/ConstHelper.dart';
import '../../Utils/SharedPrefHelper.dart';
import '../MyProfileScreen/MyProfilePage.dart';
import '../MyShortlistedScreen/MyShortlistedPage.dart';
import '../SettingsScreen/SettingsPage.dart';
import 'MembersDataShowPage.dart';

RxBool maleFemale = true.obs;
RxInt totalMaleMembers = 0.obs;
RxInt totalFemaleMembers = 0.obs;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());
  RxBool startLoad = true.obs;
  RxBool searchClick = false.obs;
  RxBool searchStart = false.obs;
  FocusNode searchFocusNode = FocusNode();
  TextEditingController txtSearch = TextEditingController();
  RxList<MembersDataModel> searchedMembersDataListGenderWise =
      <MembersDataModel>[].obs;
  List<String> educationSelected = [];

  Future<void> getAllMembersData() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    homeController.selectedGotra.value = prefs.getString("gotra") ?? "";
    homeController.yearlyIncomeStart.value = double.parse(prefs.getString("yearlyIncomeStart") ?? "1");
    homeController.yearlyIncomeEnd.value = double.parse(prefs.getString("yearlyIncomeEnd") ?? "300");
    homeController.selectedAgeStart.value = double.parse(prefs.getString("selectedAgeStart") ?? "18");
    homeController.selectedAgeEnd.value = double.parse(prefs.getString("selectedAgeEnd") ?? "50");
    homeController.selectedMaxHeightValue.value = prefs.getString("selectedMaxHeightValue") ?? "7";
    homeController.selectedMinHeightValue.value = prefs.getString("selectedMinHeightValue") ?? "4";
    homeController.marriedBeforeStatus.value = prefs.getString("marriedBeforeStatus") ?? "All";
    homeController.maglikStatus.value = prefs.getString("maglikStatus") ?? "All";
    homeController.selectAll.value = prefs.getString("selectAll") == "true" ? true: prefs.getString("selectAll") == "false" ? false : true;
    educationSelected = await prefs.getStringList("eductionSelected") ?? [];
    print(educationSelected.length);
    homeController.educationDataList.value = await ApiHelper.apiHelper.getEducationDataList();
    print(homeController.educationDataList.length);
    if(educationSelected.isEmpty){
      for (int i = 0; i < homeController.educationDataList.length; i++) {
        homeController.educationDataList[i]['selected'] = true;
        print(homeController.educationDataList[i]['selected']);
      }
    } else if (homeController.educationDataList.length == educationSelected.length) {
      for (int i = 0; i < homeController.educationDataList.length; i++) {
        homeController.educationDataList[i]['selected'] =
            educationSelected[i].toLowerCase() == "true";
        print(homeController.educationDataList[i]['selected']);
      }
    } else {
      print("Error: Mismatched list lengths. Ensure both lists have the same size.");
    }
    startLoad.value = true;
    txtSearch.clear();
    searchFocusNode.unfocus();
    searchClick.value = false;
    searchStart.value = false;
    try {
      List<String> educationCategory = [];
      for(int i = 0; i < homeController.educationDataList.length; i++){
        print(homeController.educationDataList[i]['selected']);
        if(homeController.educationDataList[i]['selected'] == true){
          educationCategory.add(homeController.educationDataList[i]['education_name'] ?? 'N/A');
        }
      }
      List<MembersDataModel> allMembersDataList = await ApiHelper.apiHelper
          .getAllMembersDataList(
          heightFrom: homeController.selectedMinHeightValue.value.toString().split(".")[0].toString(),
          heightTo: homeController.selectedMaxHeightValue.value.toString().split(".")[0].toString(),
          educationCategory: educationCategory,
          haveMarriedBefore: homeController.marriedBeforeStatus.value.toLowerCase(),
          ageFrom: homeController.selectedAgeStart.value.toStringAsFixed(0),
          ageTo: homeController.selectedAgeEnd.value.toStringAsFixed(0),
          excludeGotra: homeController.selectedGotra.value);
      print('adasd ${allMembersDataList.length}');
      print('adasd ${homeController.userData.value.profileType?.toString()}');
      if(homeController.userData.value.profileType?.toString() == "1") {
        homeController.allMembersDataListGenderWise.value = allMembersDataList
          .where(
            (element) =>
            element.profileGender.toString().trim().toLowerCase() == (homeController.userData.value.profileGender?.toString().trim().toLowerCase() == "Female".toLowerCase() ? 'Male'.trim().toLowerCase() : 'Female'.trim().toLowerCase()),
          )
          .toList();
        print(homeController.allMembersDataListGenderWise.length);
      }else {
        homeController.allMembersDataListGenderWise.value = allMembersDataList
            .where(
              (element) =>
          element.profileGender.toString().trim().toLowerCase() == (maleFemale.value
                  ? 'Male'.trim().toLowerCase()
                  : 'Female'.trim().toLowerCase()),
        )
            .toList();
        totalMaleMembers.value = allMembersDataList
            .where(
              (element) =>
          element.profileGender.toString().trim().toLowerCase() ==
              'Male'.trim().toLowerCase(),
        )
            .toList()
            .length;
        totalFemaleMembers.value = allMembersDataList
            .where(
              (element) =>
          element.profileGender.toString().trim().toLowerCase() ==
              'Female'.trim().toLowerCase(),
        )
            .toList()
            .length;
      }
      startLoad.value = false;
    } catch (error) {
      homeController.allMembersDataListGenderWise.value = [];
      startLoad.value = false;
    }

    startLoad.value = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllMembersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          color: ConstHelper.blackColor,
        ),
        controller: homeController.advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        drawer: Padding(
          padding: EdgeInsets.fromLTRB(
            Get.width / 30,
            Get.width / 15,
            Get.width / 30,
            Get.width / 30,
          ),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/image/drawerWhiteSVG.svg',
                    height: Get.width / 18,
                    width: Get.width / 18,
                  ),
                  SizedBox(
                    height: Get.width / 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: Get.width / 4,
                        width: Get.width / 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              ConstHelper.orangeColor,
                              ConstHelper.orangeColor.withOpacity(0.9),
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(Get.width / 70),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: homeController.userData.value.profilePhoto ==
                                        null ||
                                    homeController.userData.value.profilePhoto!
                                        .trim()
                                        .isEmpty
                                ? ConstHelper.profileImagePath
                                : '${ConstHelper.userImagesPath}${homeController.userData.value.profilePhoto!}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ConstHelper.whiteColor,
                              ),
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: Get.width / 20,
                                width: Get.width / 20,
                                child: CircularProgressIndicator(
                                  color: ConstHelper.orangeColor,
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
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
                      SizedBox(
                        width: Get.width / 30,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'User ID : ',
                                  style: TextStyle(
                                    color: ConstHelper.whiteColor,
                                    fontSize: Get.width*0.035,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    homeController.userData.value.id == null ||
                                        homeController.userData.value.id! <= 0
                                        ? ConstHelper.naMsg
                                        : homeController.userData.value.id.toString(),
                                    style: TextStyle(
                                      color: ConstHelper.orangeColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: Get.width*0.035,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height: Get.width/90,),
                            Text(
                              homeController.userData.value.name == null ||
                                  homeController.userData.value.name!.trim().isEmpty
                                  ? ConstHelper.nameNotAvailableMsg
                                  : homeController.userData.value.name!.trim(),
                              style: TextStyle(
                                color: ConstHelper.whiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: Get.width*0.035,
                              ),
                            ),
                            // Text(
                            //   homeController.userData.value.email == null ||
                            //       homeController.userData.value.email!.trim().isEmpty
                            //       ? ConstHelper.emailNotAvailableMsg
                            //       : homeController.userData.value.email!.trim(),
                            //   style: TextStyle(
                            //     color: ConstHelper.whiteColor,
                            //   ),
                            // ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Contact : ',
                                  style: TextStyle(
                                    color: ConstHelper.whiteColor,
                                    fontSize: Get.width * 0.035,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    homeController.userData.value
                                        .profileMainContactNum ==
                                        null ||
                                        homeController.userData.value
                                            .profileMainContactNum!
                                            .trim()
                                            .isEmpty
                                        ? ConstHelper.naMsg
                                        : homeController.userData.value
                                        .profileMainContactNum!
                                        .trim(),
                                    style: TextStyle(
                                      color: ConstHelper.whiteColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: Get.width * 0.035,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),                  
                  SizedBox(
                    height: Get.width / 60,
                  ),
                  Divider(
                    color: ConstHelper.greyColor,
                  ),
                  SizedBox(
                    height: Get.width / 20,
                  ),
                  InkWell(
                    onTap: () {
                      homeController.advancedDrawerController.hideDrawer();
                    },
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/image/homeSVG.svg',
                          height: Get.width / 20,
                          width: Get.width / 20,
                          fit: BoxFit.contain,
                          color: ConstHelper.whiteColor,
                        ),
                        SizedBox(
                          width: Get.width / 30,
                        ),
                        Flexible(
                          child: Text(
                            'Home',
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                              fontSize: Get.width*0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.width / 20,
                  ),
                  InkWell(
                    onTap: () async {
                      homeController.userData.value = (await ApiHelper.apiHelper.fetchProfile())!;
                      Get.to(
                        const MyProfilePage(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/image/personSVG.svg',
                          height: Get.width / 20,
                          width: Get.width / 20,
                          fit: BoxFit.contain,
                          color: ConstHelper.whiteColor,
                        ),
                        SizedBox(
                          width: Get.width / 30,
                        ),
                        Flexible(
                          child: Text(
                            'My Profile',
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                              fontSize: Get.width*0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.width / 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        const MyShortlistedPage(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/image/shortlistedSVG.svg',
                          height: Get.width / 20,
                          width: Get.width / 20,
                          fit: BoxFit.contain,
                          color: ConstHelper.whiteColor,
                        ),
                        SizedBox(
                          width: Get.width / 30,
                        ),
                        Flexible(
                          child: Text(
                            'My Shortlisted',
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                              fontSize: Get.width*0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: Get.width/20,),
                  // Row(
                  //   // crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     SvgPicture.asset('assets/image/eventSVG.svg',height: Get.width/20,width: Get.width/20,fit: BoxFit.contain,color: ConstHelper.whiteColor,),
                  //     SizedBox(width: Get.width/30,),
                  //     Flexible(
                  //       child: Text(
                  //         'Events',
                  //         style: TextStyle(
                  //           color: ConstHelper.whiteColor,
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: Get.width / 20,
                  ),
                  InkWell(
                    onTap: () async {
                      EasyLoading.show(
                        status: ConstHelper.pleaseWaitMsg,
                      );
                      await Future.delayed(
                        Duration(
                          milliseconds: 200,
                        ),
                      );
                      if (!(await ConstHelper.checkInternet())) {
                        EasyLoading.dismiss();
                        ConstHelper.errorDialog(
                          text: ConstHelper.internetMsg,
                          seconds: 10,
                        );
                      } else {
                        try {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          homeController.selectedGotra.value = prefs.getString("gotra") ?? "";
                          homeController.yearlyIncomeStart.value = double.parse(prefs.getString("yearlyIncomeStart") ?? "1.0");
                          homeController.yearlyIncomeEnd.value = double.parse(prefs.getString("yearlyIncomeEnd") ?? "300.0");
                          homeController.selectedAgeStart.value = double.parse(prefs.getString("selectedAgeStart") ?? "18");
                          homeController.selectedAgeEnd.value = double.parse(prefs.getString("selectedAgeEnd") ?? "50");
                          homeController.selectedMaxHeightValue.value = prefs.getString("selectedMaxHeightValue") ?? "7.0";
                          homeController.selectedMinHeightValue.value = prefs.getString("selectedMinHeightValue") ?? "4.0";
                          homeController.marriedBeforeStatus.value = prefs.getString("marriedBeforeStatus") ?? "All";
                          homeController.maglikStatus.value = prefs.getString("maglikStatus") ?? "All";
                          homeController.selectAll.value = prefs.getString("selectAll") == "true" ? true: prefs.getString("selectAll") == "false" ? false : true;
                          educationSelected = await prefs.getStringList("eductionSelected") ?? [];
                          homeController.educationDataList.value = await ApiHelper.apiHelper.getEducationDataList();
                          print(homeController.educationDataList.length);
                          if(educationSelected.isEmpty){
                            for (int i = 0; i < homeController.educationDataList.length; i++) {
                              homeController.educationDataList[i]['selected'] = true;
                              print(homeController.educationDataList[i]['selected']);
                            }
                          } else if (homeController.educationDataList.length == educationSelected.length) {
                            for (int i = 0; i < homeController.educationDataList.length; i++) {
                              homeController.educationDataList[i]['selected'] =
                                  educationSelected[i].toLowerCase() == "true";
                              print(homeController.educationDataList[i]['selected']);
                            }
                          } else {
                            print("Error: Mismatched list lengths. Ensure both lists have the same size.");
                          }
                          homeController.gotraDataList.clear();
                          homeController.gotraDataList.add("-- Select Gotra --");
                          await ApiHelper.apiHelper.getGotraDataList().then((value) {
                            homeController.gotraDataList.addAll(value);
                          },);
                          homeController.selectedGotra.value = "-- Select Gotra --";
                          print(homeController.gotraDataList.toString());
                          Get.to(
                            const SettingsPage(),
                            transition: Transition.rightToLeft,
                          );
                          EasyLoading.dismiss();
                        } catch (error) {
                          EasyLoading.dismiss();
                          ConstHelper.errorDialog(
                            text: ConstHelper.somethingErrorMsg,
                            seconds: 10,
                          );
                        }
                      }
                    },
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/image/settingsSVG.svg',
                          height: Get.width / 20,
                          width: Get.width / 20,
                          fit: BoxFit.contain,
                          color: ConstHelper.whiteColor,
                        ),
                        SizedBox(
                          width: Get.width / 30,
                        ),
                        Flexible(
                          child: Text(
                            'Settings',
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                              fontSize: Get.width*0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.width / 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        const FeedbackPage(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/image/feedbackSVG.svg',
                          height: Get.width / 20,
                          width: Get.width / 20,
                          fit: BoxFit.contain,
                          color: ConstHelper.whiteColor,
                        ),
                        SizedBox(
                          width: Get.width / 30,
                        ),
                        Flexible(
                          child: Text(
                            'Feedback',
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                              fontSize: Get.width*0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.width / 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        const AboutUsPage(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/image/aboutUsSVG.svg',
                          height: Get.width / 20,
                          width: Get.width / 20,
                          fit: BoxFit.contain,
                          color: ConstHelper.whiteColor,
                        ),
                        SizedBox(
                          width: Get.width / 30,
                        ),
                        Flexible(
                          child: Text(
                            'About Us',
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                              fontSize: Get.width*0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.width / 20,
                  ),
                  InkWell(
                    onTap: () {
                      ConstHelper.constHelper.areYouSureWantAlertDialog(
                        title: 'Log out now?',
                        description: 'Would you like to proceed with logging out?',
                        onPressed: () {
                          Get.back();
                          SharedPrefHelper.sharedPreferences.setBool(
                            'login',
                            false,
                          );
                          Get.off(
                            LoginPage(),
                          );
                        },
                      );
                    },
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/image/logoutSVG.svg',
                          height: Get.width / 20,
                          width: Get.width / 20,
                          fit: BoxFit.contain,
                          color: ConstHelper.whiteColor,
                        ),
                        SizedBox(
                          width: Get.width / 30,
                        ),
                        Flexible(
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                              fontSize: Get.width*0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.width / 20,
                  ),
                ],
              ),
            ],
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                if (searchClick.value) {
                  txtSearch.clear();
                  searchFocusNode.unfocus();
                  searchClick.value = false;
                  searchStart.value = false;
                } else {
                  homeController.advancedDrawerController.showDrawer();
                }
              },
              icon: Obx(() => searchClick.value
                  ? Icon(
                      Icons.arrow_back_ios_rounded,
                      size: Get.width / 15,
                      color: ConstHelper.orangeColor,
                    )
                  : SvgPicture.asset(
                      'assets/image/drawerIconSVG.svg',
                      height: Get.width / 18,
                      width: Get.width / 18,
                    )),
            ),
            title: Obx(
              () => searchClick.value
                  ? TextField(
                      focusNode: searchFocusNode,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: ConstHelper.greyColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: ConstHelper.greyColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: ConstHelper.greyColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Get.width / 30,
                        ),
                        hintText: 'Search....',
                        hintStyle: TextStyle(
                          color: ConstHelper.greyColor.withOpacity(0.7),
                        ),
                      ),
                      onChanged: (value) {
                        searchStart.value = value.trim().isNotEmpty;
                        if (value.trim().isNotEmpty) {
                          searchedMembersDataListGenderWise.value =
                              homeController.allMembersDataListGenderWise.where(
                            (p0) {
                              String dob = p0.profileDateOfBirth == null ||
                                      p0.profileDateOfBirth!.year <= 0
                                  ? ''
                                  : DateFormat('dd | MMM | yyyy')
                                      .format(p0.profileDateOfBirth!);
                              return p0.id
                                      .toString()
                                      .trim()
                                      .toLowerCase()
                                      .contains(value.trim().toLowerCase()) ||
                                  p0.name
                                      .toString()
                                      .trim()
                                      .toLowerCase()
                                      .contains(value.trim().toLowerCase()) ||
                                  p0.profileFatherFullName
                                      .toString()
                                      .trim()
                                      .toLowerCase()
                                      .contains(value.trim().toLowerCase()) ||
                                  dob
                                      .trim()
                                      .toLowerCase()
                                      .contains(value.trim().toLowerCase()) ||
                                  p0.profileEducation
                                      .toString()
                                      .trim()
                                      .toLowerCase()
                                      .contains(value.trim().toLowerCase()) ||
                                  p0.profileWorkingCity
                                      .toString()
                                      .trim()
                                      .toLowerCase()
                                      .contains(value.trim().toLowerCase()) ||
                                  p0.profilePermanentAddress
                                      .toString()
                                      .trim()
                                      .toLowerCase()
                                      .contains(value.trim().toLowerCase());
                            },
                          ).toList();
                        }
                      },
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "PP".tr,
                          style: TextStyle(
                            fontSize: Get.width*0.05,
                            color: ConstHelper.orangeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " Milan".tr,
                          style: TextStyle(
                            fontSize: Get.width*0.05,
                            color: ConstHelper.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
            ),
            centerTitle: true,
            backgroundColor: ConstHelper.whiteColor,
            surfaceTintColor: ConstHelper.whiteColor,
            elevation: 10,
            shadowColor: ConstHelper.greyColor.withOpacity(0.1),
            actions: [
              IconButton(
                onPressed: () {
                  if (searchClick.value) {
                    txtSearch.clear();
                    searchFocusNode.unfocus();
                    searchStart.value = false;
                  } else {
                    searchFocusNode.requestFocus();
                  }

                  searchClick.value = !searchClick.value;
                },
                icon: Obx(() => searchClick.value
                    ? Icon(
                        Icons.close_rounded,
                        size: Get.width / 15,
                        color: ConstHelper.orangeColor,
                      )
                    : SvgPicture.asset(
                        'assets/image/searchIconSVG.svg',
                        height: Get.width / 18,
                        width: Get.width / 18,
                      )),
              ),
            ],
            // elevation: 3,
            // shadowColor: Colors.grey.shade50.withOpacity(0.3),
          ),
          backgroundColor: ConstHelper.whiteColor,
          body: RefreshIndicator(
            onRefresh: () async {
              await getAllMembersData();
            },
            color: ConstHelper.orangeColor,
            backgroundColor: ConstHelper.whiteColor,
            child: Obx(
              () => startLoad.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: ConstHelper.orangeColor,
                      ),
                    )
                  : searchStart.value
                      ? searchedMembersDataListGenderWise.isEmpty
                          ? ListView(
                              children: [
                                SizedBox(
                                  height: Get.height / 2.5,
                                ),
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Oops! No data found. Try again later or contact admin.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ConstHelper.orangeDarkColor,
                                            fontSize: Get.width * 0.05,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount:
                                  searchedMembersDataListGenderWise.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    EasyLoading.show(
                                      status: ConstHelper.pleaseWaitMsg,
                                    );
                                    await Future.delayed(
                                      Duration(
                                        milliseconds: 200,
                                      ),
                                    );
                                    if (!(await ConstHelper.checkInternet())) {
                                      EasyLoading.dismiss();
                                      ConstHelper.errorDialog(
                                        text: ConstHelper.internetMsg,
                                        seconds: 10,
                                      );
                                    } else {
                                      homeController.selectedMembersData.value =
                                      searchedMembersDataListGenderWise[
                                      index];
                                      List<MembersDataModel>
                                      allShortlistedDataList =
                                      await ApiHelper.apiHelper
                                          .getAllShortlistedDataList();
                                      homeController.profileShorted.value =
                                          allShortlistedDataList
                                              .where(
                                                (element) =>
                                            element.id ==
                                                homeController
                                                    .selectedMembersData
                                                    .value
                                                    .id,
                                          )
                                              .toList()
                                              .isNotEmpty;
                                      homeController.selectedMembersData.value = await ApiHelper.apiHelper
                                          .getSelectedembersDataList(id: searchedMembersDataListGenderWise[index].id.toString());
                                      Get.to(
                                        MembersDataShowPage(),
                                        transition: Transition.fadeIn,
                                      );
                                      EasyLoading.dismiss();
                                    }

                                  },
                                  child: Container(
                                    width: Get.width,
                                    margin: EdgeInsets.fromLTRB(
                                      Get.width / 30,
                                      index == 0
                                          ? Get.width / 15
                                          : Get.width / 23,
                                      Get.width / 30,
                                      searchedMembersDataListGenderWise
                                                  .length !=
                                              (index + 1)
                                          ? 0
                                          : Get.width / 30,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ConstHelper.whiteColor,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ConstHelper.greyColor
                                              .withOpacity(0.1),
                                          offset: const Offset(0, 4),
                                          blurRadius: 2,
                                        ),
                                        BoxShadow(
                                          color: ConstHelper.greyColor
                                              .withOpacity(0.05),
                                          offset: const Offset(0, -1),
                                          blurRadius: 2,
                                        ),
                                      ],
                                      border: Border.all(
                                        width: 0.3,
                                        color: ConstHelper.greyColor
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: Get.width / 30,
                                    ),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 2,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ConstHelper.orangeColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width / 30,
                                                ),
                                                IntrinsicHeight(
                                                  child: Container(
                                                    width: Get.width / 5,
                                                    height: Get.width / 5,
                                                    decoration: BoxDecoration(
                                                      color: ConstHelper
                                                          .whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.5),
                                                      border: Border.all(
                                                        color: ConstHelper
                                                            .greyColor
                                                            .withOpacity(0.3),
                                                      ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      child: CachedNetworkImage(
                                                        imageUrl: searchedMembersDataListGenderWise[
                                                                            index]
                                                                        .profilePhoto ==
                                                                    null ||
                                                                searchedMembersDataListGenderWise[
                                                                        index]
                                                                    .profilePhoto!
                                                                    .trim()
                                                                    .isEmpty
                                                            ? ConstHelper
                                                                .profileImagePath
                                                            : '${ConstHelper.userImagesPath}${searchedMembersDataListGenderWise[index].profilePhoto!}',
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (context, url) =>
                                                                Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            color: ConstHelper
                                                                .whiteColor,
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: SizedBox(
                                                            height:
                                                                Get.width / 20,
                                                            width:
                                                                Get.width / 20,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: ConstHelper
                                                                  .orangeColor,
                                                              strokeWidth: 2,
                                                            ),
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            color: ConstHelper
                                                                .whiteColor,
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
                                                SizedBox(
                                                  width: Get.width / 30,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${searchedMembersDataListGenderWise[index].id == null || searchedMembersDataListGenderWise[index].id == 0 ? 'Id not available' : searchedMembersDataListGenderWise[index].id!} - ${searchedMembersDataListGenderWise[index].name == null || searchedMembersDataListGenderWise[index].name!.trim().isEmpty ? ConstHelper.nameNotAvailableMsg : searchedMembersDataListGenderWise[index].name}',
                                                        style: TextStyle(
                                                          color: ConstHelper
                                                              .orangeDarkColor,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize:
                                                          Get.width * 0.04,
                                                        ),
                                                      ),
                                                      // Text(
                                                      //   searchedMembersDataListGenderWise[
                                                      //                       index]
                                                      //                   .profileFatherFullName ==
                                                      //               null ||
                                                      //           searchedMembersDataListGenderWise[
                                                      //                   index]
                                                      //               .profileFatherFullName!
                                                      //               .trim()
                                                      //               .isEmpty
                                                      //       ? ConstHelper
                                                      //           .fatherNameNotAvailableMsg
                                                      //       : searchedMembersDataListGenderWise[
                                                      //               index]
                                                      //           .profileFatherFullName!,
                                                      //   style: TextStyle(
                                                      //     color: ConstHelper
                                                      //         .greyColor,
                                                      //     fontWeight:
                                                      //         FontWeight.w500,
                                                      //     fontSize: 12,
                                                      //   ),
                                                      // ),
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'DOB : ',
                                                                style:
                                                                    TextStyle(
                                                                      color: ConstHelper
                                                                          .blackColor,
                                                                      fontSize:
                                                                      Get.width *
                                                                          0.035,
                                                                ),
                                                              ),
                                                              Text(
                                                                searchedMembersDataListGenderWise[index].profileDateOfBirth ==
                                                                            null ||
                                                                        searchedMembersDataListGenderWise[index].profileDateOfBirth!.year <=
                                                                            0
                                                                    ? 'N/A'
                                                                    : DateFormat(
                                                                            'dd | MMM | yyyy')
                                                                        .format(
                                                                            searchedMembersDataListGenderWise[index].profileDateOfBirth!),
                                                                style:
                                                                    TextStyle(
                                                                      color:  ConstHelper
                                                                        .blackColor.withOpacity(0.9),
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      Get.width *
                                                                          0.035,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                Get.width / 30,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'EDU : ',
                                                                style:
                                                                    TextStyle(
                                                                      color: ConstHelper
                                                                          .blackColor,
                                                                      fontSize:
                                                                      Get.width *
                                                                          0.035,
                                                                ),
                                                              ),
                                                              Text(
                                                                searchedMembersDataListGenderWise[index].profileEducation ==
                                                                            null ||
                                                                        searchedMembersDataListGenderWise[index]
                                                                            .profileEducation!
                                                                            .trim()
                                                                            .isEmpty
                                                                    ? 'N/A'
                                                                    : searchedMembersDataListGenderWise[
                                                                            index]
                                                                        .profileEducation!,
                                                                style:
                                                                    TextStyle(
                                                                         color: ConstHelper
                                                                        .blackColor.withOpacity(0.9),
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      Get.width *
                                                                          0.035,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'City : ',
                                                            style: TextStyle(
                                                              color: ConstHelper
                                                                  .blackColor,
                                                              fontSize:
                                                              Get.width *
                                                                  0.035,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${searchedMembersDataListGenderWise[index].profileWorkingCity == null || searchedMembersDataListGenderWise[index].profileWorkingCity!.trim().isEmpty ? '' : searchedMembersDataListGenderWise[index].profileWorkingCity!}',
                                                            style: TextStyle(
                                                              color:   ConstHelper
                                                                .blackColor.withOpacity(0.9),
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontSize:
                                                              Get.width *
                                                                  0.035,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          /*SvgPicture.asset(
                                            'assets/image/menuVerticalIconSVG.svg',
                                            height: Get.width / 25,
                                            width: Get.width / 25,
                                          ),
                                          SizedBox(
                                            width: Get.width / 90,
                                          ),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                      : homeController.allMembersDataListGenderWise.isEmpty
                          ? ListView(
                              children: [
                                SizedBox(
                                  height: Get.height / 2.5,
                                ),
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Oops! No data found. Try again later or contact admin.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ConstHelper.orangeDarkColor,
                                            fontSize: Get.width * 0.05,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount: homeController
                                  .allMembersDataListGenderWise.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    EasyLoading.show(
                                      status: ConstHelper.pleaseWaitMsg,
                                    );
                                    await Future.delayed(
                                      Duration(
                                        milliseconds: 200,
                                      ),
                                    );
                                    if (!(await ConstHelper.checkInternet())) {
                                      EasyLoading.dismiss();
                                      ConstHelper.errorDialog(
                                        text: ConstHelper.internetMsg,
                                        seconds: 10,
                                      );
                                    } else {
                                      homeController.selectedMembersData.value =
                                          homeController
                                                  .allMembersDataListGenderWise[
                                              index];
                                      List<MembersDataModel>
                                          allShortlistedDataList =
                                          await ApiHelper.apiHelper
                                              .getAllShortlistedDataList();
                                      homeController.profileShorted.value =
                                          allShortlistedDataList
                                              .where(
                                                (element) =>
                                                    element.id ==
                                                    homeController
                                                        .selectedMembersData
                                                        .value
                                                        .id,
                                              )
                                              .toList()
                                              .isNotEmpty;
                                      homeController.selectedMembersData.value = await ApiHelper.apiHelper
                                          .getSelectedembersDataList(id: homeController
                                          .allMembersDataListGenderWise[index].id.toString());
                                      Get.to(
                                        MembersDataShowPage(),
                                        transition: Transition.fadeIn,
                                      );
                                      EasyLoading.dismiss();
                                    }

                                    EasyLoading.dismiss();
                                  },
                                  child: Container(
                                    width: Get.width,
                                    margin: EdgeInsets.fromLTRB(
                                      Get.width / 30,
                                      index == 0
                                          ? Get.width / 15
                                          : Get.width / 23,
                                      Get.width / 30,
                                      homeController
                                                  .allMembersDataListGenderWise
                                                  .length !=
                                              (index + 1)
                                          ? 0
                                          : Get.width / 30,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ConstHelper.whiteColor,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ConstHelper.greyColor
                                              .withOpacity(0.1),
                                          offset: const Offset(0, 4),
                                          blurRadius: 2,
                                        ),
                                        BoxShadow(
                                          color: ConstHelper.greyColor
                                              .withOpacity(0.05),
                                          offset: const Offset(0, -1),
                                          blurRadius: 2,
                                        ),
                                      ],
                                      border: Border.all(
                                        width: 0.3,
                                        color: ConstHelper.greyColor
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: Get.width / 30,
                                    ),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 2,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ConstHelper.orangeColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width / 30,
                                                ),
                                                IntrinsicHeight(
                                                  child: Container(
                                                    width: Get.width / 5,
                                                    height: Get.width / 5,
                                                    decoration: BoxDecoration(
                                                      color: ConstHelper
                                                          .whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.5),
                                                      border: Border.all(
                                                        color: ConstHelper
                                                            .greyColor
                                                            .withOpacity(0.3),
                                                      ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      child: CachedNetworkImage(
                                                        imageUrl: homeController
                                                                        .allMembersDataListGenderWise[
                                                                            index]
                                                                        .profilePhoto ==
                                                                    null ||
                                                                homeController
                                                                    .allMembersDataListGenderWise[
                                                                        index]
                                                                    .profilePhoto!
                                                                    .trim()
                                                                    .isEmpty
                                                            ? ConstHelper
                                                                .profileImagePath
                                                            : '${ConstHelper.userImagesPath}${homeController.allMembersDataListGenderWise[index].profilePhoto!}',
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (context, url) =>
                                                                Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            color: ConstHelper
                                                                .whiteColor,
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: SizedBox(
                                                            height:
                                                                Get.width / 20,
                                                            width:
                                                                Get.width / 20,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: ConstHelper
                                                                  .orangeColor,
                                                              strokeWidth: 2,
                                                            ),
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            color: ConstHelper
                                                                .whiteColor,
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
                                                SizedBox(
                                                  width: Get.width / 30,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${homeController.allMembersDataListGenderWise[index].id == null || homeController.allMembersDataListGenderWise[index].id == 0 ? 'Id not available' : homeController.allMembersDataListGenderWise[index].id!} - ${homeController.allMembersDataListGenderWise[index].name == null || homeController.allMembersDataListGenderWise[index].name!.trim().isEmpty ? ConstHelper.nameNotAvailableMsg : homeController.allMembersDataListGenderWise[index].name}',
                                                        style: TextStyle(
                                                          color: ConstHelper
                                                              .orangeDarkColor,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize:
                                                          Get.width * 0.04,
                                                        ),
                                                      ),
                                                      // Text(
                                                      //   homeController
                                                      //                   .allMembersDataListGenderWise[
                                                      //                       index]
                                                      //                   .profileFatherFullName ==
                                                      //               null ||
                                                      //           homeController
                                                      //               .allMembersDataListGenderWise[
                                                      //                   index]
                                                      //               .profileFatherFullName!
                                                      //               .trim()
                                                      //               .isEmpty
                                                      //       ? ConstHelper
                                                      //           .fatherNameNotAvailableMsg
                                                      //       : homeController
                                                      //           .allMembersDataListGenderWise[
                                                      //               index]
                                                      //           .profileFatherFullName!,
                                                      //   style: TextStyle(
                                                      //     color: ConstHelper
                                                      //         .greyColor,
                                                      //     fontWeight:
                                                      //         FontWeight.w500,
                                                      //     fontSize: 12,
                                                      //   ),
                                                      // ),
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'DOB : ',
                                                                style:
                                                                    TextStyle(
                                                                      color: ConstHelper
                                                                          .blackColor,
                                                                      fontSize:
                                                                      Get.width *
                                                                          0.035,
                                                                ),
                                                              ),
                                                              Text(
                                                                homeController.allMembersDataListGenderWise[index].profileDateOfBirth ==
                                                                            null ||
                                                                        homeController.allMembersDataListGenderWise[index].profileDateOfBirth!.year <=
                                                                            0
                                                                    ? 'N/A'
                                                                    : DateFormat('dd | MMM | yyyy').format(homeController
                                                                        .allMembersDataListGenderWise[
                                                                            index]
                                                                        .profileDateOfBirth!),
                                                                style:
                                                                    TextStyle(
                                                                      color: ConstHelper
                                                                          .blackColor.withOpacity(0.9),
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      Get.width *
                                                                          0.035,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                Get.width / 50,
                                                          ),
                                                          Row(
                                                            
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        
                                                      ),
                                                      Row(children: [
                                                              Text(
                                                                'EDU : ',
                                                                style:
                                                                    TextStyle(
                                                                      color: ConstHelper
                                                                          .blackColor,
                                                                      fontSize:
                                                                      Get.width *
                                                                          0.035,
                                                                ),
                                                              ),
                                                              Text(
                                                                homeController.allMembersDataListGenderWise[index].profileEducation ==
                                                                            null ||
                                                                        homeController
                                                                            .allMembersDataListGenderWise[
                                                                                index]
                                                                            .profileEducation!
                                                                            .trim()
                                                                            .isEmpty
                                                                    ? 'N/A'
                                                                    : homeController
                                                                        .allMembersDataListGenderWise[
                                                                            index]
                                                                        .profileEducation!,
                                                                style:
                                                                    TextStyle(
                                                                      color: ConstHelper
                                                                          .blackColor.withOpacity(0.9),
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      Get.width *
                                                                          0.035,
                                                                ),
                                                              ),
                                                            ],),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'City : ',
                                                            style: TextStyle(
                                                              color: ConstHelper
                                                                  .blackColor,
                                                              fontSize:
                                                              Get.width *
                                                                  0.035,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${homeController.allMembersDataListGenderWise[index].profileWorkingCity == null || homeController.allMembersDataListGenderWise[index].profileWorkingCity!.trim().isEmpty ? '' : homeController.allMembersDataListGenderWise[index].profileWorkingCity!}',
                                                            style: TextStyle(
                                                              color:   ConstHelper
                                                                .blackColor.withOpacity(0.9),
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontSize:
                                                              Get.width *
                                                                  0.035,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          /*SvgPicture.asset(
                                            'assets/image/menuVerticalIconSVG.svg',
                                            height: Get.width / 25,
                                            width: Get.width / 25,
                                          ),
                                          SizedBox(
                                            width: Get.width / 90,
                                          ),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
            ),
          ),
          bottomNavigationBar: (homeController.userData.value.profileType?.toString() == "2")?IntrinsicHeight(
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: ConstHelper.orangeColor.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  margin: EdgeInsets.only(
                    top: Get.width / 60,
                    bottom: Get.width / 30,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (!maleFemale.value) {
                            maleFemale.value = true;
                            await getAllMembersData();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: maleFemale.value
                                ? ConstHelper.orangeColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: Get.width / 40,
                            horizontal: Get.width / 25,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/image/maleIconSVG.svg',
                                height: Get.width / 30,
                                width: Get.width / 30,
                                color: maleFemale.value
                                    ? ConstHelper.whiteColor
                                    : ConstHelper.orangeColor,
                              ),
                              SizedBox(
                                width: Get.width / 60,
                              ),
                              Text(
                                //profile_gender
                                'Male ${totalMaleMembers.value}',
                                style: TextStyle(
                                  color: maleFemale.value
                                      ? ConstHelper.whiteColor
                                      : ConstHelper.orangeColor,
                                  fontSize: Get.width * 0.04,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (maleFemale.value) {
                            maleFemale.value = false;
                            await getAllMembersData();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: !maleFemale.value
                                ? ConstHelper.orangeColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: Get.width / 40,
                            horizontal: Get.width / 25,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/image/femaleIconSVG.svg',
                                height: Get.width / 30,
                                width: Get.width / 30,
                                color: maleFemale.value
                                    ? ConstHelper.orangeColor
                                    : ConstHelper.whiteColor,
                              ),
                              SizedBox(
                                width: Get.width / 60,
                              ),
                              Text(
                                'Female ${totalFemaleMembers.value}',
                                style: TextStyle(
                                  color: maleFemale.value
                                      ? ConstHelper.orangeColor
                                      : ConstHelper.whiteColor,
                                  fontSize: Get.width * 0.04,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ):SizedBox(),
        ),
      ),
    );
  }
}

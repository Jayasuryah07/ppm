import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../Controllers/HomeController.dart';
import '../../Utils/ApiHelper.dart';
import '../../Utils/ConstHelper.dart';
import '../../Utils/PhotoViewPage.dart';

class Editprofilepage extends StatefulWidget {
  const Editprofilepage({super.key});

  @override
  State<Editprofilepage> createState() => _EditprofilepageState();
}

class _EditprofilepageState extends State<Editprofilepage> {

  HomeController homeController = Get.put(HomeController());

  List yesNoList = [
    "Yes",
    "No"
  ];

  String selectedMarried = "No";
  String selectedPhysical = "No";
  RxString selectedPhotoPath = ''.obs;
  RxString photoPath = ''.obs;

  TextEditingController txtBirthDate = TextEditingController();
  TextEditingController txtBirthTime = TextEditingController();
  TextEditingController txtBirthPlace = TextEditingController();
  TextEditingController txtHeight = TextEditingController();
  TextEditingController txtGender = TextEditingController();
  TextEditingController txtMobileNo = TextEditingController();
  TextEditingController txtWhatsappNo = TextEditingController();
  TextEditingController txtMainContactNo = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtQualification = TextEditingController();
  TextEditingController txtOccupation = TextEditingController();
  TextEditingController txtFatherName = TextEditingController();
  TextEditingController txtReferenceName = TextEditingController();
  TextEditingController txtReferenceMobileNo = TextEditingController();
  TextEditingController txtWorkingCity = TextEditingController();
  TextEditingController txtPlaceOfBirth = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtImportantNote = TextEditingController();
  TextEditingController txtGotra = TextEditingController();
  TextEditingController txtCommunity = TextEditingController();

  getData() {
    photoPath.value = homeController.userData.value.profilePhoto == null || homeController.userData.value.profilePhoto!.trim().isEmpty ? ConstHelper.profileImagePath : '${ConstHelper.userImagesPath}${homeController.userData.value.profilePhoto!}';
    txtBirthDate.text = homeController.userData.value.profileDateOfBirth == null || homeController.userData.value.profileDateOfBirth!.year <= 0 ? ConstHelper.naMsg : DateFormat('dd | MMM | yyyy').format(homeController.userData.value.profileDateOfBirth!);
    txtBirthTime.text = homeController.userData.value.profileTimeOfBirth == null || homeController.userData.value.profileTimeOfBirth!.trim().isEmpty ? ConstHelper.naMsg : DateFormat('hh:mm a').format(DateFormat('h:m').parse(homeController.userData.value.profileTimeOfBirth!));
    txtBirthPlace.text = homeController.userData.value.profilePlaceOfBirth == null || homeController.userData.value.profilePlaceOfBirth!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profilePlaceOfBirth!;
    txtHeight.text = homeController.userData.value.profileHeight == null || homeController.userData.value.profileHeight!.trim().isEmpty ? ConstHelper.naMsg : '${homeController.userData.value.profileHeight![0]} ft ${homeController.userData.value.profileHeight!.substring(1)} Inch';
    txtGender.text = homeController.userData.value.profileGender == null || homeController.userData.value.profileGender!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileGender!;
    txtMobileNo.text = homeController.userData.value.profileMobile == null || homeController.userData.value.profileMobile!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileMobile!;
    txtWhatsappNo.text = homeController.userData.value.profileWhatsapp == null || homeController.userData.value.profileWhatsapp!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileWhatsapp!;
    txtMainContactNo.text = homeController.userData.value.profileMainContactNum == null || homeController.userData.value.profileMainContactNum!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileMainContactNum!;
    txtEmail.text = homeController.userData.value.email == null || homeController.userData.value.email!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.email!;
    txtFatherName.text = homeController.userData.value.profileFatherFullName == null || homeController.userData.value.profileFatherFullName!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileFatherFullName!;
    txtReferenceMobileNo.text = homeController.userData.value.profileRefContactMobile == null || homeController.userData.value.profileRefContactMobile!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileRefContactMobile!;
    selectedMarried = homeController.userData.value.profileHaveMarriedBefore == null || homeController.userData.value.profileHaveMarriedBefore!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileHaveMarriedBefore!;
    selectedPhysical = homeController.userData.value.profilePhysicalDisablity == null || homeController.userData.value.profilePhysicalDisablity!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profilePhysicalDisablity!;
    txtQualification.text = homeController.userData.value.profileEducation == null || homeController.userData.value.profileEducation!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileEducation!;
    txtOccupation.text = homeController.userData.value.profileOccupation == null || homeController.userData.value.profileOccupation!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileOccupation!;
    txtReferenceName.text = homeController.userData.value.profileRefContactName == null || homeController.userData.value.profileRefContactName!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileRefContactName!;
    txtWorkingCity.text = homeController.userData.value.profileWorkingCity == null || homeController.userData.value.profileWorkingCity!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileWorkingCity!;
    txtAddress.text = homeController.userData.value.profilePermanentAddress == null || homeController.userData.value.profilePermanentAddress!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profilePermanentAddress!;
    txtImportantNote.text = homeController.userData.value.profileNote == null || homeController.userData.value.profileNote!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileNote!;
    txtGotra.text = homeController.userData.value.profileGotra == null || homeController.userData.value.profileGotra!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileGotra!;
    txtCommunity.text = homeController.userData.value.profileComunityName == null || homeController.userData.value.profileComunityName!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileComunityName!;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",style: TextStyle(fontSize: 20,color: ConstHelper.blackColor,fontWeight: FontWeight.bold,),),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back,size: Get.width/13,),
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
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width/20,),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.width/30,),
                Obx(() => Center(
                  child: Container(
                    height: Get.width/2.3,
                    width: Get.width/2.3,
                    child: Stack(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if(selectedPhotoPath.trim().isNotEmpty)
                              {
                                Get.to(PhotoViewPage(imagePath: selectedPhotoPath.value),);
                              }
                            },
                            child: Container(
                              height: Get.width/2.3,
                              width: Get.width/2.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  border: Border.all(color: ConstHelper.orangeColor,),
                                  image: selectedPhotoPath.trim().isEmpty ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(photoPath.value,),
                                  ) : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(File(selectedPhotoPath.value),),
                                  )
                              ),
                              child: selectedPhotoPath.trim().isNotEmpty || photoPath.value.isNotEmpty ? null : Center(child: SvgPicture.asset('assets/image/personWithRoundedSVG.svg',height: Get.width/3.5,width: Get.width/3.5,fit: BoxFit.contain,color: ConstHelper.cementColor,)),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: Get.width/100,bottom: Get.width/100,),
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return IntrinsicHeight(
                                      child: Container(
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                            color: ConstHelper.whiteColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            )
                                        ),
                                        padding: EdgeInsets.all(Get.width/30,),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Choose',
                                              style: TextStyle(
                                                color: ConstHelper.blackColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(height: Get.width/30,),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    selectedPhotoPath.value = await ConstHelper.constHelper.pickImage(source: ImageSource.camera,);
                                                    if(selectedPhotoPath.trim().isNotEmpty)
                                                    {
                                                      Get.back();
                                                    }
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Icon(Icons.camera_alt_rounded,color: ConstHelper.orangeColor,size: Get.width/18,),
                                                      Text(
                                                        'Camera',
                                                        style: TextStyle(
                                                          color: ConstHelper.orangeColor,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: Get.width/20,),
                                                GestureDetector(
                                                  onTap: () async {
                                                    selectedPhotoPath.value = await ConstHelper.constHelper.pickImage(source: ImageSource.gallery,);
                                                    if(selectedPhotoPath.trim().isNotEmpty)
                                                    {
                                                      Get.back();
                                                    }
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Icon(Icons.photo_rounded,color: ConstHelper.orangeColor,size: Get.width/18,),
                                                      Text(
                                                        'Gallery',
                                                        style: TextStyle(
                                                          color: ConstHelper.orangeColor,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ConstHelper.orangeColor,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(Get.width/60),
                                child: Icon(Icons.camera_alt_rounded,color: ConstHelper.whiteColor,size: Get.width/18,),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),),
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
                SizedBox(height: Get.width/30,),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             "Date of Birth",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ConstHelper.blackColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              height: 40,
                              child: TextFormField(
                                style: TextStyle(color: ConstHelper.blackColor,),
                                controller: txtBirthDate,
                                readOnly: true,
                                validator: (value) {
                                  if(value == null || value.trim().isEmpty)
                                  {
                                    return "Please enter the full name";
                                  }
                                  return null;
                                },
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: ConstHelper.whiteColor,),
                                  //     borderRadius: BorderRadius.circular(10)
                                  // ),
                                  // border: OutlineInputBorder(
                                  //   borderSide: BorderSide(color: ConstHelper.whiteColor,),
                                  //   borderRadius: BorderRadius.circular(10)
                                  // )
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ),
                    SizedBox(width: Get.width/30,),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             "Date of Time",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ConstHelper.blackColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              height: 40,
                              child: TextFormField(
                                style: TextStyle(color: ConstHelper.blackColor,),
                                controller: txtBirthTime,
                                readOnly: true,
                                validator: (value) {
                                  if(value == null || value.trim().isEmpty)
                                  {
                                    return "Please enter the full name";
                                  }
                                  return null;
                                },
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //     borderRadius: BorderRadius.circular(10)
                                  // ),
                                  // border: OutlineInputBorder(
                                  //   borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //   borderRadius: BorderRadius.circular(10)
                                  // )
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ),
                  ],
                ),
                SizedBox(height: Get.width/60,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Place of Birth",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              style: TextStyle(color: ConstHelper.blackColor,),
                              controller: txtBirthPlace,
                              readOnly: true,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty)
                                {
                                  return "Please enter the full name";
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                             decoration: InputDecoration(
                                 contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //     borderRadius: BorderRadius.circular(10)
                                  // ),
                                  // border: OutlineInputBorder(
                                  //   borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //   borderRadius: BorderRadius.circular(10)
                                  // )
                               border: InputBorder.none,
                             ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Get.width/30,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Height",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              style: TextStyle(color: ConstHelper.blackColor,),
                              controller: txtHeight,
                              readOnly: true,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty)
                                {
                                  return "Please enter the full name";
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                             decoration: InputDecoration(
                                 contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //     borderRadius: BorderRadius.circular(10)
                                  // ),
                                  // border: OutlineInputBorder(
                                  //   borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //   borderRadius: BorderRadius.circular(10)
                                  // )
                               border: InputBorder.none,
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.width/60,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gender",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              style: TextStyle(color: ConstHelper.blackColor,),
                              controller: txtGender,
                              readOnly: true,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty)
                                {
                                  return "Please enter the full name";
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                             decoration: InputDecoration(
                                 contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //     borderRadius: BorderRadius.circular(10)
                                  // ),
                                  // border: OutlineInputBorder(
                                  //   borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //   borderRadius: BorderRadius.circular(10)
                                  // )
                                  border: InputBorder.none,
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Get.width/30,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mobile No.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              style: TextStyle(color: ConstHelper.blackColor,),
                              controller: txtMobileNo,
                              readOnly: true,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty)
                                {
                                  return "Please enter the full name";
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                             decoration: InputDecoration(
                                 contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //     borderRadius: BorderRadius.circular(10)
                                  // ),
                                  // border: OutlineInputBorder(
                                  //   borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //   borderRadius: BorderRadius.circular(10)
                                  // )
                               border: InputBorder.none,
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.width/60,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact No.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              style: TextStyle(color: ConstHelper.blackColor,),
                              controller: txtMainContactNo,
                              readOnly: true,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty)
                                {
                                  return "Please enter the full name";
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                             decoration: InputDecoration(
                                 contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //     borderRadius: BorderRadius.circular(10)
                                  // ),
                                  // border: OutlineInputBorder(
                                  //   borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //   borderRadius: BorderRadius.circular(10)
                                  // )
                               border: InputBorder.none,
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Get.width/30,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Father Name",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              style: TextStyle(color: ConstHelper.blackColor,),
                              controller: txtFatherName,
                              readOnly: true,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty)
                                {
                                  return "Please enter the full name";
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //     borderRadius: BorderRadius.circular(10)
                                  // ),
                                  // border: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //     borderRadius: BorderRadius.circular(10)
                                  // )
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.width/60,),
                Text(
                  "Email ID",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                    style: TextStyle(color: ConstHelper.blackColor,),
                    controller: txtEmail,
                    readOnly: true,
                    validator: (value) {
                      if(value == null || value.trim().isEmpty)
                      {
                        return "Please enter the full name";
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                        // focusedBorder: OutlineInputBorder(
                        //     borderSide: BorderSide(color: ConstHelper.blackColor,),
                        //     borderRadius: BorderRadius.circular(10)
                        // ),
                        // border: OutlineInputBorder(
                        //     borderSide: BorderSide(color: ConstHelper.blackColor,),
                        //     borderRadius: BorderRadius.circular(10)
                        // )
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: Get.width/60,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "WhatsApp No.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              style: TextStyle(color: ConstHelper.blackColor,),
                              controller: txtWhatsappNo,
                              maxLength: 10,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty)
                                {
                                  return "Please enter the full name";
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                counterText: "",
                                  contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: ConstHelper.blackColor,),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: ConstHelper.blackColor,),
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Get.width/30,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reference No.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              style: TextStyle(color: ConstHelper.blackColor,),
                              controller: txtReferenceMobileNo,
                              maxLength: 10,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty)
                                {
                                  return "Please enter the full name";
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  counterText: "",
                                  contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: ConstHelper.blackColor,),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: ConstHelper.blackColor,),
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.width/60,),
                Text(
                  "Have you been married before?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    items: yesNoList
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ConstHelper.blackColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                        .toList(),
                    value: selectedMarried,
                    onChanged: (String? value) {
                      setState(() {
                        selectedMarried = value.toString();
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 40,
                      width: Get.width,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: ConstHelper.blackColor
                        ),
                      ),
                      elevation: 0,
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      iconSize: 18,
                      iconEnabledColor: ConstHelper.blackColor,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: Get.width ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
                SizedBox(height: Get.width/60,),
                Text(
                  "Physical Disability (if any)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    items: yesNoList
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ConstHelper.blackColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                        .toList(),
                    value: selectedPhysical,
                    onChanged: (String? value) {
                      setState(() {
                        selectedPhysical = value.toString();
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 40,
                      width: Get.width,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: ConstHelper.blackColor
                        ),
                      ),
                      elevation: 0,
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      iconSize: 18,
                      iconEnabledColor: ConstHelper.blackColor,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: Get.width ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
                SizedBox(height: Get.width/60,),
                Text(
                  "Qualification",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                    style: TextStyle(color: ConstHelper.blackColor,),
                    controller: txtQualification,
                    validator: (value) {
                      if(value == null || value.trim().isEmpty)
                      {
                        return "Please enter the full name";
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ConstHelper.blackColor,),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: ConstHelper.blackColor,),
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                SizedBox(height: Get.width/60,),
                Text(
                  "Occupation",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                    style: TextStyle(color: ConstHelper.blackColor,),
                    controller: txtOccupation,
                    validator: (value) {
                      if(value == null || value.trim().isEmpty)
                      {
                        return "Please enter the full name";
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ConstHelper.blackColor,),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: ConstHelper.blackColor,),
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                SizedBox(height: Get.width/60,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reference Name",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              style: TextStyle(color: ConstHelper.blackColor,),
                              controller: txtReferenceName,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty)
                                {
                                  return "Please enter the full name";
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: ConstHelper.blackColor,),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: ConstHelper.blackColor,),
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Get.width/30,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Working City",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              style: TextStyle(color: ConstHelper.blackColor,),
                              controller: txtWorkingCity,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty)
                                {
                                  return "Please enter the full name";
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: ConstHelper.blackColor,),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: ConstHelper.blackColor,),
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.width/60,),
                Text(
                  "Permanent Address",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                    style: TextStyle(color: ConstHelper.blackColor,),
                    controller: txtAddress,
                    validator: (value) {
                      if(value == null || value.trim().isEmpty)
                      {
                        return "Please enter the full name";
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ConstHelper.blackColor,),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: ConstHelper.blackColor,),
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                SizedBox(height: Get.width/60,),
                Text(
                  "Important Note",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                    style: TextStyle(color: ConstHelper.blackColor,),
                    controller: txtImportantNote,
                    validator: (value) {
                      if(value == null || value.trim().isEmpty)
                      {
                        return "Please enter the full name";
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ConstHelper.blackColor,),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: ConstHelper.blackColor,),
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                SizedBox(height: Get.width/60,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gotra",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              style: TextStyle(color: ConstHelper.blackColor,),
                              controller: txtGotra,
                              readOnly: true,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty)
                                {
                                  return "Please enter the full name";
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  counterText: "",
                                  contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //     borderRadius: BorderRadius.circular(10)
                                  // ),
                                  // border: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //     borderRadius: BorderRadius.circular(10)
                                  // )
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Get.width/30,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Community",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              style: TextStyle(color: ConstHelper.blackColor,),
                              controller: txtCommunity,
                              readOnly: true,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty)
                                {
                                  return "Please enter the full name";
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  counterText: "",
                                  contentPadding: EdgeInsets.only(bottom: 5,left: 8),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //     borderRadius: BorderRadius.circular(10)
                                  // ),
                                  // border: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: ConstHelper.blackColor,),
                                  //     borderRadius: BorderRadius.circular(10)
                                  // )
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.width/10,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width/8,),
                  child: InkWell(
                    onTap: () async {

                      await ApiHelper.apiHelper
                          .editProfile(
                          whatsapp: txtWhatsappNo.text,
                          working_city: txtWorkingCity.text,
                          ref_contact_name: txtReferenceName.text,
                          ref_contact_mobile: txtReferenceMobileNo.text,
                          photo: selectedPhotoPath.value,
                          education: txtQualification.text,
                          occupation: txtOccupation.text,
                          have_married_before: selectedPhysical,
                          physical_disablity: selectedPhysical,
                          note: txtImportantNote.text,
                          permanent_address: txtAddress.text,
                          village_city: "").then((value) {
                              Get.back();
                              ConstHelper.successDialog(text: 'Profile Updated Successfully', seconds: 10,);
                          },);
                      homeController.userData.value = (await ApiHelper.apiHelper.fetchProfile())!;
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
                        'Update',
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
        ),
      ),
    );
  }
}

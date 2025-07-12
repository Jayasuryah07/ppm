import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../Controllers/HomeController.dart';
import '../../Utils/ApiHelper.dart';
import '../../Utils/ConstHelper.dart';
import '../../Utils/PhotoViewPage.dart';
import '../HomeScreen/MembersDataShowPage.dart';
String normalizeTime(String input) {
  try {
    // Split input by space to separate time and period (AM/PM)
    final parts = input.trim().split(' ');
    if (parts.length != 2) throw FormatException('Invalid format');

    final timeParts = parts[0].split(':');
    if (timeParts.length != 2) throw FormatException('Invalid time');

    final hour = timeParts[0].padLeft(2, '0');
    final minute = timeParts[1].padLeft(2, '0');
    final period = parts[1].toUpperCase();

    final normalized = '$hour:$minute $period';
    final parsed = DateFormat('hh:mm a').parse(normalized);
    return DateFormat('hh:mm a').format(parsed);
  } catch (e) {
    return 'Invalid Time';
  }
}

String convertTo12HourFormat(String time24) {
  // Parse the 24-hour format time string into a DateTime object
  final DateFormat inputFormat = DateFormat("HH:mm");
  final DateTime dateTime = inputFormat.parse(time24);

  // Format the DateTime object into 12-hour format with AM/PM
  final DateFormat outputFormat = DateFormat("hh:mm a");
  return outputFormat.format(dateTime);
}

class CommonTextField extends StatelessWidget {
  final String label;
  final String subLabel;
  final TextStyle? textStyle;

  const CommonTextField({
    super.key,
    required this.label,
    required this.subLabel,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: Get.width * 0.04,
          ),
        ),
        Text(
          subLabel,
          style: textStyle ??
              TextStyle(
                color: Colors.black,
                fontSize: Get.width * 0.035,
              ),
        ),
      ],
    );
  }
}

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
  Map? selectedEducation;
  Map? selectedCommunity;
  Map? selectedGotra;
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
  TextEditingController txtEducation = TextEditingController();

  getData() async {
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
    txtEducation.text = homeController.userData.value.profileEducation == null || homeController.userData.value.profileEducation!.trim().isEmpty ? ConstHelper.naMsg : homeController.userData.value.profileEducation!;
    homeController.communityDataList.value = await ApiHelper.apiHelper.getCommunityDataList();
    homeController.educationDataList.value = await ApiHelper.apiHelper.getEducationDataList();
    }


  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print(homeController.communityDataList);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",style:TextStyle(fontSize: Get.width*0.05,letterSpacing:1,color: ConstHelper.blackColor,fontWeight: FontWeight.bold,),),
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
                                                fontSize: Get.width*0.04,
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
                                                          fontSize: Get.width*0.035,
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
                                                          fontSize: Get.width*0.035,
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
                      fontSize: Get.width*0.05,
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
                                fontSize: Get.width*0.035,
                              ),
                            ),
                            TextSpan(
                              text: homeController.userData.value.id == null || homeController.userData.value.id == 0 ? ConstHelper.naMsg : homeController.userData.value.id!.toString(),
                              style: TextStyle(
                                color: ConstHelper.orangeColor,
                                fontWeight: FontWeight.w500,
                                fontSize: Get.width*0.035,
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
                      child: CommonTextField(
                        label: "Date of Birth",
                        subLabel: DateFormat("dd-MM-yyyy").format(
                            homeController
                                .userData.value.profileDateOfBirth ??
                                DateTime.now()),
                      ),
                    ),
                    SizedBox(width: Get.width/30,),
                    Expanded(
                      child: CommonTextField(
                          label: "Time of Birth",
                          subLabel: convertTo12HourFormat(homeController
                              .userData.value.profileTimeOfBirth ??
                              "")),
                    ),
                  ],
                ),
                SizedBox(height: Get.width/60,),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                          label: "Place of Birth",
                          subLabel: homeController
                              .userData.value.profilePlaceOfBirth ??
                              ""),
                    ),
                    SizedBox(width: Get.width/30,),
                    Expanded(
                      child: CommonTextField(
                        label: "Height",
                        subLabel: convertInchesToFeetInch(int.parse(homeController
                            .userData.value.profileHeight?.toString()??"0")
                        ),),),
                  ],
                ),
                SizedBox(height: Get.width/60,),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        label: "Gender",
                        subLabel:
                        homeController.userData.value.profileGender ??
                            "",
                      ),
                    ),
                    SizedBox(width: Get.width/30,),
                    Expanded(
                      child: CommonTextField(
                          label: "Mobile No.",
                          subLabel: homeController
                              .userData.value.profileMobile ??
                              "N/A"),
                    ),
                  ],
                ),
                SizedBox(height: Get.width/60,),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                          label: "Contact No.",
                          subLabel: homeController
                              .userData.value.profileMainContactNum ??
                              "N/A"),
                    ),
                    SizedBox(width: Get.width/30,),
                    Expanded(
                      child: CommonTextField(
                          label: "Father's Name",
                          subLabel: homeController
                              .userData.value.profileFatherFullName ??
                              ""),
                    ),
                  ],
                ),
                SizedBox(height: Get.width/60,),
                CommonTextField(
                  label: "Email",
                  subLabel: homeController.userData.value.email ?? "",
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
                              fontSize: Get.width * 0.04,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              style: TextStyle(color: ConstHelper.blackColor,
                                  fontWeight: FontWeight.w500,fontSize: Get.width*0.04),
                              controller: txtWhatsappNo,
                              maxLength: 10,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty)
                                {
                                  return "Please enter whatsapp";
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  counterText: "",
                                  isDense:true,
                                  hintStyle: TextStyle(color: ConstHelper.blackColor,
                                      fontWeight: FontWeight.normal,fontSize: Get.width*0.035),
                                  contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.01),
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
                              fontSize: Get.width * 0.04,
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              style: TextStyle(color: ConstHelper.blackColor,
                                  fontWeight: FontWeight.w500,fontSize: Get.width*0.04),
                              controller: txtReferenceMobileNo,
                              maxLength: 10,
                              validator: (value) {
                                if(value == null || value.trim().isEmpty)
                                {
                                  return "Please enter reference no";
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  counterText: "",
                                  isDense:true,
                                  hintStyle: TextStyle(color: ConstHelper.blackColor,
                                      fontWeight: FontWeight.normal,fontSize: Get.width*0.035),
                                  contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.01),
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
                    fontSize: Get.width * 0.04,
                  ),
                ),
                SizedBox(
                  height: Get.height*0.05,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      items: yesNoList
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(color: ConstHelper.blackColor,
                              fontWeight: FontWeight.w500,fontSize: Get.width*0.04),
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
                ),
                SizedBox(height: Get.width/60,),
                Text(
                  "Community",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                SizedBox(
                  height: Get.height*0.05,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      items: homeController.communityDataList
                          .map((element) => DropdownMenuItem(
                        value: element,
                        child: Text(
                          (element['community_name'] ?? '').toString(),
                          style: TextStyle(
                            color: ConstHelper.blackColor,
                            fontSize: Get.width * 0.04,
                            letterSpacing: 1,
                          ),
                        ),
                      ))
                          .toList(),
                      value: txtCommunity.text.isEmpty
                          ? null
                          : homeController.communityDataList.firstWhere(
                            (element) => element['community_name'] == txtCommunity.text,
                        orElse: () => null,
                      ),
                      onChanged: (value) async {
                        EasyLoading.show(status: ConstHelper.pleaseWaitMsg);
                        await Future.delayed(const Duration(milliseconds: 100));
                        value as Map;
                        txtGotra.text ="";
                        txtCommunity.text =value?["community_name"]??"";
                        try {homeController
                            .gotraDataListCommunityIdWise.clear();
                        homeController.gotraDataListCommunityIdWise.value =
                        await ApiHelper.apiHelper.getGotraDataListCommunityWise(
                          comunityId: (value["id"]).toString(),
                        );
                        setState(() {});
                        } catch (error) {
                          homeController.gotraDataListCommunityIdWise.value = [];
                          EasyLoading.dismiss();
                          ConstHelper.errorDialog(
                            text: ConstHelper.somethingErrorMsg,
                            seconds: 10,
                          );
                        }
                        EasyLoading.dismiss();
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
                ),
                SizedBox(height: Get.width/60,),
                Text(
                  "Gotra",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                SizedBox(
                  height: Get.height*0.05,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      items: homeController
                          .gotraDataListCommunityIdWise
                          .map((element) {
                        return DropdownMenuItem<
                            Map<dynamic, dynamic>>(
                          value: element,
                          // Pass the full element as value
                          child: Text(
                            (element['gotra_name'] ?? '')
                                .toString(),
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontSize: Get.width * 0.04,
                              letterSpacing: 1,
                            ),
                          ),
                        );
                      }).toList(),
                      value: txtGotra.text.isEmpty
                          ? null
                          : homeController.gotraDataListCommunityIdWise.firstWhere(
                            (element) => element['gotra_name'] == txtGotra.text,
                        orElse: () => null,
                      ),
                      onChanged: (value) async {
                        if (value != null) {
                          value as Map;
                          txtGotra.text = value['gotra_name'];
                        }
                        setState(() {});
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
                ),
                SizedBox(height: Get.width/60,),
                Text(
                  "Education",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                SizedBox(
                  height: Get.height*0.05,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      items: homeController.educationDataList
                          .map((element) {
                        return DropdownMenuItem(
                          value: element,
                          // Pass the full element as value
                          child: Text(
                            (element['education_name'] ?? '')
                                .toString(),
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontSize: Get.width * 0.04,
                              letterSpacing: 1,
                            ),
                          ),
                        );
                      }).toList(),
                      value: txtEducation.text.isEmpty
                          ? null
                          : homeController.educationDataList.firstWhere(
                            (element) => element['education_name'] == txtEducation.text,
                        orElse: () => null,
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedEducation = value as Map;
                          txtEducation.text = selectedEducation?['education_name'] ?? '';
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
                ),
                SizedBox(height: Get.width/60,),
                Text(
                  "Physical Disability (if any)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                SizedBox(
                  height: Get.height*0.05,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      items: yesNoList
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style:TextStyle(color: ConstHelper.blackColor,
                              fontWeight: FontWeight.w500,fontSize: Get.width*0.04),
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
                ),
                SizedBox(height: Get.width/60,),
                Text(
                  "Qualification",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                TextFormField(
                  style: TextStyle(color: ConstHelper.blackColor,
                      fontWeight: FontWeight.w500,fontSize: Get.width*0.04),
                  controller: txtQualification,
                  validator: (value) {
                    if(value == null || value.trim().isEmpty)
                    {
                      return "Please enter qualification";
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      isDense:true,
                      hintStyle: TextStyle(color: ConstHelper.blackColor,
                          fontWeight: FontWeight.normal,fontSize: Get.width*0.035),
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.01),
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
                SizedBox(height: Get.width/60,),
                Text(
                  "Occupation",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                TextFormField(
                  style: TextStyle(color: ConstHelper.blackColor,
                      fontWeight: FontWeight.w500,fontSize: Get.width*0.04),
                  controller: txtOccupation,
                  validator: (value) {
                    if(value == null || value.trim().isEmpty)
                    {
                      return "Please enter occupation";
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      isDense:true,
                      hintStyle: TextStyle(color: ConstHelper.blackColor,
                          fontWeight: FontWeight.normal,fontSize: Get.width*0.035),
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.01),
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
                              fontSize: Get.width * 0.04,
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(color: ConstHelper.blackColor,
                                fontWeight: FontWeight.w500,fontSize: Get.width*0.04),
                            controller: txtReferenceName,
                            validator: (value) {
                              if(value == null || value.trim().isEmpty)
                              {
                                return "Please enter reference name";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                isDense:true,
                                hintStyle: TextStyle(color: ConstHelper.blackColor,
                                    fontWeight: FontWeight.normal,fontSize: Get.width*0.035),
                                contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.01),
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
                              fontSize: Get.width * 0.04,
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(color: ConstHelper.blackColor,
                                fontWeight: FontWeight.w500,fontSize: Get.width*0.04),
                            controller: txtWorkingCity,
                            validator: (value) {
                              if(value == null || value.trim().isEmpty)
                              {
                                return "Please enter working city";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                isDense:true,
                                hintStyle: TextStyle(color: ConstHelper.blackColor,
                                    fontWeight: FontWeight.normal,fontSize: Get.width*0.035),
                                contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.01),
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
                    fontSize: Get.width * 0.04,
                  ),
                ),
                TextFormField(
                  style: TextStyle(color: ConstHelper.blackColor,
                      fontWeight: FontWeight.w500,fontSize: Get.width*0.04),
                  controller: txtAddress,
                  maxLines: 4,
                  maxLength: 250,
                  validator: (value) {
                    if(value == null || value.trim().isEmpty)
                    {
                      return "Please enter the full name";
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      isDense:true,
                      hintStyle: TextStyle(color: ConstHelper.blackColor,
                          fontWeight: FontWeight.normal,fontSize: Get.width*0.035),
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.01),
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
                SizedBox(height: Get.width/60,),
                Text(
                  "Important Note",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                TextFormField(
                  style: TextStyle(color: ConstHelper.blackColor,
                      fontWeight: FontWeight.w500,fontSize: Get.width*0.04),
                  controller: txtImportantNote,
                  maxLength: 500,
                  maxLines: 4,
                  validator: (value) {
                    if(value == null || value.trim().isEmpty)
                    {
                      return "Please enter note";
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      isDense:true,
                      hintStyle: TextStyle(color: ConstHelper.blackColor,
                          fontWeight: FontWeight.normal,fontSize: Get.width*0.035),
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.01),
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
                SizedBox(height: Get.width/80,),

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
                        'Save Changes',
                        style: TextStyle(
                          color: ConstHelper.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width*0.045,
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
    ));
  }
}

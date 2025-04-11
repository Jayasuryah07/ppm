import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../Controllers/HomeController.dart';
import '../../Models/MembersDataModel.dart';
import '../../Utils/ApiHelper.dart';
import '../../Utils/ConstHelper.dart';
import '../../Utils/PhotoViewPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  RxString gender = ''.obs;
  RxString dob = ''.obs;
  RxString dobTime = ''.obs;
  HomeController homeController = Get.put(HomeController());
  RxMap selectedCommunityData = {}.obs;
  RxMap selectedGotraData = {}.obs;
  RxMap selectedEducationData = {}.obs;
  RxList heightFeetList = [
    '4',
    '5',
    '6',
    '7',
  ].obs;
  RxList heightInchList = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
  ].obs;
  RxString heightFeet = ''.obs;
  RxString heightInch = ''.obs;
  RxList physicalAbilityList = [
    'Yes',
    'No',
  ].obs;
  RxList marriedBeforeList = [
    'No',
    'Yes And Divorced',
    'Yes And Spouse Dead',
  ].obs;
  RxString selectedPhysicalAbility = ''.obs;
  RxString selectedMarriedBefore = ''.obs;
  RxString selectedPhotoPath = ''.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtFullName = TextEditingController();
  TextEditingController txtOccupation = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobileNo = TextEditingController();
  TextEditingController txtWhatsappNo = TextEditingController();
  TextEditingController txtMainContactNo = TextEditingController();
  TextEditingController txtFatherName = TextEditingController();
  TextEditingController txtReferenceName = TextEditingController();
  TextEditingController txtReferenceMobileNo = TextEditingController();
  TextEditingController txtWorkingCity = TextEditingController();
  TextEditingController txtPlaceOfBirth = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtImportantNote = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode occupationFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileNoFocusNode = FocusNode();
  FocusNode whatsappNoFocusNode = FocusNode();
  FocusNode mainContactNoFocusNode = FocusNode();
  FocusNode fatherNameFocusNode = FocusNode();
  FocusNode referenceNameFocusNode = FocusNode();
  FocusNode referenceMobileNoFocusNode = FocusNode();
  FocusNode workingCityFocusNode = FocusNode();
  FocusNode placeOfBirthFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode importantNoteFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstHelper.whiteColor,
        body: Form(
          key: formKey,
          child: Stack(
            children: [
              Container(
                width: Get.width,
                height: Get.height,
                color: ConstHelper.lightBlackColor,
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    'assets/image/loginPage.jpg',
                    width: Get.width,
                    height: Get.height,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(),
              SingleChildScrollView(
                child: Obx(
                  () => Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width/30,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.width/12,),
                        Center(
                          child: Container(
                            height: Get.width/3,
                            width: Get.width/3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                image: AssetImage('assets/image/applogo.png',),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.width/25,),
                        Center(
                          child: Text(
                            'Pandit Parjapati Milan',
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.width/30,),
                        Text(
                          'Register Now!',
                          style: TextStyle(
                            color: ConstHelper.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Get.width/30,),
                        TextFormField(
                          style: TextStyle(color: ConstHelper.whiteColor,),
                          controller: txtFullName,
                          focusNode: fullNameFocusNode,
                          validator: (value) {
                            if(value == null || value.trim().isEmpty)
                              {
                                return "Please enter the full name";
                              }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                          decoration: textFiledInputDecoration(labelText: 'Full Name',),
                        ),
                        SizedBox(height: Get.width/25,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InputDecorator(
                                decoration: textFiledInputDecoration(labelText: 'Gender',),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: ConstHelper.lightBlackColor,
                                    hint: Text(
                                      'Select Gender',
                                      style: TextStyle(
                                        color: ConstHelper.greyColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Male',
                                        child: Text(
                                          'Male',
                                          style: TextStyle(
                                            color: ConstHelper.whiteColor,
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Female',
                                        child: Text(
                                          'Female',
                                          style: TextStyle(
                                            color: ConstHelper.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      gender.value = value ?? '';
                                    },
                                    value: gender.trim().isEmpty ? null : gender.value,
                                    isExpanded: true,
                                    style: TextStyle(
                                      color: ConstHelper.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width/30,),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  EasyLoading.show(status: ConstHelper.pleaseWaitMsg,);
                                  await Future.delayed(Duration(milliseconds: 200,),);
                                  DateTime nowDateTime = await ConstHelper.getCurrentDateTime();
                                  EasyLoading.dismiss();
                                  await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    initialDate: dob.trim().isEmpty ? nowDateTime : DateTime.parse(dob.value),
                                  ).then((value) {
                                    if(value != null)
                                      {
                                        dob.value = value.toString();
                                      }
                                  },);
                                },
                                child: InputDecorator(
                                  decoration: textFiledInputDecoration(labelText: 'Date of Birth',),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dob.trim().isEmpty ? 'dd/mm/yyyy' : DateFormat('dd/MM/yyyy').format(DateTime.parse(dob.value)),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: dob.trim().isEmpty ? ConstHelper.greyColor : ConstHelper.whiteColor,
                                          fontWeight: dob.trim().isEmpty ? FontWeight.normal : FontWeight.bold,
                                          fontSize: dob.trim().isEmpty ? 12 : null,
                                        ),
                                      ),
                                      Icon(Icons.calendar_month,color: dob.trim().isEmpty ? ConstHelper.greyColor : ConstHelper.whiteColor,size: Get.width/18,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.width/25,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  EasyLoading.show(status: ConstHelper.pleaseWaitMsg,);
                                  await Future.delayed(Duration(milliseconds: 200,),);
                                  DateTime time = dobTime.isEmpty ? await ConstHelper.getCurrentDateTime() : DateFormat('hh:mm a').parse(dobTime.value);
                                  EasyLoading.dismiss();
                                  await showTimePicker(
                                    context: ConstHelper.navigatorKey.currentContext!,
                                    initialTime: TimeOfDay(hour: time.hour,minute: time.minute)
                                  ).then((value) {
                                    if(value != null)
                                    {
                                      dobTime.value = value.format(context);
                                    }
                                  },);
                                },
                                child: InputDecorator(
                                  decoration: textFiledInputDecoration(labelText: 'Time of Birth',),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dobTime.trim().isEmpty ? '--:-- --' : DateFormat('hh:mm a').format(DateFormat('hh:mm a').parse(dobTime.value)),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: dobTime.trim().isEmpty ? ConstHelper.greyColor : ConstHelper.whiteColor,
                                          fontWeight: dobTime.trim().isEmpty ? FontWeight.normal : FontWeight.bold,
                                          fontSize: dobTime.trim().isEmpty ? 12 : null,
                                        ),
                                      ),
                                      Icon(Icons.access_time_rounded,color: dobTime.trim().isEmpty ? ConstHelper.greyColor : ConstHelper.whiteColor,size: Get.width/18,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width/30,),
                            Expanded(
                              child: InputDecorator(
                                decoration: textFiledInputDecoration(labelText: 'My Community',),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: ConstHelper.lightBlackColor,
                                    focusColor: Colors.red,
                                    hint: Text(
                                      'Select Community',
                                      style: TextStyle(
                                        color: ConstHelper.greyColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    items: homeController.communityDataList
                                        .map((element) => DropdownMenuItem(
                                      value: element['id'], // Use a unique identifier
                                      child: Text(
                                        (element['community_name'] ?? '').toString(),
                                        style: TextStyle(
                                          color: ConstHelper.whiteColor,
                                        ),
                                      ),
                                    ))
                                        .toList(),
                                    onChanged: (value) async {
                                      EasyLoading.show(status: ConstHelper.pleaseWaitMsg);
                                      await Future.delayed(const Duration(milliseconds: 100));
                                      if (await ConstHelper.checkInternet()) {
                                        selectedCommunityData.value = homeController.communityDataList.firstWhere(
                                              (element) => element['id'] == value,
                                          orElse: () => {},
                                        );
                                        selectedGotraData.value = {};
                                        try {
                                          homeController.gotraDataListCommunityIdWise.value =
                                          await ApiHelper.apiHelper.getGotraDataListCommunityWise(
                                            comunityId: (selectedCommunityData['id'] ?? '0').toString(),
                                          );
                                        } catch (error) {
                                          homeController.gotraDataListCommunityIdWise.value = [];
                                          EasyLoading.dismiss();
                                          ConstHelper.errorDialog(
                                            text: ConstHelper.somethingErrorMsg,
                                            seconds: 10,
                                          );
                                        }
                                      } else {
                                        EasyLoading.dismiss();
                                        ConstHelper.errorDialog(
                                          text: ConstHelper.internetMsg,
                                          seconds: 10,
                                        );
                                      }
                                      EasyLoading.dismiss();
                                    },
                                    value: selectedCommunityData['id'], // Match the unique value
                                    isExpanded: true,
                                    style: TextStyle(
                                      color: ConstHelper.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.width/25,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InputDecorator(
                                decoration: textFiledInputDecoration(labelText: 'Gotra',),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<Map<dynamic, dynamic>>(
                                    dropdownColor: ConstHelper.lightBlackColor,
                                    focusColor: Colors.red,
                                    hint: Text(
                                      'Select Gotra',
                                      style: TextStyle(
                                        color: ConstHelper.greyColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    items: homeController.gotraDataListCommunityIdWise.map((element) {
                                      return DropdownMenuItem<Map<dynamic, dynamic>>(
                                        value: element, // Pass the full element as value
                                        child: Text(
                                          (element['gotra_name'] ?? '').toString(),
                                          style: TextStyle(
                                            color: ConstHelper.whiteColor,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) async {
                                      if (value != null) {
                                        selectedGotraData.value = value; // Explicitly handle the value as a Map
                                      }
                                    },
                                    value: homeController.gotraDataListCommunityIdWise.firstWhere(
                                          (element) => element['gotra_name'] == selectedGotraData['gotra_name'],
                                      orElse: () => null,
                                    ) as Map<dynamic, dynamic>?, // Explicitly cast to Map
                                    isExpanded: true,
                                    style: TextStyle(
                                      color: ConstHelper.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),


                              ),
                            ),
                            SizedBox(width: Get.width/30,),
                            Expanded(
                              child: InputDecorator(
                                decoration: textFiledInputDecoration(labelText: 'Education'),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: ConstHelper.lightBlackColor,
                                    hint: Text(
                                      'Select Education',
                                      style: TextStyle(
                                        color: ConstHelper.greyColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    items: homeController.educationDataList.map((element) {
                                      return DropdownMenuItem(
                                        value: element['id'], // Use a unique identifier like 'id'
                                        child: Text(
                                          (element['education_name'] ?? '').toString(),
                                          style: TextStyle(
                                            color: ConstHelper.whiteColor,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) async {
                                      // Find the full map by ID and update selectedEducationData
                                      selectedEducationData.value = homeController.educationDataList
                                          .firstWhere((element) => element['id'] == value);
                                    },
                                    value: selectedEducationData['id'], // Use the unique identifier for value
                                    isExpanded: true,
                                    style: TextStyle(
                                      color: ConstHelper.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: Get.width/25,),
                        TextFormField(
                          controller: txtOccupation,
                          style: TextStyle(color: ConstHelper.whiteColor,),
                          focusNode: occupationFocusNode,
                          validator: (value) {
                            if(value == null || value.trim().isEmpty)
                            {
                              return "Please enter the occupation";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                          decoration: textFiledInputDecoration(labelText: 'Occupation',),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: Get.width/25,),
                        TextFormField(
                          controller: txtEmail,
                          style: TextStyle(color: ConstHelper.whiteColor,),
                          focusNode: emailFocusNode,
                          validator: (value) {
                            if(value == null || value.trim().isEmpty)
                            {
                              return "Please enter the email";
                            }
                            else if(!(ConstHelper.constHelper.validateEmail(email: value)))
                            {
                              return "Please enter the valid email";
                            }
                            return null;
                          },
                          decoration: textFiledInputDecoration(labelText: 'Email',),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: Get.width/25,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: txtMobileNo,
                                style: TextStyle(color: ConstHelper.whiteColor,),
                                focusNode: mobileNoFocusNode,
                                validator: (value) {
                                  if(value == null || value.trim().isEmpty)
                                  {
                                    return "Please enter the mobile no.";
                                  }
                                  else if(value.length != 10)
                                  {
                                    return "Please enter the valid mobile no.";
                                  }
                                  return null;
                                },
                                decoration: textFiledInputDecoration(labelText: 'Mobile No.',),
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                            SizedBox(width: Get.width/30,),
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(color: ConstHelper.whiteColor,),
                                controller: txtWhatsappNo,
                                focusNode: whatsappNoFocusNode,
                                validator: (value) {
                                  if(value == null || value.trim().isEmpty)
                                  {
                                    return "Please enter the whatsapp no.";
                                  }
                                  else if(value.length != 10)
                                  {
                                    return "Please enter the valid whatsapp no.";
                                  }
                                  return null;
                                },
                                decoration: textFiledInputDecoration(labelText: 'WhatsApp No.',),
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.width/25,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(color: ConstHelper.whiteColor,),
                                controller: txtMainContactNo,
                                focusNode: mainContactNoFocusNode,
                                validator: (value) {
                                  if(value == null || value.trim().isEmpty)
                                  {
                                    return "Please enter the main contact no.";
                                  }
                                  else if(value.length != 10)
                                  {
                                    return "Please enter the valid main contact no.";
                                  }
                                  return null;
                                },
                                decoration: textFiledInputDecoration(labelText: 'Main Contact No.',),
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                            SizedBox(width: Get.width/30,),
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(color: ConstHelper.whiteColor,),
                                controller: txtFatherName,
                                focusNode: fatherNameFocusNode,
                                validator: (value) {
                                  if(value == null || value.trim().isEmpty)
                                  {
                                    return "Please enter the father name";
                                  }
                                  return null;
                                },
                                textCapitalization: TextCapitalization.words,
                                decoration: textFiledInputDecoration(labelText: 'Father Name',),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.width/30,),
                        Text(
                          'Height',
                          style: TextStyle(
                            color: ConstHelper.whiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: Get.width/30,),
                        Row(
                          children: [
                            Expanded(
                              child: InputDecorator(
                                decoration: textFiledInputDecoration(labelText: 'Feet',),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: ConstHelper.lightBlackColor,
                                    hint: Text(
                                      'Feet',
                                      style: TextStyle(
                                        color: ConstHelper.greyColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    items: heightFeetList.map((element) => DropdownMenuItem(
                                      value: '$element',
                                      child: Text(
                                        '$element',
                                        style: TextStyle(
                                          color: ConstHelper.whiteColor,
                                        ),
                                      ),
                                    ),).toList(),
                                    onChanged: (value) {
                                      heightFeet.value = value ?? '';
                                    },
                                    value: heightFeet.trim().isEmpty ? null : heightFeet.value,
                                    isExpanded: true,
                                    style: TextStyle(
                                      color: ConstHelper.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width/60,),
                            Expanded(
                              child: InputDecorator(
                                decoration: textFiledInputDecoration(labelText: 'Inch',),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: ConstHelper.lightBlackColor,
                                    hint: Text(
                                      'Inch',
                                      style: TextStyle(
                                        color: ConstHelper.greyColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    items: heightInchList.map((element) => DropdownMenuItem(
                                      value: '$element',
                                      child: Text(
                                        '$element',
                                        style: TextStyle(
                                          color: ConstHelper.whiteColor,
                                        ),
                                      ),
                                    ),).toList(),
                                    onChanged: (value) {
                                      heightInch.value = value ?? '';
                                    },
                                    value: heightInch.trim().isEmpty ? null : heightInch.value,
                                    isExpanded: true,
                                    style: TextStyle(
                                      color: ConstHelper.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.width/25,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(color: ConstHelper.whiteColor,),
                                controller: txtReferenceName,
                                focusNode: referenceNameFocusNode,
                                validator: (value) {
                                  if(value == null || value.trim().isEmpty)
                                  {
                                    return "Please enter the reference name";
                                  }
                                  return null;
                                },
                                textCapitalization: TextCapitalization.words,
                                decoration: textFiledInputDecoration(labelText: 'Reference Name',),
                              ),
                            ),
                            SizedBox(width: Get.width/30,),
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(color: ConstHelper.whiteColor,),
                                controller: txtReferenceMobileNo,
                                focusNode: referenceMobileNoFocusNode,
                                validator: (value) {
                                  if(value == null || value.trim().isEmpty)
                                  {
                                    return "Please enter the reference mobile no.";
                                  }
                                  else if(value.length != 10)
                                  {
                                    return "Please enter the valid reference mobile no.";
                                  }
                                  return null;
                                },
                                decoration: textFiledInputDecoration(labelText: 'Reference Mobile No.',),
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.width/20,),
                        Row(
                          children: [
                            Expanded(
                              child: InputDecorator(
                                decoration: textFiledInputDecoration(labelText: 'Physical Disability (if any)',),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: ConstHelper.lightBlackColor,
                                    hint: Text(
                                      'Select one',
                                      style: TextStyle(
                                        color: ConstHelper.greyColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    items: physicalAbilityList.map((element) => DropdownMenuItem(
                                      value: '$element',
                                      child: Text(
                                        '$element',
                                        style: TextStyle(
                                          color: ConstHelper.whiteColor,
                                        ),
                                      ),
                                    ),).toList(),
                                    onChanged: (value) {
                                      selectedPhysicalAbility.value = value ?? '';
                                    },
                                    value: selectedPhysicalAbility.trim().isEmpty ? null : selectedPhysicalAbility.value,
                                    isExpanded: true,
                                    style: TextStyle(
                                      color: ConstHelper.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width/60,),
                            Expanded(
                              child: InputDecorator(
                                decoration: textFiledInputDecoration(labelText: 'Have you been married before?',),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: ConstHelper.lightBlackColor,
                                    hint: Text(
                                      'Select one',
                                      style: TextStyle(
                                        color: ConstHelper.greyColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    items: marriedBeforeList.map((element) => DropdownMenuItem(
                                      value: '$element',
                                      child: Text(
                                        '$element',
                                        style: TextStyle(
                                          color: ConstHelper.whiteColor,
                                        ),
                                      ),
                                    ),).toList(),
                                    onChanged: (value) {
                                      selectedMarriedBefore.value = value ?? '';
                                    },
                                    value: selectedMarriedBefore.trim().isEmpty ? null : selectedMarriedBefore.value,
                                    isExpanded: true,
                                    style: TextStyle(
                                      color: ConstHelper.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.width/25,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(color: ConstHelper.whiteColor,),
                                controller: txtWorkingCity,
                                focusNode: workingCityFocusNode,
                                validator: (value) {
                                  if(value == null || value.trim().isEmpty)
                                  {
                                    return "Please enter the working city";
                                  }
                                  return null;
                                },
                                textCapitalization: TextCapitalization.words,
                                decoration: textFiledInputDecoration(labelText: 'Working City',),
                              ),
                            ),
                            SizedBox(width: Get.width/30,),
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(color: ConstHelper.whiteColor,),
                                controller: txtPlaceOfBirth,
                                focusNode: placeOfBirthFocusNode,
                                validator: (value) {
                                  if(value == null || value.trim().isEmpty)
                                  {
                                    return "Please enter the place of birth";
                                  }
                                  return null;
                                },
                                textCapitalization: TextCapitalization.words,
                                decoration: textFiledInputDecoration(labelText: 'Place of Birth',),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.width/25,),
                        TextFormField(
                          controller: txtAddress,
                          style: TextStyle(color: ConstHelper.whiteColor,),
                          focusNode: addressFocusNode,
                          validator: (value) {
                            if(value == null || value.trim().isEmpty)
                            {
                              return "Please enter the permanent address";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: ConstHelper.whiteColor,),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: ConstHelper.whiteColor,),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: ConstHelper.whiteColor,),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: Get.width/65),
                            labelStyle: TextStyle(color: ConstHelper.cementColor,),
                            label: Text(
                              'Permanante Address',
                              maxLines: 2,
                              style: TextStyle(color: ConstHelper.whiteColor,),
                            ),
                            errorMaxLines: 5,
                            counterText: '',
                          ),
                          maxLines: 4,
                        ),
                        SizedBox(height: Get.width/25,),
                        TextFormField(
                          controller: txtImportantNote,
                          style: TextStyle(color: ConstHelper.whiteColor,),
                          focusNode: importantNoteFocusNode,
                          validator: (value) {
                            if(value == null || value.trim().isEmpty)
                            {
                              return "Please enter the important note";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: ConstHelper.whiteColor,),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: ConstHelper.whiteColor,),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: ConstHelper.whiteColor,),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: Get.width/65),
                            labelStyle: TextStyle(color: ConstHelper.cementColor,),
                            label: Text(
                              'Important Note',
                              maxLines: 2,
                              style: TextStyle(color: ConstHelper.whiteColor,),
                            ),
                            errorMaxLines: 5,
                            counterText: '',
                          ),
                          maxLines: 4,
                        ),
                        SizedBox(height: Get.width/30,),
                        Text(
                          'Photo',
                          style: TextStyle(
                            color: ConstHelper.whiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: Get.width/30,),
                        Center(
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
                                        border: Border.all(color: ConstHelper.whiteColor,),
                                        shape: BoxShape.circle,
                                        image: selectedPhotoPath.trim().isEmpty ? null : DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(File(selectedPhotoPath.value),),
                                        )
                                      ),
                                      child: selectedPhotoPath.trim().isNotEmpty ? null : Center(child: SvgPicture.asset('assets/image/personWithRoundedSVG.svg',height: Get.width/3.5,width: Get.width/3.5,fit: BoxFit.contain,color: ConstHelper.cementColor,)),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: Get.width/50,bottom: Get.width/50,),
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
                        ),
                        SizedBox(height: Get.width/15,),
                        GestureDetector(
                          onTap: () async {
                            EasyLoading.show(status: ConstHelper.pleaseWaitMsg,);
                            await Future.delayed(Duration(milliseconds: 200,),);
                            fullNameFocusNode.unfocus();
                            occupationFocusNode.unfocus();
                            emailFocusNode.unfocus();
                            mobileNoFocusNode.unfocus();
                            whatsappNoFocusNode.unfocus();
                            mainContactNoFocusNode.unfocus();
                            fatherNameFocusNode.unfocus();
                            referenceNameFocusNode.unfocus();
                            referenceMobileNoFocusNode.unfocus();
                            workingCityFocusNode.unfocus();
                            placeOfBirthFocusNode.unfocus();
                            addressFocusNode.unfocus();
                            importantNoteFocusNode.unfocus();
                            print('saasdasd ');
                            if(!(await ConstHelper.checkInternet()))
                              {
                                EasyLoading.dismiss();
                                ConstHelper.errorDialog(text: ConstHelper.internetMsg, seconds: 10,);
                              }
                            else
                              {
                                // await Future.delayed(Duration(milliseconds: 10,),);
                                // EasyLoading.dismiss();
                                formKey.currentState!.validate();
                                if(txtFullName.text.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  fullNameFocusNode.requestFocus();
                                }
                                else if(gender.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  ConstHelper.errorDialog(text: 'Please select gender', seconds: 10,);
                                }
                                else if(dob.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  ConstHelper.errorDialog(text: 'Please select date of birth', seconds: 10,);
                                }
                                else if(dobTime.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  ConstHelper.errorDialog(text: 'Please select date of time', seconds: 10,);
                                }
                                else if(selectedCommunityData.isEmpty || selectedCommunityData['community_name'] == null || selectedCommunityData['community_name'].toString().trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  ConstHelper.errorDialog(text: 'Please select community', seconds: 10,);
                                }
                                else if(selectedGotraData.isEmpty || selectedGotraData['gotra_name'] == null || selectedGotraData['gotra_name'].toString().trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  ConstHelper.errorDialog(text: 'Please select gotra', seconds: 10,);
                                }
                                else if(selectedEducationData.isEmpty || selectedEducationData['education_name'] == null || selectedEducationData['education_name'].toString().trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  ConstHelper.errorDialog(text: 'Please select education', seconds: 10,);
                                }
                                else if(txtOccupation.text.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  occupationFocusNode.requestFocus();
                                }
                                else if(txtEmail.text.trim().isEmpty || (!(ConstHelper.constHelper.validateEmail(email: txtEmail.text.trim(),))))
                                {
                                  EasyLoading.dismiss();
                                  emailFocusNode.requestFocus();
                                }
                                else if(txtMobileNo.text.trim().isEmpty || (txtMobileNo.text.length != 10))
                                {
                                  EasyLoading.dismiss();
                                  mobileNoFocusNode.requestFocus();
                                }
                                else if(txtWhatsappNo.text.trim().isEmpty || (txtWhatsappNo.text.length != 10))
                                {
                                  EasyLoading.dismiss();
                                  whatsappNoFocusNode.requestFocus();
                                }
                                else if(txtMainContactNo.text.trim().isEmpty || (txtMainContactNo.text.length != 10))
                                {
                                  EasyLoading.dismiss();
                                  mainContactNoFocusNode.requestFocus();
                                }
                                else if(txtFatherName.text.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  fatherNameFocusNode.requestFocus();
                                }
                                else if(heightFeet.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  ConstHelper.errorDialog(text: 'Please select height feet', seconds: 10,);
                                }
                                else if(heightInch.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  ConstHelper.errorDialog(text: 'Please select height inch', seconds: 10,);
                                }
                                else if(txtReferenceName.text.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  referenceNameFocusNode.requestFocus();
                                }
                                else if(txtReferenceMobileNo.text.trim().isEmpty || (txtReferenceMobileNo.text.length != 10))
                                {
                                  EasyLoading.dismiss();
                                  referenceMobileNoFocusNode.requestFocus();
                                }
                                else if(selectedPhysicalAbility.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  ConstHelper.errorDialog(text: 'Please select physical disability (if any)', seconds: 10,);
                                }
                                else if(selectedMarriedBefore.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  ConstHelper.errorDialog(text: 'Please select Have you been married before?', seconds: 10,);
                                }
                                else if(txtWorkingCity.text.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  workingCityFocusNode.requestFocus();
                                }
                                else if(txtPlaceOfBirth.text.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  placeOfBirthFocusNode.requestFocus();
                                }
                                else if(txtAddress.text.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  addressFocusNode.requestFocus();
                                }
                                else if(txtImportantNote.text.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  importantNoteFocusNode.requestFocus();
                                }
                                else if(selectedPhotoPath.trim().isEmpty)
                                {
                                  EasyLoading.dismiss();
                                  ConstHelper.errorDialog(text: 'Please take one photo', seconds: 10,);
                                }
                                else if(formKey.currentState!.validate())
                                {
                                  try {
                                    MembersDataModel membersDataModel = MembersDataModel(
                                      name: txtFullName.text,
                                      profileGender: gender.value,
                                      profileDateOfBirth: DateTime.parse(dob.value),
                                      profileTimeOfBirth: DateFormat('hh:mm').format(DateFormat('hh:mm a').parse(dobTime.value)),
                                      profileComunityName: (selectedCommunityData['id'] ?? '0').toString(),
                                      profileGotra: (selectedGotraData['gotra_name'] ?? '').toString(),
                                      profileEducation: (selectedEducationData['education_name'] ?? '').toString(),
                                      profileOccupation: txtOccupation.text,
                                      email: txtEmail.text,
                                      profileMobile: txtMobileNo.text,
                                      profileWhatsapp: txtWhatsappNo.text,
                                      profileMainContactNum: txtMainContactNo.text,
                                      profileHeight: heightFeet.value,
                                      profileHeightInch: heightInch.value,
                                      profileFatherFullName: txtFatherName.text,
                                      profileRefContactName: txtReferenceName.text,
                                      profileRefContactMobile: txtReferenceMobileNo.text,
                                      profilePhysicalDisablity: selectedPhysicalAbility.value,
                                      profileHaveMarriedBefore: selectedMarriedBefore.value,
                                      profileWorkingCity: txtWorkingCity.text,
                                      profilePlaceOfBirth: txtPlaceOfBirth.text,
                                      profilePermanentAddress: txtAddress.text,
                                      profileNote: txtImportantNote.text,
                                      profilePhoto: selectedPhotoPath.value,
                                    );
                                    print('aasdasdas ${membersDataModel.toJson()}');
                                    print('aasdasdas 11313');
                                    await ApiHelper.apiHelper.newSignup(membersDataModel: membersDataModel,).then((value) async {
                                      print('sadasdasd $value');
                                      if(value.isNotEmpty)
                                      {
                                        if(value['code'] == 200)
                                        {
                                          // await Future.delayed(Duration(milliseconds: 300,),);
                                          Get.back();
                                          EasyLoading.dismiss();
                                          ConstHelper.successDialog(text: value['msg'] ?? 'Your profile is created successfully.', seconds: 10,);
                                        }
                                        else
                                        {
                                          EasyLoading.dismiss();
                                          ConstHelper.errorDialog(text: value['msg'] ?? ConstHelper.somethingErrorMsg, seconds: 10,);
                                        }
                                      }
                                      else
                                      {
                                        EasyLoading.dismiss();
                                        ConstHelper.errorDialog(text: ConstHelper.somethingErrorMsg, seconds: 10,);
                                      }
                                    },);
                                  } catch(error) {
                                    print('saasdasd $error');
                                    EasyLoading.dismiss();
                                    ConstHelper.errorDialog(text: ConstHelper.somethingErrorMsg, seconds: 10,);
                                  }
                                }
                              }

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
                              'Register',
                              style: TextStyle(
                                color: ConstHelper.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.width/25,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration textFiledInputDecoration({required String labelText, Color? borderColor,})
  {
    borderColor = borderColor ?? ConstHelper.cementColor;
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: ConstHelper.whiteColor,),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: ConstHelper.whiteColor,),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: ConstHelper.whiteColor,),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,),
      labelStyle: TextStyle(color: ConstHelper.cementColor,),
      label: Text(
        labelText,
        maxLines: 2,
        style: TextStyle(color: ConstHelper.whiteColor,),
      ),
      errorMaxLines: 5,
      counterText: '',
    );
  }
}

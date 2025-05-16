import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controllers/HomeController.dart';
import '../../Models/MembersDataModel.dart';
import '../../Utils/ConstHelper.dart';

import '../../Utils/ApiHelper.dart';
import '../HomeScreen/HomePage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  HomeController homeController = Get.put(HomeController());
  RxBool advanceSettingOpen = false.obs;
  RxList<String> minHeightList = [
    '4.0',
    '4.1',
    '4.2',
    '4.3',
    '4.4',
    '4.5',
    '4.6',
    '4.7',
    '4.8',
    '4.9',
    '4.10',
    '4.11',
    '5.0',
    '5.1',
    '5.2',
    '5.3',
    '5.4',
    '5.5',
    '5.6',
    '5.7',
    '5.8',
    '5.9',
    '5.10',
    '5.11',
  ].obs;
  RxList<String> maxHeightList = [
    '6.0',
    '6.1',
    '6.2',
    '6.3',
    '6.4',
    '6.5',
    '6.6',
    '6.7',
    '6.8',
    '6.9',
    '6.10',
    '6.11',
    '7.0',
  ].obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings",style: TextStyle(fontSize: Get.width*0.05,letterSpacing:1,color: ConstHelper.blackColor,fontWeight: FontWeight.bold,),),
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width/30,),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.width/20,),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Height',
                      style: TextStyle(
                        color: ConstHelper.blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: Get.width*0.05,
                      ),
                    ),
                    Text(
                      '  (In feet / inches)',
                      style: TextStyle(
                        color: ConstHelper.greyColor,
                        fontSize: Get.width*0.04,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: Get.width/30,),
                // DropdownButtonHideUnderline(
                //   child: DropdownButton2<String>(
                //     isExpanded: true,
                //     items: heightList
                //         .map((String item) => DropdownMenuItem<String>(
                //       value: item,
                //       child: Text(
                //         item,
                //         style: TextStyle(
                //           fontSize: Get.width*0.04,
                //           fontWeight: FontWeight.bold,
                //           color: ConstHelper.orangeColor,
                //         ),
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ))
                //         .toList(),
                //     value: selectedHeightValue.value,
                //     onChanged: (String? value) {
                //       setState(() {
                //         selectedHeightValue.value = value.toString();
                //       });
                //     },
                //     buttonStyleData: ButtonStyleData(
                //       height: 50,
                //       width: Get.width,
                //       padding: const EdgeInsets.only(left: 14, right: 14),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(14),
                //         border: Border.all(
                //             color: ConstHelper.orangeColor
                //         ),
                //       ),
                //       elevation: 0,
                //     ),
                //     iconStyleData: IconStyleData(
                //       icon: Icon(
                //         Icons.keyboard_arrow_down,
                //       ),
                //       iconSize: 18,
                //       iconEnabledColor: ConstHelper.orangeColor,
                //       iconDisabledColor: Colors.grey,
                //     ),
                //     dropdownStyleData: DropdownStyleData(
                //       width: Get.width ,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(14),
                //       ),
                //       offset: const Offset(-20, 0),
                //       scrollbarTheme: ScrollbarThemeData(
                //         radius: const Radius.circular(40),
                //         thickness: MaterialStateProperty.all<double>(6),
                //         thumbVisibility: MaterialStateProperty.all<bool>(true),
                //       ),
                //     ),
                //     menuItemStyleData: const MenuItemStyleData(
                //       height: 40,
                //       padding: EdgeInsets.only(left: 14, right: 14),
                //     ),
                //   ),
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             'Select Height',
                //             style: TextStyle(
                //               color: ConstHelper.blackColor,
                //               fontWeight: FontWeight.w500,
                //               fontSize: Get.width*0.05,
                //             ),
                //           ),
                //           Text(
                //             '(In feet / inches)',
                //             style: TextStyle(
                //               color: ConstHelper.greyColor,
                //               fontSize: Get.width*0.04,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //
                //     Row(
                //       children: [
                //         Text(
                //           'Feet',
                //           style: TextStyle(
                //             color: ConstHelper.orangeColor,
                //             fontWeight: FontWeight.w500,
                //             fontSize: 16,
                //           ),
                //         ),
                //         SizedBox(width: Get.width/60,),
                //         SvgPicture.asset('assets/image/dropDownSecSVG.svg',height: Get.width/35,width: Get.width/35,color: ConstHelper.orangeColor,),
                //       ],
                //     ),
                //   ],
                // ),
                SizedBox(height: Get.width/30,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Minimum Height',
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontSize: Get.width*0.04,
                            ),
                          ),
                          SizedBox(height: Get.width/50,),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint:  Row(
                                children: [
                                  Icon(
                                    Icons.list,
                                    size: 16,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Select Age',
                                      style: TextStyle(
                                        fontSize: Get.width*0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellow,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: minHeightList
                                  .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: Get.width*0.04,
                                    fontWeight: FontWeight.bold,
                                    color: ConstHelper.orangeColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                                  .toList(),
                              value: homeController.selectedMinHeightValue.value,
                              onChanged: (String? value) {
                                setState(() {
                                  homeController.selectedMinHeightValue.value = value.toString();
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: Get.width,
                                padding: const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                      color: ConstHelper.orangeColor
                                  ),
                                ),
                                elevation: 0,
                              ),
                              iconStyleData: IconStyleData(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                iconSize: 18,
                                iconEnabledColor: ConstHelper.orangeColor,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                width: Get.width / 2.5,
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
                        ],
                      ),
                    ),
                    SizedBox(width: Get.width/20,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Maximum Height',
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontSize: Get.width*0.04,
                            ),
                          ),
                          SizedBox(height: Get.width/50,),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint:  Row(
                                children: [
                                  Icon(
                                    Icons.list,
                                    size: 16,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Select Age',
                                      style: TextStyle(
                                        fontSize: Get.width*0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellow,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: maxHeightList
                                  .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: Get.width*0.04,
                                    fontWeight: FontWeight.bold,
                                    color: ConstHelper.orangeColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                                  .toList(),
                              value: homeController.selectedMaxHeightValue.value,
                              onChanged: (String? value) {
                                setState(() {
                                  homeController.selectedMaxHeightValue.value = value.toString();
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: Get.width,
                                padding: const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                      color: ConstHelper.orangeColor
                                  ),
                                ),
                                elevation: 0,
                              ),
                              iconStyleData: IconStyleData(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                iconSize: 18,
                                iconEnabledColor: ConstHelper.orangeColor,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                width: Get.width / 2.5,
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
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.width/15,),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Yearly Income',
                      style: TextStyle(
                        color: ConstHelper.blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: Get.width*0.05,
                      ),
                    ),
                    Text(
                      '  (in Lakh)',
                      style: TextStyle(
                        color: ConstHelper.greyColor,
                        fontSize: Get.width*0.04,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Minimum 1 Lakh',
                      style: TextStyle(
                        color: ConstHelper.blackColor,
                        fontSize: Get.width*0.04,
                      ),
                    ),
                    Text(
                      'Maximum 300 Lakh',
                      style: TextStyle(
                        color: ConstHelper.blackColor,
                        fontSize: Get.width*0.04,
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => SliderTheme(
                    data: SliderThemeData(
                      tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 0),
                      trackShape: CustomTrackShape(),
                    ),
                    child: Stack(
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.only(top: Get.width/15,right: Get.width/55,left: Get.width/55,),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       for(int i=1; i<=20; i=i+1)
                        //       Padding(
                        //         padding: EdgeInsets.only(left: i==1 ? 0 : Get.width/50,),
                        //         child: Column(
                        //           children: [
                        //             Container(
                        //               width: 3,
                        //               height: 12,
                        //               decoration: BoxDecoration(
                        //                 color: (i == homeController.yearlyIncomeStart.round() || i == homeController.yearlyIncomeEnd.round()) ? ConstHelper.orangeColor : ConstHelper.cementColor,
                        //                 borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),),
                        //               ),
                        //             ),
                        //             Text(
                        //               '$i',
                        //               style: TextStyle(
                        //                 color: (i == homeController.yearlyIncomeStart.round() || i == homeController.yearlyIncomeEnd.round()) ? ConstHelper.orangeColor : ConstHelper.cementColor,
                        //                 fontWeight: FontWeight.w900,
                        //                 fontSize: 8,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        RangeSlider(
                          divisions: 300,
                          activeColor: ConstHelper.orangeColor,
                          inactiveColor: ConstHelper.blackColor,
                          values: RangeValues(homeController.yearlyIncomeStart.value, homeController.yearlyIncomeEnd.value),
                          labels: RangeLabels(homeController.yearlyIncomeStart.value.round().toString(), homeController.yearlyIncomeEnd.value.round().toString()),
                          onChanged: (value) {
                            setState(() {
                              homeController.yearlyIncomeStart.value = value.start;
                              homeController.yearlyIncomeEnd.value = value.end;
                            });
                          },
                          min: 1.0,
                          max: 300.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      homeController.yearlyIncomeStart.value.toStringAsFixed(0) + " Lakh",
                      style: TextStyle(
                        color: ConstHelper.blackColor,
                        fontSize: Get.width*0.04,
                      ),
                    ),
                    Text(
                      homeController.yearlyIncomeEnd.value.toStringAsFixed(0) + " Lakh",
                      style: TextStyle(
                        color: ConstHelper.blackColor,
                        fontSize: Get.width*0.04,
                      ),
                    ),
                  ],
                ),),
                SizedBox(height: Get.width/15,),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Age',
                      style: TextStyle(
                        color: ConstHelper.blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: Get.width*0.05,
                      ),
                    ),
                    Text(
                      '  (in years)',
                      style: TextStyle(
                        color: ConstHelper.greyColor,
                        fontSize: Get.width*0.04,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: Get.width/30,),
                // DropdownButtonHideUnderline(
                //   child: DropdownButton2<String>(
                //     isExpanded: true,
                //     hint: const Row(
                //       children: [
                //         Icon(
                //           Icons.list,
                //           size: 16,
                //           color: Colors.yellow,
                //         ),
                //         SizedBox(
                //           width: 4,
                //         ),
                //         Expanded(
                //           child: Text(
                //             'Select Age',
                //             style: TextStyle(
                //               fontSize: Get.width*0.04,
                //               fontWeight: FontWeight.bold,
                //               color: Colors.yellow,
                //             ),
                //             overflow: TextOverflow.ellipsis,
                //           ),
                //         ),
                //       ],
                //     ),
                //     items: ageList
                //         .map((String item) => DropdownMenuItem<String>(
                //       value: item,
                //       child: Text(
                //         item,
                //         style: TextStyle(
                //           fontSize: Get.width*0.04,
                //           fontWeight: FontWeight.bold,
                //           color: ConstHelper.orangeColor,
                //         ),
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ))
                //         .toList(),
                //     value: selectedValue.value,
                //     onChanged: (String? value) {
                //       setState(() {
                //         selectedValue.value = value.toString();
                //       });
                //     },
                //     buttonStyleData: ButtonStyleData(
                //       height: 50,
                //       width: Get.width,
                //       padding: const EdgeInsets.only(left: 14, right: 14),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(14),
                //         border: Border.all(
                //             color: ConstHelper.orangeColor
                //         ),
                //       ),
                //       elevation: 0,
                //     ),
                //     iconStyleData: IconStyleData(
                //       icon: Icon(
                //         Icons.keyboard_arrow_down,
                //       ),
                //       iconSize: 18,
                //       iconEnabledColor: ConstHelper.orangeColor,
                //       iconDisabledColor: Colors.grey,
                //     ),
                //     dropdownStyleData: DropdownStyleData(
                //       width: Get.width ,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(14),
                //       ),
                //       offset: const Offset(-20, 0),
                //       scrollbarTheme: ScrollbarThemeData(
                //         radius: const Radius.circular(40),
                //         thickness: MaterialStateProperty.all<double>(6),
                //         thumbVisibility: MaterialStateProperty.all<bool>(true),
                //       ),
                //     ),
                //     menuItemStyleData: const MenuItemStyleData(
                //       height: 40,
                //       padding: EdgeInsets.only(left: 14, right: 14),
                //     ),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Minimum 18 years',
                      style: TextStyle(
                        color: ConstHelper.blackColor,
                        fontSize: Get.width*0.04,
                      ),
                    ),
                    Text(
                      'Maximum 50 years',
                      style: TextStyle(
                        color: ConstHelper.blackColor,
                        fontSize: Get.width*0.04,
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => SliderTheme(
                    data: SliderThemeData(
                      tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 0),
                      trackShape: CustomTrackShape(),
                    ),
                    child: Stack(
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.only(top: Get.width/15,right: Get.width/63,left: Get.width/63,),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       for(int i=18; i<=50; i=i+2)
                        //       Padding(
                        //         padding: EdgeInsets.only(left: i==18 ? 0 : Get.width/36.5,),
                        //         child: Column(
                        //           children: [
                        //             Container(
                        //               width: 3,
                        //               height: 12,
                        //               decoration: BoxDecoration(
                        //                 color: (i == homeController.selectedAge.round()) ? ConstHelper.orangeColor : ConstHelper.cementColor,
                        //                 borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),),
                        //               ),
                        //             ),
                        //             Text(
                        //               '$i',
                        //               style: TextStyle(
                        //                 color: (i == homeController.selectedAge.round()) ? ConstHelper.orangeColor : ConstHelper.cementColor,
                        //                 fontWeight: FontWeight.w900,
                        //                 fontSize: 8,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: Get.width/43,),
                        //   child: Slider(
                        //     label: "${homeController.selectedAge.round()}",
                        //     value: homeController.selectedAge.value,
                        //     // allowedInteraction: SliderInteraction.tapOnly,
                        //     onChanged: (value) {
                        //       homeController.selectedAge.value = value;
                        //     },
                        //     divisions: 32,
                        //     activeColor: ConstHelper.orangeColor,
                        //     inactiveColor: ConstHelper.blackColor,
                        //     min: 18,
                        //     max: 50,
                        //   ),
                        // ),
                        RangeSlider(
                          divisions: 32,
                          activeColor: ConstHelper.orangeColor,
                          inactiveColor: ConstHelper.blackColor,
                          values: RangeValues(homeController.selectedAgeStart.value, homeController.selectedAgeEnd.value),
                          labels: RangeLabels(homeController.selectedAgeStart.value.round().toString(), homeController.selectedAgeEnd.value.round().toString()),
                          onChanged: (value) {
                            setState(() {
                              homeController.selectedAgeStart.value = value.start;
                              homeController.selectedAgeEnd.value = value.end;
                            });
                          },
                          min: 18.0,
                          max: 50.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      homeController.selectedAgeStart.value.toStringAsFixed(0) + " Year",
                      style: TextStyle(
                        color: ConstHelper.blackColor,
                        fontSize: Get.width*0.04,
                      ),
                    ),
                    Text(
                      homeController.selectedAgeEnd.value.toStringAsFixed(0) + " Year",
                      style: TextStyle(
                        color: ConstHelper.blackColor,
                        fontSize: Get.width*0.04,
                      ),
                    ),
                  ],
                ),),
                SizedBox(height: Get.width/15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Gotra',
                          style: TextStyle(
                            color: ConstHelper.blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: Get.width*0.05,
                          ),
                        ),
                        Text(
                          '  (to exclude)',
                          style: TextStyle(
                            color: ConstHelper.greyColor,
                            fontSize: Get.width*0.04,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: Get.width/20,),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    items: homeController.gotraDataList
                        .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: Get.width*0.04,
                          fontWeight: FontWeight.bold,
                          color: ConstHelper.orangeColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                        .toList(),
                    value: homeController.selectedGotra.value,
                    onChanged: (String? value) {
                      setState(() {
                        homeController.selectedGotra.value = value.toString();
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: Get.width,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: ConstHelper.orangeColor
                        ),
                      ),
                      elevation: 0,
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      iconSize: 18,
                      iconEnabledColor: ConstHelper.orangeColor,
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
                // Container(
                //   width: Get.width,
                //   decoration: BoxDecoration(
                //     color: ConstHelper.blackColor,
                //     borderRadius: BorderRadius.circular(6),
                //     boxShadow: [
                //       BoxShadow(
                //         color: ConstHelper.greyColor.withOpacity(0.5),
                //         offset: const Offset(0, 5),
                //         blurRadius: 1,
                //       ),
                //     ],
                //   ),
                //   alignment: Alignment.center,
                //   padding: EdgeInsets.symmetric(vertical: Get.width/30,horizontal: Get.width/20,),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Text(
                //           "No Exclude",
                //           style: TextStyle(
                //             fontSize: 16,
                //             color: ConstHelper.whiteColor,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //       ),
                //       SvgPicture.asset('assets/image/dropDownSVG.svg',height: Get.width/22,width: Get.width/22,color: ConstHelper.whiteColor,),
                //     ],
                //   ),
                // ),
                SizedBox(height: Get.width/20,),
                Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ConstHelper.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: ConstHelper.greyColor.withOpacity(0.2),
                        offset: const Offset(2, 4),
                        blurRadius: 3,
                      ),
                      BoxShadow(
                        color: ConstHelper.greyColor.withOpacity(0.2),
                        offset: const Offset(-2, 0.1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Obx(
                    () => ExpansionTile(
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Advanced Setting',
                            style: TextStyle(
                              color: ConstHelper.blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width*0.04,
                            ),
                          ),
                          Text(
                            'Tap on plus icon to explore advance settings',
                            style: TextStyle(
                              color: ConstHelper.greyColor,
                              fontSize: Get.width*0.03,
                            ),
                          ),
                        ],
                      ),
                      onExpansionChanged: (value) {
                        advanceSettingOpen.value = value;
                      },
                      tilePadding: EdgeInsets.only(left: Get.width/30,right: Get.width/50,),
                      trailing: Icon(advanceSettingOpen.value ? Icons.remove_rounded : Icons.add_rounded,color: ConstHelper.orangeColor,size: Get.width/12,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: ConstHelper.cementColor,width: 0.3,),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: ConstHelper.cementColor,width: 0.3,),
                      ),
                      childrenPadding: EdgeInsets.symmetric(horizontal: Get.width/30,),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.width/80,),
                        Container(
                          width: Get.width,
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        SizedBox(height: Get.width/30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Select Education',
                              style: TextStyle(
                                color: ConstHelper.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width*0.04,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                homeController.selectAll.value = !homeController.selectAll.value;
                                for(int i = 0; i < homeController.educationDataList.length; i++){
                                  if(homeController.selectAll.value == true){
                                    homeController.educationDataList[i]['selected'] = true;
                                  } else {
                                    homeController.educationDataList[i]['selected'] = false;
                                  }
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: homeController.selectAll.value ? ConstHelper.orangeColor : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: homeController.selectAll.value ?  Colors.transparent : ConstHelper.cementColor,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(Get.width/300,),
                                    child: homeController.selectAll.value ? Icon(Icons.done_rounded,color: ConstHelper.whiteColor,size: Get.width/22,) : Container(
                                      height: Get.width/22,
                                      width: Get.width/22,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width / 50,
                                  ),
                                  Text("Select All",style: TextStyle(
                                  color: homeController.selectAll.value ? ConstHelper.orangeColor : ConstHelper.blackColor,
                                     fontWeight: FontWeight.w500,
                                     fontSize: Get.width*0.04,
                                   ),),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: Get.width/30,),
                        GridView.builder(
                          itemCount: homeController.educationDataList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisExtent: Get.width/10,),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                homeController.educationDataList[index]['selected'] = !(homeController.educationDataList[index]['selected'] ?? false);
                                homeController.educationDataList[index] = homeController.educationDataList[index];
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: (homeController.educationDataList[index]['selected'] ?? false) ? ConstHelper.orangeColor : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: (homeController.educationDataList[index]['selected'] ?? false) ?  Colors.transparent : ConstHelper.cementColor,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(Get.width/300,),
                                    child: (homeController.educationDataList[index]['selected'] ?? false) ? Icon(Icons.done_rounded,color: ConstHelper.whiteColor,size: Get.width/22,) : Container(
                                      height: Get.width/22,
                                      width: Get.width/22,
                                    ),
                                  ),
                                  SizedBox(width: Get.width/80,),
                                  Flexible(
                                    child: Text(
                                      homeController.educationDataList[index]['education_name'] ?? 'N/A',
                                      style: TextStyle(
                                        color: (homeController.educationDataList[index]['selected'] ?? false) ? ConstHelper.orangeColor : ConstHelper.cementColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: Get.width*0.04,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Container(
                          width: Get.width,
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        SizedBox(height: Get.width/30,),
                        Text(
                          'Manglik',
                          style: TextStyle(
                            color: ConstHelper.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width*0.04,
                          ),
                        ),
                        SizedBox(height: Get.width/30,),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  homeController.maglikStatus.value = 'Yes';
                                },
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: homeController.maglikStatus.value.toLowerCase() == 'Yes'.toLowerCase() ? ConstHelper.orangeColor : ConstHelper.cementColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: Get.width/50,),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: homeController.maglikStatus.value.toLowerCase() == 'Yes'.toLowerCase() ? ConstHelper.whiteColor :ConstHelper.blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.width*0.035,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width/20,),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  homeController.maglikStatus.value = 'No';
                                },
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: homeController.maglikStatus.value.toLowerCase() == 'No'.toLowerCase() ? ConstHelper.orangeColor : ConstHelper.cementColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: Get.width/50,),
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                      color: homeController.maglikStatus.value.toLowerCase() == 'No'.toLowerCase() ? ConstHelper.whiteColor :ConstHelper.blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.width*0.035,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width/20,),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  homeController.maglikStatus.value = 'All';
                                },
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: homeController.maglikStatus.value.toLowerCase() == 'All'.toLowerCase() ? ConstHelper.orangeColor : ConstHelper.cementColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: Get.width/50,),
                                  child: Text(
                                    'All',
                                    style: TextStyle(
                                      color: homeController.maglikStatus.value.toLowerCase() == 'All'.toLowerCase() ? ConstHelper.whiteColor :ConstHelper.blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.width*0.035,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.width/20,),
                        Container(
                          width: Get.width,
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        SizedBox(height: Get.width/30,),
                        Text(
                          'Married Before',
                          style: TextStyle(
                            color: ConstHelper.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width*0.04,
                          ),
                        ),
                        SizedBox(height: Get.width/30,),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  homeController.marriedBeforeStatus.value = 'Yes';
                                },
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: homeController.marriedBeforeStatus.value.toLowerCase() == 'Yes'.toLowerCase() ? ConstHelper.orangeColor : ConstHelper.cementColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: Get.width/50,),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: homeController.marriedBeforeStatus.value.toLowerCase() == 'Yes'.toLowerCase() ? ConstHelper.whiteColor :ConstHelper.blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.width*0.035,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width/20,),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  homeController.marriedBeforeStatus.value = 'No';
                                },
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: homeController.marriedBeforeStatus.value.toLowerCase() == 'No'.toLowerCase() ? ConstHelper.orangeColor : ConstHelper.cementColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: Get.width/50,),
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                      color: homeController.marriedBeforeStatus.value.toLowerCase() == 'No'.toLowerCase() ? ConstHelper.whiteColor :ConstHelper.blackColor,
                                      fontWeight: FontWeight.bold,
                                        fontSize: Get.width*0.035,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width/20,),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  homeController.marriedBeforeStatus.value = 'All';
                                },
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: homeController.marriedBeforeStatus.value.toLowerCase() == 'All'.toLowerCase() ? ConstHelper.orangeColor : ConstHelper.cementColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: Get.width/50,),
                                  child: Text(
                                    'All',
                                    style: TextStyle(
                                      color: homeController.marriedBeforeStatus.value.toLowerCase() == 'All'.toLowerCase() ? ConstHelper.whiteColor : ConstHelper.blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.width*0.035,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.width/30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.width/15,),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            homeController.selectedGotra.value = "-- Select Gotra --";
                            homeController.yearlyIncomeStart.value = 1.0;
                            homeController.yearlyIncomeEnd.value = 300.0;
                            homeController.selectedAgeStart.value = 18.0;
                            homeController.selectedAgeEnd.value = 50.0;
                            homeController.selectedMaxHeightValue.value = "7.0";
                            homeController.selectedMinHeightValue.value = "4.0";
                            homeController.marriedBeforeStatus.value = 'All';
                            homeController.maglikStatus.value = 'All';
                            homeController.selectAll.value = true;
                            for(int i = 0; i < homeController.educationDataList.length; i++){
                              homeController.educationDataList[i]['selected'] = true;
                            }
                          });
                          List<String> eductionSelected = [];
                          for(var data in homeController.educationDataList){
                            eductionSelected.add(data["selected"].toString());
                          }
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString("gotra", "");
                          prefs.setString("yearlyIncomeStart", homeController.yearlyIncomeStart.value.toString());
                          prefs.setString("yearlyIncomeEnd", homeController.yearlyIncomeEnd.value.toString());
                          prefs.setString("selectedAgeStart", homeController.selectedAgeStart.value.toString());
                          prefs.setString("selectedAgeEnd", homeController.selectedAgeEnd.value.toString());
                          prefs.setString("selectedMaxHeightValue", homeController.selectedMaxHeightValue.value.toString());
                          prefs.setString("selectedMinHeightValue", homeController.selectedMinHeightValue.value.toString());
                          prefs.setString("marriedBeforeStatus", homeController.marriedBeforeStatus.value.toString());
                          prefs.setString("maglikStatus", homeController.maglikStatus.value.toString());
                          prefs.setString("selectAll", homeController.selectAll.value.toString());
                          prefs.setStringList("eductionSelected", eductionSelected);
                          homeController.restore.value = true;
                          await getAllMembersData();
                          ConstHelper.successDialog(text: 'Setting Restore Successfully', seconds: 10,);
                          // List educationDataList = await ApiHelper.apiHelper.getEducationDataList();
                          // homeController.educationDataList.value =
                          //     educationDataList.map(
                          //           (element) {
                          //         Map map = {
                          //           "id": element['id'] ?? 0,
                          //           "education_name":
                          //           element['education_name'] ?? '',
                          //           "selected": element['education_name']
                          //               .toString()
                          //               .trim()
                          //               .toLowerCase() ==
                          //               homeController
                          //                   .userData.value.profileEducation
                          //                   .toString()
                          //                   .trim()
                          //                   .toLowerCase(),
                          //         };
                          //         return map;
                          //       },
                          //     ).toList();
                        },
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: ConstHelper.greyColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: Get.width/30,),
                          child: Text(
                            'Restore',
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width*0.045,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width/20,),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          List<String> eductionSelected = [];
                          for(var data in homeController.educationDataList){
                            eductionSelected.add(data["selected"].toString());
                          }
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString("gotra", homeController.selectedGotra.value.toString());
                          prefs.setString("yearlyIncomeStart", homeController.yearlyIncomeStart.value.toString());
                          prefs.setString("yearlyIncomeEnd", homeController.yearlyIncomeEnd.value.toString());
                          prefs.setString("selectedAgeStart", homeController.selectedAgeStart.value.toString());
                          prefs.setString("selectedAgeEnd", homeController.selectedAgeEnd.value.toString());
                          prefs.setString("selectedMaxHeightValue", homeController.selectedMaxHeightValue.value.toString());
                          prefs.setString("selectedMinHeightValue", homeController.selectedMinHeightValue.value.toString());
                          prefs.setString("marriedBeforeStatus", homeController.marriedBeforeStatus.value.toString());
                          prefs.setString("maglikStatus", homeController.maglikStatus.value.toString());
                          prefs.setString("selectAll", homeController.selectAll.value.toString());
                          log(eductionSelected.toString());
                          prefs.setStringList("eductionSelected", eductionSelected);
                          homeController.restore.value = false;
                          await getAllMembersData();
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
                            'Save',
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width*0.045,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.width/20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getAllMembersData() async {
    List<String> educationCategory = [];
    for(int i = 0; i < homeController.educationDataList.length; i++){
      if(homeController.educationDataList[i]['selected'] == true){
        educationCategory.add(homeController.educationDataList[i]['education_name'] ?? 'N/A');
      }
    }
    try {
      List<MembersDataModel> allMembersDataList = await ApiHelper.apiHelper
          .getAllMembersDataList(
          heightFrom: homeController.selectedMinHeightValue.value.toString().split(".")[0].toString(),
          heightTo: homeController.selectedMaxHeightValue.value.toString().split(".")[0].toString(),
          educationCategory: educationCategory,
          haveMarriedBefore: homeController.marriedBeforeStatus.value.toLowerCase(),
          ageFrom: homeController.selectedAgeStart.value.toStringAsFixed(0),
          ageTo: homeController.selectedAgeEnd.value.toStringAsFixed(0),
          excludeGotra: homeController.restore.value == true && homeController.selectedGotra.value == "-- Select Gotra --"? "":homeController.selectedGotra.value);
      print('adasd ${allMembersDataList.length}');
      if(homeController.userData.value.profileType?.toString() == "1") {
        homeController.allMembersDataListGenderWise.value = allMembersDataList
            .where(
              (element) =>
          element.profileGender.toString().trim().toLowerCase() ==
              (homeController.userData.value.profileGender?.toString().trim().toLowerCase() == "Female".toLowerCase()
                  ? 'Male'.trim().toLowerCase()
                  : 'Female'.trim().toLowerCase()),
        )
            .toList();
      } else {
        homeController.allMembersDataListGenderWise.value = allMembersDataList
            .where(
              (element) =>
          element.profileGender.toString().trim().toLowerCase() ==
              (maleFemale.value
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
      homeController.advancedDrawerController.hideDrawer();
      Get.back();
      // startLoad.value = false;
    } catch (error) {
      homeController.allMembersDataListGenderWise.value = [];
      // startLoad.value = false;
    }
    // startLoad.value = false;
  }
}
class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
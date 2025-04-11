import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Controllers/HomeController.dart';

import '../../Utils/ApiHelper.dart';
import '../../Utils/ConstHelper.dart';
import '../HomeScreen/MembersDataShowPage.dart';

class MyShortlistedPage extends StatefulWidget {
  const MyShortlistedPage({super.key});

  @override
  State<MyShortlistedPage> createState() => _MyShortlistedPageState();
}

class _MyShortlistedPageState extends State<MyShortlistedPage> {

  HomeController homeController = Get.put(HomeController());
  RxBool startLoad = true.obs;

  Future<void> getAllMembersData() async {
    startLoad.value = true;
    try {
      homeController.allShortlistedDataList.value = await ApiHelper.apiHelper.getAllShortlistedDataList();
      startLoad.value = false;
    } catch(error) {
      homeController.allShortlistedDataList.value = [];
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
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Shortlisted",style: TextStyle(fontSize: 20,color: ConstHelper.blackColor,fontWeight: FontWeight.bold,),),
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
        body: RefreshIndicator(
          onRefresh: () async {
            await getAllMembersData();
          },
          color: ConstHelper.orangeColor,
          backgroundColor: ConstHelper.whiteColor,
          child: Obx(
                () => startLoad.value
                ? Center(child: CircularProgressIndicator(color: ConstHelper.orangeColor,),)
                : homeController.allShortlistedDataList.isEmpty ? ListView(
              children: [
                SizedBox(height: Get.height/2.5,),
                Center(
                  child: Text(
                    'Sorry, Data Not Available',
                    style: TextStyle(
                      color: ConstHelper.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ) : ListView.builder(
              itemCount: homeController.allShortlistedDataList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    homeController.selectedMembersData.value = homeController.allShortlistedDataList[index];
                    homeController.profileShorted.value = true;
                    Get.to(MembersDataShowPage(),transition: Transition.fadeIn,);
                  },
                  child: Container(
                    width: Get.width,
                    margin: EdgeInsets.fromLTRB(Get.width/30, index == 0 ? Get.width/15 : Get.width/23, Get.width/30, homeController.allShortlistedDataList.length != (index+1) ? 0 : Get.width/30,),
                    decoration: BoxDecoration(
                      color: ConstHelper.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: ConstHelper.greyColor.withOpacity(0.1),
                          offset: const Offset(0, 4),
                          blurRadius: 2,
                        ),
                        BoxShadow(
                          color: ConstHelper.greyColor.withOpacity(0.05),
                          offset: const Offset(0, -1),
                          blurRadius: 2,
                        ),
                      ],
                      border: Border.all(width: 0.3,color: ConstHelper.greyColor.withOpacity(0.2),),
                    ),
                    padding: EdgeInsets.symmetric(vertical: Get.width/30,),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 2,
                                  decoration: BoxDecoration(
                                    color: ConstHelper.orangeColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                SizedBox(width: Get.width/30,),
                                IntrinsicHeight(
                                  child: Container(
                                    width: Get.width/5,
                                    height: Get.width/5,
                                    decoration: BoxDecoration(
                                      color: ConstHelper.whiteColor,
                                      borderRadius: BorderRadius.circular(7.5),
                                      border: Border.all(color: ConstHelper.greyColor.withOpacity(0.3),),

                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: CachedNetworkImage(
                                        imageUrl: homeController.allShortlistedDataList[index].profilePhoto == null || homeController.allShortlistedDataList[index].profilePhoto!.trim().isEmpty ? ConstHelper.profileImagePath : '${ConstHelper.userImagesPath}${homeController.allShortlistedDataList[index].profilePhoto!}',
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: ConstHelper.whiteColor,
                                          ),
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            height: Get.width/20,
                                            width: Get.width/20,
                                            child: CircularProgressIndicator(color: ConstHelper.orangeColor,strokeWidth: 2,),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
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
                                SizedBox(width: Get.width/30,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${homeController.allShortlistedDataList[index].id == null || homeController.allShortlistedDataList[index].id == 0 ? 'Id not available' : homeController.allShortlistedDataList[index].id!} - ${homeController.allShortlistedDataList[index].name == null || homeController.allShortlistedDataList[index].name!.trim().isEmpty ? ConstHelper.nameNotAvailableMsg : homeController.allShortlistedDataList[index].name}',
                                        style: TextStyle(
                                          color: ConstHelper.blackColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      // Text(
                                      //   homeController.allShortlistedDataList[index].profileFatherFullName == null || homeController.allShortlistedDataList[index].profileFatherFullName!.trim().isEmpty ? ConstHelper.fatherNameNotAvailableMsg : homeController.allShortlistedDataList[index].profileFatherFullName!,
                                      //   style: TextStyle(
                                      //     color: ConstHelper.greyColor,
                                      //     fontWeight: FontWeight.w500,
                                      //     fontSize: 12,
                                      //   ),
                                      // ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'DOB : ',
                                                style: TextStyle(
                                                  color: ConstHelper.blackColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                homeController.allShortlistedDataList[index].profileDateOfBirth == null || homeController.allShortlistedDataList[index].profileDateOfBirth!.year <= 0 ? 'N/A' : DateFormat('dd | MMM | yyyy').format(homeController.allShortlistedDataList[index].profileDateOfBirth!),
                                                style: TextStyle(
                                                  color: ConstHelper.greyColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: Get.width/30,),
                                          Row(
                                            children: [
                                              Text(
                                                'EDU : ',
                                                style: TextStyle(
                                                  color: ConstHelper.blackColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                homeController.allShortlistedDataList[index].profileEducation == null || homeController.allShortlistedDataList[index].profileEducation!.trim().isEmpty ? 'N/A' : homeController.allShortlistedDataList[index].profileEducation!,
                                                style: TextStyle(
                                                  color: ConstHelper.greyColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
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
                                              color: ConstHelper.blackColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            '${homeController.allShortlistedDataList[index].profileWorkingCity == null || homeController.allShortlistedDataList[index].profileWorkingCity!.trim().isEmpty ? '' : homeController.allShortlistedDataList[index].profileWorkingCity!}${homeController.allShortlistedDataList[index].profileWorkingCity != null && homeController.allShortlistedDataList[index].profilePermanentAddress!.trim().isNotEmpty && homeController.allShortlistedDataList[index].profilePermanentAddress != null && homeController.allShortlistedDataList[index].profilePermanentAddress!.trim().isNotEmpty ? ' | ' : 'N/A'}${homeController.allShortlistedDataList[index].profilePermanentAddress == null || homeController.allShortlistedDataList[index].profilePermanentAddress!.trim().isEmpty ? '' : homeController.allShortlistedDataList[index].profilePermanentAddress!}',
                                            style: TextStyle(
                                              color: ConstHelper.greyColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
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
                         // SvgPicture.asset('assets/image/menuVerticalIconSVG.svg',height: Get.width/25,width: Get.width/25,),
                          SizedBox(width: Get.width/90,),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

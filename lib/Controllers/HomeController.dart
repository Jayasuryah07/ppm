import 'dart:convert';

import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';


import '../Models/MembersDataModel.dart';
import '../Models/UserDataModel.dart';
import '../Utils/SharedPrefHelper.dart';

class HomeController extends GetxController {

  AdvancedDrawerController advancedDrawerController = AdvancedDrawerController();
  RxList communityDataList = [].obs;
  RxList gotraDataListCommunityIdWise = [].obs;
  RxList<String> gotraDataList = ["-- Select Gotra --"].obs;
  RxString selectedGotra = "-- Select Gotra --".obs;
  RxList educationDataList = [].obs;
  RxBool selectAll = false.obs;
  RxBool restore = false.obs;
  RxList<MembersDataModel> allMembersDataListGenderWise = <MembersDataModel>[].obs;
  RxList<MembersDataModel> allShortlistedDataList = <MembersDataModel>[].obs;
  Rx<MembersDataModel> selectedMembersData = MembersDataModel().obs;
  RxString firebaseFCMToken = "".obs;
  Rx<UserDataModel> userDataWithToken = UserDataModel().obs;
  Rx<User> userData = User().obs;
  RxBool profileShorted = false.obs;
  RxString maglikStatus = 'All'.obs;
  RxString marriedBeforeStatus = 'All'.obs;
  // RxList<Map> educationDataList = [
  //   {'name':'U.G','selected': true},
  //   {'name':'PHD','selected': false},
  //   {'name':'M.Phil','selected': false},
  //   {'name':'P.G','selected': true},
  //   {'name':'CA/CS','selected': false},
  //   {'name':'School','selected': false},
  //   {'name':'MBS','selected': false},
  //   {'name':'Diploma','selected': false},
  //   {'name':'Engineering','selected': false},
  //   {'name':'Low','selected': false},
  //   {'name':'Doctor','selected': false},
  // ].obs;
  RxDouble yearlyIncomeStart = 1.0.obs;
  RxDouble yearlyIncomeEnd = 300.0.obs;
  RxDouble selectedAgeStart = 18.0.obs;
  RxDouble selectedAgeEnd = 50.0.obs;
  RxString selectedMinHeightValue = "4.0".obs;
  RxString selectedMaxHeightValue = "7.0".obs;

  Future<void> getUserData() async {
    String userStringData = SharedPrefHelper.sharedPreferences.getString('userData') ?? '';
    Map userMapData = userStringData.isEmpty ? {} : jsonDecode(userStringData);
    userDataWithToken.value = userMapData.isEmpty ? UserDataModel() : UserDataModel.fromJson(userMapData);
    userData.value = userDataWithToken.value.user ?? User();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getUserData();
    super.onInit();
  }
}
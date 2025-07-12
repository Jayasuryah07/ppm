import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Controllers/HomeController.dart';
import '../../Models/UserDataModel.dart';
import '../HomeScreen/HomePage.dart';
import '../SignUpScreen/SignUpPage.dart';
import '../../Utils/ApiHelper.dart';
import '../../Utils/ConstHelper.dart';
import '../../Utils/FirebaseHelper.dart';
import '../../Utils/SharedPrefHelper.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  HomeController homeController = Get.put(HomeController());
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool hidePassword = true.obs;

  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

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
              Obx(
                () => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.width/6,),
                      Center(
                        child: Container(
                          height: Get.width/2.2,
                          width: Get.width/2.2,
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
                            fontSize: Get.width * 0.065,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: Get.width/9,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width/30,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                color: ConstHelper.whiteColor,
                                fontSize: Get.width * 0.055,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: Get.width/30,),
                            TextFormField(
                              controller: txtUsername,
                              cursorColor: ConstHelper.whiteColor,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              style: TextStyle(
                                fontSize: Get.width * 0.045,
                                letterSpacing: 1,
                                color: ConstHelper.whiteColor,
                              ),
                              focusNode: usernameFocusNode,
                              validator: (value) {
                                if(value!.trim().isEmpty)
                                  {
                                    return 'Please enter the userid';
                                  }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                counterText: "",
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
                                labelText: 'User ID',
                                errorStyle: TextStyle(
                                  fontSize: Get.width * 0.04,
                                  letterSpacing: 1,
                                  color: ConstHelper.whiteColor,
                                ),
                                labelStyle: TextStyle(
                                  fontSize: Get.width * 0.035,
                                  letterSpacing: 1,
                                  color: ConstHelper.whiteColor,
                                ),
                                prefixIcon: SizedBox(height: Get.width/20,width: Get.width/20,child: Center(child: SvgPicture.asset('assets/image/personSVG.svg',height: Get.width/20,width: Get.width/20,fit: BoxFit.contain,))),
                              ),
                            ),
                            SizedBox(height: Get.width/20,),
                            TextFormField(
                              controller: txtPassword,
                              maxLength: 12,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: Get.width * 0.045,
                                letterSpacing: 1,
                                color: ConstHelper.whiteColor,
                              ),
                              cursorColor: ConstHelper.whiteColor,
                              focusNode: passwordFocusNode,
                              validator: (value) {
                                if(value!.trim().isEmpty)
                                {
                                  return 'Please enter the password';
                                }
                                return null;
                              },
                              obscureText: hidePassword.value,
                              decoration: InputDecoration(
                                counterText: "",
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
                                labelText: 'Password',
                                errorStyle: TextStyle(
                                  fontSize: Get.width * 0.04,
                                  letterSpacing: 1,
                                  color: ConstHelper.whiteColor,
                                ),
                                labelStyle: TextStyle(
                                  fontSize: Get.width * 0.035,
                                  letterSpacing: 1,
                                  color: ConstHelper.whiteColor,
                                ),
                                prefixIcon: SizedBox(height: Get.width/20,width: Get.width/20,child: Center(child: SvgPicture.asset('assets/image/passwordSVG.svg',height: Get.width/20,width: Get.width/20,fit: BoxFit.contain,))),
                                // suffixIcon: SizedBox(height: Get.width/20,width: Get.width/20,child: Center(child: SvgPicture.asset('assets/image/eyeNoVisibleSVG.svg',height: Get.width/20,width: Get.width/20,fit: BoxFit.contain,))),
                                suffixIcon: IconButton(onPressed: (){
                                  hidePassword.value = !hidePassword.value;
                                }, icon: hidePassword.value ? Image.asset('assets/image/eyeVisibility.png',height: Get.width/20,width: Get.width/20,fit: BoxFit.contain,color: ConstHelper.cementColor,) : SvgPicture.asset('assets/image/eyeNoVisibleSVG.svg',height: Get.width/20,width: Get.width/20,fit: BoxFit.contain,color: ConstHelper.cementColor,),),
                              ),
                            ),
                            // SizedBox(height: Get.width/60,),
                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: Text(
                            //     'Forget Password?',
                            //     style: TextStyle(
                            //       color: ConstHelper.cementColor,
                            //       fontWeight: FontWeight.w600,
                            //       fontSize: 14,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: Get.width/10,),
                            GestureDetector(
                              onTap: () async {
                                EasyLoading.show(status: ConstHelper.pleaseWaitMsg,);
                                await Future.delayed(Duration(milliseconds: 200,),);
                                usernameFocusNode.unfocus();
                                passwordFocusNode.unfocus();
                                  if(txtUsername.text.trim().isEmpty)
                                  {
                                    EasyLoading.dismiss();
                                    usernameFocusNode.requestFocus();
                                  }
                                  else if(txtPassword.text.trim().isEmpty)
                                  {
                                    EasyLoading.dismiss();
                                    passwordFocusNode.requestFocus();
                                  }

                                  if(formKey.currentState!.validate())
                                  {
                                   try {
                                     if(!(await ConstHelper.checkInternet()))
                                     {
                                       EasyLoading.dismiss();
                                       ConstHelper.errorDialog(text: ConstHelper.internetMsg, seconds: 10,);
                                       return;
                                     }
                                     var token;
                                     if (Platform.isIOS) {
                                       token = await FirebaseMessaging.instance
                                           .getAPNSToken();
                                       debugPrint('APNS Token: $token');
                                     } else {
                                       FirebaseMessaging messaging =
                                           FirebaseMessaging.instance;
                                       token = await messaging.getToken();
                                       debugPrint('APNS Token: $token');
                                     }
                                      homeController.firebaseFCMToken.value = token??"";
                                      log("Token : ${homeController.firebaseFCMToken.value}");
                                      await ApiHelper.apiHelper.loginUser(profileId: txtUsername.text.toString(), password: txtPassword.text.trim(), deviceId: homeController.firebaseFCMToken.value,).then((userData) async {
                                        if(userData.isNotEmpty)
                                          {
                                            if(userData['code'] == 200)
                                              {
                                                UserDataModel userDataModel = UserDataModel.fromJson(userData['data'] ?? {});
                                                SharedPrefHelper.sharedPreferences.setBool('login', true,);
                                                SharedPrefHelper.sharedPreferences.setString('userData', jsonEncode(userDataModel),);
                                                await homeController.getUserData();
                                                EasyLoading.dismiss();
                                                homeController.advancedDrawerController = AdvancedDrawerController();
                                                Get.off(const HomePage(),);
                                                ConstHelper.successDialog(text: 'Login Successfully', seconds: 2,);
                                              }
                                            else
                                              {
                                                EasyLoading.dismiss();
                                                ConstHelper.errorDialog(text: userData['msg'] ?? ConstHelper.somethingErrorMsg, seconds: 10,);
                                              }
                                          }
                                        else
                                          {
                                            EasyLoading.dismiss();
                                            ConstHelper.errorDialog(text: 'Unauthorised.', seconds: 10,);
                                          }
                                      },);
                                    } catch(error) {
                                      EasyLoading.dismiss();
                                      ConstHelper.errorDialog(text: ConstHelper.somethingErrorMsg, seconds: 10,);
                                    }
                                  }
                                  else
                                  {
                                    EasyLoading.dismiss();
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
                                  'Login'.toUpperCase(),
                                  style: TextStyle(
                                    color: ConstHelper.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.width * 0.05,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Get.width/15,),
                            Center(
                              child: Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: ConstHelper.whiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Get.width * 0.035,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            // SizedBox(height: Get.width/90,),
                            Center(
                              child: InkWell(
                                onTap: () async {
                                  EasyLoading.show(status: 'Please wait...');
                                  await Future.delayed(const Duration(milliseconds: 100,),);
                                  try {
                                    if(await ConstHelper.checkInternet())
                                    {
                                      homeController.communityDataList.value = await ApiHelper.apiHelper.getCommunityDataList();
                                      homeController.gotraDataListCommunityIdWise.value = [];
                                      homeController.educationDataList.value = await ApiHelper.apiHelper.getEducationDataList();
                                      Get.to(const SignUpPage(),);
                                      EasyLoading.dismiss();
                                    }
                                    else
                                    {
                                      EasyLoading.dismiss();
                                      ConstHelper.errorDialog(text: ConstHelper.internetMsg, seconds: 10,);
                                    }
                                  } catch(error) {
                                    EasyLoading.dismiss();
                                    ConstHelper.errorDialog(text: ConstHelper.somethingErrorMsg, seconds: 10,);
                                  }
                                },
                                child: Text(
                                  "Join & find love!",
                                  style: TextStyle(
                                    color: ConstHelper.orangeColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: ConstHelper.orangeColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: Get.width * 0.055,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Get.width/30,),
                          ],
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
    );
  }
}

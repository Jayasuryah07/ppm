import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getX;
import 'package:intl/intl.dart';

import '../Controllers/HomeController.dart';
import '../Models/MembersDataModel.dart';
import '../Models/UserDataModel.dart';
import 'API.dart';


class ApiHelper {
  ApiHelper._();

  static ApiHelper apiHelper = ApiHelper._();
  API api = API();
  String authorizationToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNjYzNjY5Mjg4Y2JjYWIxOTQyODY5NDNhYjczOTVlMjJjYzdlZTliMmQ3ZDNlNmM4NjYzMzVhYmFlZTJjZjg5ZjRjMTlkNzc2NWVmNzAzOTMiLCJpYXQiOjE3MjMwMDY1NjEuMjI2ODAwOTE4NTc5MTAxNTYyNSwibmJmIjoxNzIzMDA2NTYxLjIyNjgwNDAxODAyMDYyOTg4MjgxMjUsImV4cCI6MTc1NDU0MjU2MS4yMjUyNzE5NDAyMzEzMjMyNDIxODc1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.awZQ8OEkGNtGq3ZauBAR76VuGLm8-QjEUbQTMv-SenGeEAabXtYJov5kyH0kn6lp8S7Enhr8Zerkl7Bbgkb1Bd0z0d4Mozh3hDr-nH7IjhB1tHoWp2f_XY1kE59BhILKVFB61iFNZZJHeC0MHLO84UjaiAI1Cei6gHaUZTL4TQU8VbO41C4yM85QTTRRgApg24wqZvUUNwLPyGz8tEqRN5GSQbmmW3RgyeF5kDsLlk3Ck3hOqTN20dfe9DPZj7Tj_E4bqZTGqBu45DZVagGiy92AuZeKhTzkPqh8vZGI1IS_IzbQkJd2BTkBCBeaTUuwgRRn8aMufbbliRh9JhSSp8h7UQq3Bh9YrcOfyL0WKYFdWe-_fHLCR_JBJfkDYMm4nKsEPfKgvMU0x2ZfoK2UEjsoKq9YJLQdfsMFlT55UVRObFX8zcYLeH8s8Bm7RI0ZAt8C7CdSqHRXF1kI662naciV0onCUTtBJcB_2lsIzvvDsK0iZ4FS9H3lrkjqHQ2Cp3LD9XlVUJfhnY_QG47qcjPOEz4B6u7vzZa-JkduMjqkySC38tDgB9fYR97Aor5JMhXnTqOLU8ci4jt27T8B57Jqmayx91m-bz4AFqK1-sYtOWmfOJhYBotGVAW-xAGErCjVZ43qTMpzUEchI0qgPtsRQPOmyf0lvwNTvl8PqyE';

  void getAuthorizationToken() {
    HomeController homeController = getX.Get.put(HomeController());
    authorizationToken = homeController.userDataWithToken.value.token ?? '';
    log(authorizationToken);
  }

  Future<List> getCommunityDataList() async {
    try {
      getAuthorizationToken();
      // var data = FormData.fromMap({
      //   'school_id': schoolId,
      //   'current_std': currentStd,
      // });
      Response response = await api.dio.post(
        'fetch-community',
      );
      if (response.statusCode == 200) {
        var data = response.data;
        return data == null ? [] : data['data'] ?? [];
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<MembersDataModel>> getAllMembersDataList({required String heightFrom,required String heightTo,required List<String> educationCategory,required String haveMarriedBefore,required String ageFrom,required String ageTo,required String excludeGotra,}) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'height_from': heightFrom,
        'height_to': heightTo,
        'have_married_before': haveMarriedBefore,
        'age_from': ageFrom,
        'age_to': ageTo,
        'exclude_gotra': excludeGotra,
      });

      for (String category in educationCategory) {
        data.fields.add(MapEntry('education_category[]', category));
      }

      var headers = {
        'Authorization': 'Bearer $authorizationToken',
      };

      Response response = await api.dio.post(
        'fetch-filter',
        data: data,
        options: Options(
          headers: headers,
        )
      );

      print(data.fields);
      if (response.statusCode == 200) {
        print(response.data);
        var data = response.data;
        print('asdadasd ${data.runtimeType} ${data}');
        return List.from(data == null ? [] : data['data'] == null ? [] : data['data'].map((e) => MembersDataModel.fromJson(e)).toList());
      } else {
        return [];
      }
    } catch (error) {
      print('error $error');
      return [];
    }
  }

  Future<MembersDataModel> getSelectedembersDataList({required String id,}) async {
    getAuthorizationToken();
    var headers = {
      'Authorization': 'Bearer $authorizationToken',
    };
    var data = FormData.fromMap({
      'profile_id': id
    });

    var dio = Dio();
    Response response = await api.dio.post(
        'fetch-profiles-by-id',
        data: data,
        options: Options(
          headers: headers,
        )
    );

    if (response.statusCode == 200) {
      var data = response.data;
      print(data);
      return MembersDataModel.fromJson(data["data"][0]);
    }
    else {
      print(response.statusMessage);
      return MembersDataModel();
    }
  }

  Future<User?> fetchProfile() async {
    try {
      getAuthorizationToken();

      var headers = {
        'Authorization': 'Bearer $authorizationToken',
      };

      Response response = await api.dio.post(
          'fetch-profile',
          options: Options(
            headers: headers,
          )
      );
      if (response.statusCode == 200) {
        var data = response.data;
        print('asdadasd ${data.runtimeType} ${data['data']}');
        return User.fromJson(data["data"]);
      } else {
        return null;
      }
    } catch (error) {
      print('error $error');
      return null;
    }
  }


  Future<String> editProfile({required String whatsapp,
    required String working_city,
    required String ref_contact_name,
    required String ref_contact_mobile,
    required String photo,
    required String education,
    required String occupation,
    required String have_married_before,
    required String physical_disablity,
    required String note,
    required String permanent_address,
    required String village_city,
  }) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'profile_whatsapp': whatsapp,
        'profile_working_city': working_city,
        'profile_ref_contact_name': ref_contact_name,
        'profile_ref_contact_mobile': ref_contact_mobile,
        'profile_photo': photo.isEmpty ? '' : await MultipartFile.fromFile(photo, filename: photo.split('/').isEmpty ? null : photo.split('/').last,),
        'profile_education': education,
        'profile_occupation': occupation,
        'profile_have_married_before': have_married_before,
        'profile_physical_disablity': physical_disablity,
        'profile_note': note,
        'profile_permanent_address': permanent_address,
        'profile_village_city': village_city
      });

      var headers = {
        'Authorization': 'Bearer $authorizationToken',
      };

      Response response = await api.dio.post(
          'update-profile',
          data: data,
          options: Options(
            headers: headers,
          )
      );
      if (response.statusCode == 200) {
        var data = response.data;
        print('asdadasd ${data.runtimeType} ${data['data']}');
        return data["msg"].toString();
      } else {
        return "";
      }
    } catch (error) {
      print('error $error');
      return "";
    }
   }

  Future<String> insertFeedback({required String profileId,required String description,}) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'to_profile_id': profileId,
        'description': description,
      });

      var headers = {
        'Authorization': 'Bearer $authorizationToken',
      };

      Response response = await api.dio.post(
          'create-feedback',
          data: data,
          options: Options(
            headers: headers,
          )
      );
      if (response.statusCode == 200) {
        var data = response.data;
        print('Success : ${response.data}');
        return data == null ? '' : data['msg'] == null ? '' : data['msg'].toString();
      } else {
        print('Success : ${response.statusMessage}');
        return '';
      }
    } catch (error) {
      print('error $error');
      return '';
    }
  }

  Future<List> getGotraDataListCommunityWise({required String comunityId,}) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'comunity': comunityId,
      });
      Response response = await api.dio.post(
        'fetch-gotra',
        data: data,
      );
      print(response.data);
      if (response.statusCode == 200) {
        var data = response.data;
        return data == null ? [] : data['data'] ?? [];
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<String>> getGotraDataList() async {
    try {
      getAuthorizationToken();
      var headers = {
        'Authorization': 'Bearer $authorizationToken'
      };
      Response response = await api.dio.post(
        'fetch-gotra-filter',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        List<String> dataList = [];
        if(data != null){
          for(int i = 0; i < data["data"].length; i++){
            dataList.add(data["data"][i]["gotra_name"]);
          }
        }
        return dataList ?? [];
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List> getEducationDataList() async {
    try {
      getAuthorizationToken();
      // var data = FormData.fromMap({
      //   'school_id': schoolId,
      //   'current_std': currentStd,
      // });
      Response response = await api.dio.post(
        'fetch-education',
      );
      if (response.statusCode == 200) {
        var data = response.data;
        return data == null ? [] : data['data'] ?? [];
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<Map> newSignup({required MembersDataModel membersDataModel,}) async {
    try {
      getAuthorizationToken();
      String profilePhoto = membersDataModel.profilePhoto ?? '';
      print('adadada $profilePhoto');
      var data = FormData.fromMap({
        'name': membersDataModel.name,
        'profile_gender': membersDataModel.profileGender,
        'profile_date_of_birth': DateFormat('yyyy-MM-dd').format(membersDataModel.profileDateOfBirth ?? DateTime.now()),
        'profile_time_of_birth': membersDataModel.profileTimeOfBirth,
        'profile_comunity_name': membersDataModel.profileComunityName,
        'profile_gotra': membersDataModel.profileGotra,
        'profile_education': membersDataModel.profileEducation,
        'profile_occupation': membersDataModel.profileOccupation,
        'email': membersDataModel.email,
        'profile_mobile': membersDataModel.profileMobile,
        'profile_whatsapp': membersDataModel.profileWhatsapp,
        'profile_main_contact_num': membersDataModel.profileMainContactNum,
        'heightFeet': membersDataModel.profileHeight,
        'heightInch': membersDataModel.profileHeightInch,
        'profile_father_full_name': membersDataModel.profileFatherFullName,
        'profile_ref_contact_name': membersDataModel.profileRefContactName,
        'profile_ref_contact_mobile': membersDataModel.profileRefContactMobile,
        'profile_physical_disablity': membersDataModel.profilePhysicalDisablity,
        'profile_have_married_before': membersDataModel.profileHaveMarriedBefore,
        'profile_working_city': membersDataModel.profileWorkingCity,
        'profile_place_of_birth': membersDataModel.profilePlaceOfBirth,
        'profile_permanent_address': membersDataModel.profilePermanentAddress,
        'profile_note': membersDataModel.profileNote,
        'profile_photo': profilePhoto.isEmpty ? '' : await MultipartFile.fromFile(profilePhoto, filename: profilePhoto.split('/').isEmpty ? null : profilePhoto.split('/').last,),
      });
      print('aDadadd 123123');
      Response response = await api.dio.post(
        'signup',
        data: data,
      );
      print('aDadadd ${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        print('Success: ${response.data}');
        return data;
      } else {
        print('Error: ${response.statusCode} ${response.statusMessage}');
        return {};
      }
    } catch (error) {
      print('Error: $error');
      return {};
    }
  }



  Future<Map> loginUser({required String profileId,required String password,required String deviceId,}) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'profile_id': profileId,
        'password': password,
        'device_id': deviceId,
      });
      print('aDadadd 123123 ${data.fields}');
      Response response = await api.dio.post(
        'login',
        data: data,
      );
      print('aDadadd ${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        log('Success: ${response.data}');
        return data;
      } else {
        print('Error== ${response.statusMessage}');
        return {};
      }
    } catch (error) {
      print('Error--: $error');
      return {};
    }
  }

  Future<List<MembersDataModel>> getAllShortlistedDataList() async {
    try {
      getAuthorizationToken();

      var headers = {
        'Authorization': 'Bearer $authorizationToken',
      };

      Response response = await api.dio.post(
        'fetch-shortlist-profile',
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var data = response.data;
        print('asdadasd ${data.runtimeType} ${data['data'].runtimeType}');
        return List.from(data == null ? [] : data['data'] == null ? [] : data['data'].map((e) => MembersDataModel.fromJson(e)).toList());
      } else {
        return [];
      }
    } catch (error) {
      print('error $error');
      return [];
    }
  }

  Future<Map> setMyShortlistProfile({required String profileId,}) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'shortlisted_profile_id': profileId,
      });

      var headers = {
        'Authorization': 'Bearer $authorizationToken',
      };

      print('aDadadd 123123 ${data.fields}');
      Response response = await api.dio.post(
        'update-set-shortlist-profile',
        data: data,options: Options(
        headers: headers,
      ),
      );
      print('aDadadd ${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        print('Success: ${response.data}');
        return data;
      } else {
        print('Error== ${response.statusMessage}');
        return {};
      }
    } catch (error) {
      print('Error--: $error');
      return {};
    }
  }

  Future<Map> unSetMyShortlistProfile({required String profileId,}) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'shortlisted_profile_id': profileId,
      });

      var headers = {
        'Authorization': 'Bearer $authorizationToken',
      };

      print('aDadadd 123123 ${data.fields}');
      Response response = await api.dio.post(
        'update-un-shortlist-profile',
        data: data,
        options: Options(
          headers: headers,
        ),
      );
      print('aDadadd ${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        print('Success: ${response.data}');
        return data;
      } else {
        print('Error== ${response.statusMessage}');
        return {};
      }
    } catch (error) {
      print('Error--: $error');
      return {};
    }
  }
}
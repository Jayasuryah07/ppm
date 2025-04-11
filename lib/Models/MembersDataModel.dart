// To parse this JSON data, do
//
//     final membersDataModel = membersDataModelFromJson(jsonString);

import 'dart:convert';

List<MembersDataModel> membersDataModelFromJson(String str) => List<MembersDataModel>.from(json.decode(str).map((x) => MembersDataModel.fromJson(x)));

String membersDataModelToJson(List<MembersDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MembersDataModel {
  int? id;
  String? name;
  String? profileFatherFullName;
  DateTime? profileDateOfBirth;
  String? profileGender;
  String? profileTimeOfBirth;
  String? profilePlaceOfBirth;
  String? email;
  String? profileMobile;
  String? profileWhatsapp;
  String? profileMainContactNum;
  String? profileComunityName;
  String? profileGotra;
  String? profilePermanentAddress;
  String? profileWorkingCity;
  String? profileRefContactName;
  String? profileRefContactMobile;
  String? profilePhoto;
  String? profileEducation;
  String? profileOccupation;
  String? profileHaveMarriedBefore;
  String? profileHeight;
  String? profileHeightInch;
  String? profilePhysicalDisablity;
  String? profileNote;
  DateTime? emailVerifiedAt;
  String? profileCpassword;
  int? profileType;
  String? profileViewFlag;
  String? profileLoginFlag;
  String? profileApproved;
  String? profileMarriedStatus;
  DateTime? profileRegistrationDate;
  DateTime? profileValidityEnds;
  String? profileLastLogin;
  String? profileDeviceId;
  int? deviceIdCount;
  String? token;
  DateTime? createdAt;
  DateTime? updatedAt;

  MembersDataModel({
    this.id,
    this.name,
    this.profileFatherFullName,
    this.profileDateOfBirth,
    this.profileGender,
    this.profileTimeOfBirth,
    this.profilePlaceOfBirth,
    this.email,
    this.profileMobile,
    this.profileWhatsapp,
    this.profileMainContactNum,
    this.profileComunityName,
    this.profileGotra,
    this.profilePermanentAddress,
    this.profileWorkingCity,
    this.profileRefContactName,
    this.profileRefContactMobile,
    this.profilePhoto,
    this.profileEducation,
    this.profileOccupation,
    this.profileHaveMarriedBefore,
    this.profileHeight,
    this.profileHeightInch,
    this.profilePhysicalDisablity,
    this.profileNote,
    this.emailVerifiedAt,
    this.profileCpassword,
    this.profileType,
    this.profileViewFlag,
    this.profileLoginFlag,
    this.profileApproved,
    this.profileMarriedStatus,
    this.profileRegistrationDate,
    this.profileValidityEnds,
    this.profileLastLogin,
    this.profileDeviceId,
    this.deviceIdCount,
    this.token,
    this.createdAt,
    this.updatedAt,
  });

  factory MembersDataModel.fromJson(Map<String, dynamic> json) => MembersDataModel(
    id: json["id"],
    name: json["name"],
    profileFatherFullName: json["profile_father_full_name"],
    profileDateOfBirth: json["profile_date_of_birth"] == null ? null : DateTime.parse(json["profile_date_of_birth"]),
    profileGender: json["profile_gender"],
    profileTimeOfBirth: json["profile_time_of_birth"],
    profilePlaceOfBirth: json["profile_place_of_birth"],
    email: json["email"],
    profileMobile: json["profile_mobile"],
    profileWhatsapp: json["profile_whatsapp"],
    profileMainContactNum: json["profile_main_contact_num"],
    profileComunityName: json["profile_comunity_name"],
    profileGotra: json["profile_gotra"],
    profilePermanentAddress: json["profile_permanent_address"],
    profileWorkingCity: json["profile_working_city"],
    profileRefContactName: json["profile_ref_contact_name"],
    profileRefContactMobile: json["profile_ref_contact_mobile"],
    profilePhoto: json["profile_photo"],
    profileEducation: json["profile_education"],
    profileOccupation: json["profile_occupation"],
    profileHaveMarriedBefore: json["profile_have_married_before"],
    profileHeight: json["profile_height"],
    profileHeightInch: json["profile_height_inch"],
    profilePhysicalDisablity: json["profile_physical_disablity"],
    profileNote: json["profile_note"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    profileCpassword: json["profile_cpassword"],
    profileType: json["profile_type"],
    profileViewFlag: json["profile_view_flag"],
    profileLoginFlag: json["profile_login_flag"],
    profileApproved: json["profile_approved"],
    profileMarriedStatus: json["profile_married_status"],
    profileRegistrationDate: json["profile_registration_date"] == null ? null : DateTime.parse(json["profile_registration_date"]),
    profileValidityEnds: json["profile_validity_ends"] == null ? null : DateTime.parse(json["profile_validity_ends"]),
    profileLastLogin: json["profile_last_login"],
    profileDeviceId: json["profile_device_id"],
    deviceIdCount: json["device_id_count"],
    token: json["token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_father_full_name": profileFatherFullName,
    "profile_date_of_birth": profileDateOfBirth?.toIso8601String(),
    "profile_gender": profileGender,
    "profile_time_of_birth": profileTimeOfBirth,
    "profile_place_of_birth": profilePlaceOfBirth,
    "email": email,
    "profile_mobile": profileMobile,
    "profile_whatsapp": profileWhatsapp,
    "profile_main_contact_num": profileMainContactNum,
    "profile_comunity_name": profileComunityName,
    "profile_gotra": profileGotra,
    "profile_permanent_address": profilePermanentAddress,
    "profile_working_city": profileWorkingCity,
    "profile_ref_contact_name": profileRefContactName,
    "profile_ref_contact_mobile": profileRefContactMobile,
    "profile_photo": profilePhoto,
    "profile_education": profileEducation,
    "profile_occupation": profileOccupation,
    "profile_have_married_before": profileHaveMarriedBefore,
    "profile_height": profileHeight,
    "profile_height_inch": profileHeightInch,
    "profile_physical_disablity": profilePhysicalDisablity,
    "profile_note": profileNote,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "profile_cpassword": profileCpassword,
    "profile_type": profileType,
    "profile_view_flag": profileViewFlag,
    "profile_login_flag": profileLoginFlag,
    "profile_approved": profileApproved,
    "profile_married_status": profileMarriedStatus,
    "profile_registration_date": profileRegistrationDate?.toIso8601String(),
    "profile_validity_ends": profileValidityEnds?.toIso8601String(),
    "profile_last_login": profileLastLogin,
    "profile_device_id": profileDeviceId,
    "device_id_count": deviceIdCount,
    "token": token,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

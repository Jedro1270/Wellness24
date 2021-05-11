// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewAccount _$NewAccountFromJson(Map<String, dynamic> json) {
  return NewAccount(
    json['role'] as String,
  )
    ..uid = json['uid'] as String
    ..email = json['email'] as String
    ..password = json['password'] as String
    ..contactNo = json['contactNo'] as String
    ..lastName = json['lastName'] as String
    ..firstName = json['firstName'] as String
    ..middleInitial = json['middleInitial'] as String
    ..address = json['address'] as String
    ..gender = json['gender'] as String
    ..specialization = json['specialization'] as String
    ..licenseNo = json['licenseNo'] as String
    ..clinicLocation = json['clinicLocation'] as String
    ..clinicStart = json['clinicStart'] as String
    ..clinicEnd = json['clinicEnd'] as String
    ..workingDays = json['workingDays'] as String
    ..education = json['education'] as String
    ..about = json['about'] as String
    ..keywords = (json['keywords'] as List).map((e) => e as String).toList()
    ..medicalHistory =
        (json['medicalHistory'] as List).map((e) => e as String).toList()
    ..birthDate = DateTime.parse(json['birthDate'] as String);
}

Map<String, dynamic> _$NewAccountToJson(NewAccount instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'role': instance.role,
      'email': instance.email,
      'password': instance.password,
      'contactNo': instance.contactNo,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'middleInitial': instance.middleInitial,
      'address': instance.address,
      'gender': instance.gender,
      'specialization': instance.specialization,
      'licenseNo': instance.licenseNo,
      'clinicLocation': instance.clinicLocation,
      'clinicStart': instance.clinicStart,
      'clinicEnd': instance.clinicEnd,
      'workingDays': instance.workingDays,
      'education': instance.education,
      'about': instance.about,
      'keywords': instance.keywords,
      'medicalHistory': instance.medicalHistory,
      'birthDate': instance.birthDate.toIso8601String(),
    };

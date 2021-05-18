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
    ..contactNumber = json['contactNumber'] as String
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
    ..keywords = (json['keywords'] as List)?.map((e) => e as String)?.toList()
    ..medicalHistory =
        (json['medicalHistory'] as List)?.map((e) => e as String)?.toList()
    ..birthDate = json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String);
}

Map<String, dynamic> _$NewAccountToJson(NewAccount instance) {
  final val = <String, dynamic>{
    'uid': instance.uid,
    'role': instance.role,
    'email': instance.email,
    'contactNumber': instance.contactNumber,
    'lastName': instance.lastName,
    'firstName': instance.firstName,
    'middleInitial': instance.middleInitial,
    'address': instance.address,
    'gender': instance.gender,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('specialization', instance.specialization);
  writeNotNull('licenseNo', instance.licenseNo);
  writeNotNull('clinicLocation', instance.clinicLocation);
  writeNotNull('clinicStart', instance.clinicStart);
  writeNotNull('clinicEnd', instance.clinicEnd);
  writeNotNull('workingDays', instance.workingDays);
  writeNotNull('education', instance.education);
  writeNotNull('about', instance.about);
  val['keywords'] = instance.keywords;
  val['medicalHistory'] = instance.medicalHistory;
  val['birthDate'] = instance.birthDate?.toIso8601String();
  return val;
}

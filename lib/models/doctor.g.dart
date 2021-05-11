// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) {
  return Doctor(
    uid: json['uid'] as String,
    firstName: json['firstName'] as String,
    middleInitial: json['middleInitial'] as String,
    lastName: json['lastName'] as String,
    specialization: json['specialization'] as String,
    about: json['about'] as String,
    workingDays: json['workingDays'] as String,
    clinicStart: json['clinicStart'] as String,
    clinicEnd: json['clinicEnd'] as String,
    clinicDayEnd: json['clinicDayEnd'] as String,
    clinicDayStart: json['clinicDayStart'] as String,
    education: json['education'] as String,
  );
}

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'middleInitial': instance.middleInitial,
      'lastName': instance.lastName,
      'specialization': instance.specialization,
      'about': instance.about,
      'workingDays': instance.workingDays,
      'clinicStart': instance.clinicStart,
      'clinicEnd': instance.clinicEnd,
      'clinicDayStart': instance.clinicDayStart,
      'clinicDayEnd': instance.clinicDayEnd,
      'education': instance.education,
    };

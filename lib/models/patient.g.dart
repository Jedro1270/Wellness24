// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient(
    firstName: json['firstName'] as String,
    middleInitial: json['middleInitial'] as String,
    lastName: json['lastName'] as String,
    gender: json['gender'] as String,
    birthDate: json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
    address: json['address'] as String,
    contactNumber: json['contactNumber'] as String,
    medicalHistory: json['medicalHistory'] as List,
    bloodType: json['bloodType'] as String,
    weight: (json['weight'] as num)?.toDouble(),
    height: (json['height'] as num)?.toDouble(),
    bodyTemperature: (json['bodyTemperature'] as num)?.toDouble(),
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'middleInitial': instance.middleInitial,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'birthDate': instance.birthDate?.toIso8601String(),
      'address': instance.address,
      'contactNumber': instance.contactNumber,
      'weight': instance.weight,
      'bodyTemperature': instance.bodyTemperature,
      'height': instance.height,
      'bloodType': instance.bloodType,
      'medicalHistory': instance.medicalHistory,
    };

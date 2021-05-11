// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyContact _$EmergencyContactFromJson(Map<String, dynamic> json) {
  return EmergencyContact(
    lastName: json['lastName'] as String,
    firstName: json['firstName'] as String,
    middleInitial: json['middleInitial'] as String,
    address: json['address'] as String,
    contactNumber: json['contactNumber'] as String,
    relationship: json['relationship'] as String,
  );
}

Map<String, dynamic> _$EmergencyContactToJson(EmergencyContact instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'middleInitial': instance.middleInitial,
      'address': instance.address,
      'contactNumber': instance.contactNumber,
      'relationship': instance.relationship,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalRecord _$MedicalRecordFromJson(Map<String, dynamic> json) {
  return MedicalRecord(
    patientUid: json['patientUid'] as String,
    id: json['id'] as String,
    title: json['title'] as String,
    imageUrl: json['imageUrl'] as String,
    notes: json['notes'] as String,
    lastEdited: DateTime.parse(json['lastEdited'] as String),
  );
}

Map<String, dynamic> _$MedicalRecordToJson(MedicalRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientUid': instance.patientUid,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'notes': instance.notes,
      'lastEdited': instance.lastEdited.toIso8601String(),
    };

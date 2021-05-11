// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalHistoryEntry _$MedicalHistoryEntryFromJson(Map<String, dynamic> json) {
  return MedicalHistoryEntry(
    title: json['title'] as String,
    value: json['value'] as bool,
  );
}

Map<String, dynamic> _$MedicalHistoryEntryToJson(
        MedicalHistoryEntry instance) =>
    <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
    };

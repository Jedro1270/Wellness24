// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_sugar_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodSugarLevel _$BloodSugarLevelFromJson(Map<String, dynamic> json) {
  return BloodSugarLevel(
    reading: json['reading'] as String,
    lastChecked: DateTime.parse(json['lastChecked'] as String),
  );
}

Map<String, dynamic> _$BloodSugarLevelToJson(BloodSugarLevel instance) =>
    <String, dynamic>{
      'reading': instance.reading,
      'lastChecked': instance.lastChecked.toIso8601String(),
    };

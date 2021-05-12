// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodPressure _$BloodPressureFromJson(Map<String, dynamic> json) {
  return BloodPressure(
    reading: json['reading'] as String,
    lastChecked: DateTime.parse(json['lastChecked'] as String),
  );
}

Map<String, dynamic> _$BloodPressureToJson(BloodPressure instance) =>
    <String, dynamic>{
      'reading': instance.reading,
      'lastChecked': instance.lastChecked.toIso8601String(),
    };

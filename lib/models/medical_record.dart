import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medical_record.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class MedicalRecord {
  String id;
  String patientUid;
  String title;
  String imageUrl;
  String notes;
  DateTime lastEdited;

  MedicalRecord(
      {this.patientUid,
      this.id,
      this.title,
      this.imageUrl,
      this.notes,
      this.lastEdited});

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    json["lastEdited"] = ((json["lastEdited"] as Timestamp).toDate().toString());
    return _$MedicalRecordFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MedicalRecordToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'medical_history_entry.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class MedicalHistoryEntry {
  String title;
  bool value;

  MedicalHistoryEntry({
    this.title,
    this.value = false,
  });

  factory MedicalHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$MedicalHistoryEntryFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalHistoryEntryToJson(this);
}

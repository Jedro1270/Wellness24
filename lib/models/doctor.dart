import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class Doctor {
  String uid;
  String firstName;
  String middleInitial;
  String lastName;
  String specialization;
  String about;
  String workingDays;
  String clinicStartHour;
  String clinicEndHour;
  String clinicDayStart;
  String clinicDayEnd;
  String education;

  Doctor(
      {this.uid,
      this.firstName,
      this.middleInitial,
      this.lastName,
      this.specialization,
      this.about,
      this.workingDays,
      this.clinicStartHour,
      this.clinicEndHour,
      this.clinicDayEnd,
      this.clinicDayStart,
      this.education});

  String get fullName {
    return '$firstName $middleInitial. $lastName';
  }

  factory Doctor.fromJson(Map<String, dynamic> json, String uid) {
    return _$DoctorFromJson(json)..uid = uid;
  }

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}

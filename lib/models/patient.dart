import 'package:age/age.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/blood_sugar_level.dart';
import 'package:wellness24/models/emergency_contact.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Patient {
  String uid;
  String firstName;
  String middleInitial;
  String lastName;
  String gender;
  DateTime birthDate;
  String address;
  String contactNumber;
  double weight;
  double bodyTemperature;
  double height;
  String bloodType;

  @JsonKey(ignore: true)
  BloodPressure bloodPressure;
  @JsonKey(ignore: true)
  BloodSugarLevel bloodSugarLevel;

  List medicalHistory;

  @JsonKey(ignore: true)
  EmergencyContact emergencyContact;

  Patient(
      {this.firstName,
      this.middleInitial,
      this.lastName,
      this.gender,
      this.birthDate,
      this.address,
      this.contactNumber,
      this.medicalHistory,
      this.emergencyContact,
      this.bloodPressure,
      this.bloodSugarLevel,
      this.bloodType,
      this.weight,
      this.height,
      this.bodyTemperature,
      this.uid});

  String get fullName {
    return '$firstName $middleInitial. $lastName';
  }

  int get age {
    DateTime present = DateTime.now();

    return Age.dateDifference(fromDate: birthDate, toDate: present).years;
  }

  Map get object {
    return {
      uid: this.uid,
      firstName: this.firstName,
      lastName: this.lastName,
      middleInitial: this.middleInitial,
      birthDate: this.birthDate,
      contactNumber: this.contactNumber,
      address: this.address,
      bloodType: this.bloodType,
      weight: this.weight,
      gender: this.gender,
      medicalHistory: this.medicalHistory
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json, String uid) {
    return _$PatientFromJson(json)..uid = uid;
  }

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}

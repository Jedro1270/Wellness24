import 'package:age/age.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/emergency_contact.dart';

class Patient {
  String firstName;
  String middleInitial;
  String lastName;
  String gender;
  String birthDate;
  String address;
  String contactNo;
  double weight;
  String bloodType;
  BloodPressure bloodPressure;
  List<String> medicalHistory;
  EmergencyContact emergencyContact;

  Patient(
      {this.firstName,
      this.middleInitial,
      this.lastName,
      this.gender,
      this.birthDate,
      this.address,
      this.contactNo,
      this.medicalHistory,
      this.emergencyContact,
      this.bloodPressure,
      this.bloodType,
      this.weight});

  String get fullName {
    return '$firstName $middleInitial. $lastName';
  }

  int get age {
    DateTime birthDateTime = DateTime.tryParse(birthDate);
    DateTime present = DateTime.now();

    if (birthDateTime == null) {
      birthDateTime = DateTime.parse(
          '1974-03-20 00:00:00.000'); // For testing only, birthdate must be changed to datetime for future use
    }

    return Age.dateDifference(fromDate: birthDateTime, toDate: present).years;
  }
}

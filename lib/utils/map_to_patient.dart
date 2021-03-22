import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/blood_pressure.dart';

Patient mapToPatient(dynamic patientInfo) {
  print(patientInfo);
  print(patientInfo['firstName']);
  print(patientInfo['middleInitial']);

  return Patient(
      firstName: patientInfo['firstName'],
      middleInitial: patientInfo['middleInitial'],
      lastName: patientInfo['lastName'],
      gender: patientInfo['gender'],
      birthDate: patientInfo['birthDate'],
      address: patientInfo['address'],
      contactNo: patientInfo['contactNo'],
      medicalHistory: patientInfo['medicalHistory'],
      emergencyContact: patientInfo['emergencyContact'] ?? null,
      bloodPressure: patientInfo['lastChecked']
          ? BloodPressure(
              reading: patientInfo['reading'],
              lastChecked: patientInfo['lastChecked'].toDate())
          : null,
      bloodType: patientInfo['bloodType'],
      weight: patientInfo['weight']);
}

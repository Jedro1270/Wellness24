import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/common_pages/medical_records/medical_records.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/blood_sugar_level.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:wellness24/services/database.dart';

void main() {
  Future<Patient> mockGetPatient(String uid, database) async {
    var snapshotPatient = await database.patients.document(uid).get();

    var snapshotBloodPressure =
        await database.bloodPressures.document(uid).get();

    var snapshotBloodSugarLevel =
        await database.bloodSugarLevels.document(uid).get();

    return Patient(
        uid: snapshotPatient.documentID,
        firstName: snapshotPatient.data['firstName'],
        middleInitial: snapshotPatient.data['middleInitial'],
        lastName: snapshotPatient.data['lastName'],
        gender: snapshotPatient.data['gender'],
        birthDate: snapshotPatient.data['birthDate'],
        medicalHistory: snapshotPatient.data['medicalHistory'],
        bloodPressure: BloodPressure(
            reading: snapshotBloodPressure.data['reading'],
            lastChecked: snapshotBloodPressure.data['lastChecked']),
        bloodSugarLevel: BloodSugarLevel(
            reading: snapshotBloodSugarLevel.data['reading'],
            lastChecked: snapshotBloodSugarLevel.data['lastChecked']),
        bloodType: snapshotPatient.data['bloodType'],
        weight: snapshotPatient.data['weight'],
        height: snapshotPatient.data['height'],
        bodyTemperature: snapshotPatient.data['bodyTemperature']);
  }
  testWidgets(
      'Medical History should show the list of medical history of the patient',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      final MockFirestoreInstance instance = MockFirestoreInstance();

      final String uid = '101';
      final DatabaseService database =
          DatabaseService(uid: uid, firestore: instance);

      await instance.collection('patients').document(uid).setData({
        'medicalHistory': ['asthma', 'diabetes']
      });

      Patient testPatient = await mockGetPatient(uid, database);

      await tester.pumpWidget(MaterialApp(
          home: MedicalRecords(editable: false, patient: testPatient),
          ));

      expect(find.text('asthma'), findsOneWidget);
      expect(find.text('diabetes'), findsOneWidget);
    });
  });
}

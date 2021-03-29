import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/components/pages/common_pages/patient_profile/patient_profile.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/blood_sugar_level.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/services/database.dart';

void main() {
  testWidgets(
      'PatientProfile should show the current conditions of patient from firestore data',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      final MockFirestoreInstance instance = MockFirestoreInstance();

      final String uid = '123';
      final DatabaseService database =
          DatabaseService(uid: uid, firestore: instance);

      await instance.collection('patients').document(uid).setData({
        'firstName': 'Jedro Vienne Deo',
        'middleInitial': 'E',
        'lastName': 'Pagayonan',
        'birthDate': DateTime(2000, 1, 27),
        'gender': 'Male',
        'bodyTemperature': 36.5,
        'bloodType': 'O',
        'weight': 75.00,
        'height': 172.72
      });

      await instance
          .collection('bloodPressures')
          .document(uid)
          .setData({'lastChecked': DateTime.now(), 'reading': '120/80 mm'});

      await instance
          .collection('bloodSugarLevels')
          .document(uid)
          .setData({'lastChecked': DateTime.now(), 'reading': '100 mg'});

      Future<Patient> mockGetPatient(String uid) async {
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
            birthDate: snapshotPatient.data['birthDate'].toDate(),
            medicalHistory: snapshotPatient.data['medicalHistory'],
            bloodPressure: snapshotBloodPressure == null
                ? null
                : BloodPressure(
                    reading: snapshotBloodPressure.data['reading'],
                    lastChecked:
                        snapshotBloodPressure.data['lastChecked'].toDate()),
            bloodSugarLevel: snapshotBloodSugarLevel == null
                ? null
                : BloodSugarLevel(
                    reading: snapshotBloodSugarLevel.data['reading'],
                    lastChecked:
                        snapshotBloodSugarLevel.data['lastChecked'].toDate()),
            bloodType: snapshotPatient.data['bloodType'],
            weight: snapshotPatient.data['weight'],
            height: snapshotPatient.data['height'],
            bodyTemperature: snapshotPatient.data['bodyTemperature']);
      }

      Patient testPatient = await mockGetPatient(uid);

      await tester.pumpWidget(MaterialApp(
          home: PatientProfile(
              editable: false, patient: testPatient, database: database)));

      final headerFinder = find.text('Patient Conditions');
      expect(headerFinder, findsOneWidget);

      final fullNameFinder = find.text('Jedro Vienne Deo E. Pagayonan');
      expect(fullNameFinder, findsOneWidget);

      final genderFinder = find.text('Male');
      expect(genderFinder, findsOneWidget);

      final bodyTemperatureFinder = find.text('36.5');
      expect(bodyTemperatureFinder, findsOneWidget);

      final weightFinder = find.text('75.0');
      expect(weightFinder, findsOneWidget);

      final heightFinder = find.text('172.72');
      expect(heightFinder, findsOneWidget);

      final bloodTypeFinder = find.text('O');
      expect(bloodTypeFinder, findsOneWidget);
    });
  });
}

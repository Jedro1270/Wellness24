import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/common_pages/medical_records/medical_records.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/blood_sugar_level.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:wellness24/services/database.dart';

void main() {
  testWidgets(
      'Medical History should show the list of medical history of the patient',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      final MockFirestoreInstance instance = MockFirestoreInstance();

      final String uid = '101';
      final DatabaseService database =
          DatabaseService(uid: uid, firestore: instance);

      await instance.collection('patients').document(uid).setData({
        'medicalHistory': ['asthma', 'diabetes'],
        'birthDate': DateTime(2000, 1, 1)
      });

      Patient testPatient = await database.getPatient(uid);

      await tester.pumpWidget(MaterialApp(
        home: MedicalRecords(editable: false, patient: testPatient),
      ));

      expect(find.text('asthma'), findsOneWidget);
      expect(find.text('diabetes'), findsOneWidget);
    });
  });
}

import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/doctor_screen/doctor_home_page.dart';
import 'package:wellness24/components/pages/doctor_screen/notification_page.dart';
import 'package:wellness24/components/pages/doctor_screen/patients_list/my_patients_list.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/blood_sugar_level.dart';
import 'package:wellness24/services/database.dart';
import 'package:provider/provider.dart';

void main() {
  Future<Patient> mockInitializePatient(String uid, database) async {
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
        bloodPressure: BloodPressure(
            reading: snapshotBloodPressure.data['reading'],
            lastChecked: snapshotBloodPressure.data['lastChecked'].toDate()),
        bloodSugarLevel: BloodSugarLevel(
            reading: snapshotBloodSugarLevel.data['reading'],
            lastChecked: snapshotBloodSugarLevel.data['lastChecked'].toDate()),
        bloodType: snapshotPatient.data['bloodType'],
        weight: snapshotPatient.data['weight'],
        height: snapshotPatient.data['height'],
        bodyTemperature: snapshotPatient.data['bodyTemperature']);
  }

  Future<User> mockUser(String uid, database) async {
    var snapshotUser = await database.user.document(uid).get();

    return User(
        uid: snapshotUser.documentID, email: snapshotUser.data['email']);
  }

  Future<MyPatientsList> mockPatientList(String uid, database) async {
    var snapshotList = await database.myPatientsList.document(uid).get();

    return MyPatientsList(
      // doctorDatabaseRef: ,
      doctorId: snapshotList.documentID,
    );
  }

  group('Doctor Home Page', () {
    testWidgets('Should display list of patients',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        final MockFirestoreInstance instance = MockFirestoreInstance();

        final String uid = '101';
        final DatabaseService database =
            DatabaseService(uid: uid, firestore: instance);

        await instance.collection('patient').document(uid).setData({
          'firstName': 'patient1',
          'middleInitial': 'W',
          'lastName': 'asdf',
        });

        await instance
            .collection('user')
            .document(uid)
            .setData({'email': 'doctor@gmail.com'});

        User testUser = await mockUser(uid, database);

        await tester.pumpWidget(MaterialApp(
            home: Provider<User>(
                create: (context) => testUser, 
                builder: (context, DoctorHomePage) {
                  return DoctorHomePage;
                },)));

        final patientFinder = find.text('patient1 W asdf');
        expect(patientFinder, findsOneWidget);
      });
    });

    testWidgets('Should show Notification Page',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(home: DoctorHomePage()));

        final notifIcon = find.byKey(Key('notifBtn'));
        await tester.tap(notifIcon);
        await tester.pump();

        final notifPageFinder = find.byType(NotificationPage);

        expect(notifPageFinder, findsOneWidget);
      });
    });
  });
}

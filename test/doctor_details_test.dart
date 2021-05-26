// import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:wellness24/components/pages/patient_screen/doctor_details.dart';
// import 'package:wellness24/models/blood_pressure.dart';
// import 'package:wellness24/models/blood_sugar_level.dart';
// import 'package:wellness24/models/doctor.dart';
// import 'package:wellness24/models/patient.dart';
// import 'package:wellness24/services/database.dart';

// void main() {
//   Future<Doctor> mockGetDoctor(String uid, database) async {
//     var snapshotDoctor = await database.doctors.document(uid).get();

//     return Doctor(
//         uid: snapshotDoctor.documentID,
//         firstName: snapshotDoctor['firstName'],
//         middleInitial: snapshotDoctor['middleInitial'],
//         lastName: snapshotDoctor['lastName'],
//         specialization: snapshotDoctor['specialization'],
//         about: snapshotDoctor['about'],
//         workingDays: snapshotDoctor['workingDays'],
//         clinicStart: snapshotDoctor['clinicStart'],
//         clinicEnd: snapshotDoctor['clinicEnd'],
//         education: snapshotDoctor['education']);
//   }

//   Future<Patient> mockGetPatient(String uid, database) async {
//     var snapshotPatient = await database.patients.document(uid).get();
//     var snapshotBloodPressure =
//         await database.bloodPressures.document(uid).get();

//     var snapshotBloodSugarLevel =
//         await database.bloodSugarLevels.document(uid).get();

//     return Patient(
//         uid: snapshotPatient.documentID,
//         firstName: snapshotPatient.data['firstName'],
//         middleInitial: snapshotPatient.data['middleInitial'],
//         lastName: snapshotPatient.data['lastName'],
//         gender: snapshotPatient.data['gender'],
//         birthDate: snapshotPatient.data['birthDate'].toDate(),
//         medicalHistory: snapshotPatient.data['medicalHistory'],
//         bloodPressure: BloodPressure(
//             reading: snapshotBloodPressure.data['reading'],
//             lastChecked: snapshotBloodPressure.data['lastChecked'].toDate()),
//         bloodSugarLevel: BloodSugarLevel(
//             reading: snapshotBloodSugarLevel.data['reading'],
//             lastChecked: snapshotBloodSugarLevel.data['lastChecked'].toDate()),
//         bloodType: snapshotPatient.data['bloodType'],
//         weight: snapshotPatient.data['weight'],
//         height: snapshotPatient.data['height'],
//         bodyTemperature: snapshotPatient.data['bodyTemperature']);
//   }

//   group('DcotorDetails', () {
//     final MockFirestoreInstance instance = MockFirestoreInstance();

//     final String uid = '123';
//     final DatabaseService database =
//         DatabaseService(uid: uid, firestore: instance);

//     testWidgets(
//         'should show fullName, about, education and working days and hours',
//         (WidgetTester tester) async {
//       await instance.collection('doctors').document(uid).setData({
//         'about': 'Lorem ipsum dolor sit amet',
//         'firstName': 'Jedro Vienne Deo',
//         'middleInitial': 'E',
//         'lastName': 'Pagayonan',
//         'specialization': 'General Medicine',
//         'education': 'Doctorate',
//         'clinicEnd': '5:30 PM',
//         'clinicStart': '8:30 AM',
//         'workingDays': 'Monday to Friday'
//       });

//       await instance.collection('patients').document(uid).setData({
//         'firstName': 'Jedro Vienne Deo',
//         'middleInitial': 'E',
//         'lastName': 'Pagayonan',
//         'birthDate': DateTime(2000, 1, 27),
//         'gender': 'Male',
//         'bodyTemperature': 36.5,
//         'bloodType': 'O',
//         'weight': 75.00,
//         'height': 172.72
//       });

//       await instance
//           .collection('bloodPressures')
//           .document(uid)
//           .setData({'lastChecked': DateTime.now(), 'reading': '120/80 mm'});

//       await instance
//           .collection('bloodSugarLevels')
//           .document(uid)
//           .setData({'lastChecked': DateTime.now(), 'reading': '100 mg'});

//       Doctor testDoctor = await mockGetDoctor(uid, database);
//       Patient testPatient = await mockGetPatient(uid, database);

//       await tester.runAsync(() async {
//         await tester.pumpWidget(MaterialApp(
//             home: DoctorDetails(
//                 doctor: testDoctor, currentPatient: testPatient)));

//         final fullNameFinder = find.byWidgetPredicate(
//             (Widget widget) => // This method is needed for TextSpan
//                 widget is RichText &&
//                 widget.text
//                     .toPlainText()
//                     .startsWith('Jedro Vienne Deo E. Pagayonan'));

//         // final aboutFinder = find.text('Lorem ipsum dolor sit amet');
//         // final educationFinder = find.text('Doctorate');
//         // final workingDaysAndHoursFinder =
//         //     find.text('Monday to Friday: 8:30 AM - 5:30 PM');

//         expect(fullNameFinder, findsOneWidget);
//         // expect(aboutFinder, findsOneWidget);
//         // expect(educationFinder, findsOneWidget);
//         // expect(workingDaysAndHoursFinder, findsOneWidget);
//       });
//     });
//   });
// }

import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/doctor_screen/doctor_home_page.dart';
import 'package:wellness24/components/pages/doctor_screen/notification_page.dart';
import 'package:wellness24/components/pages/doctor_screen/patients_list/my_patients_list.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/blood_sugar_level.dart';
import 'package:wellness24/services/auth_service.dart';
import 'package:wellness24/services/database.dart';
import 'package:provider/provider.dart';

void main() {
  group('Doctor Home Page', () {
    final String uid = '101';
    Doctor mockDoctor = Doctor(
        uid: uid, firstName: 'Darla', lastName: 'Abagat', middleInitial: 'F');

    List<Patient> mockPatients = [
      Patient(
          firstName: 'Veto',
          lastName: 'Bastiero III',
          middleInitial: 'C',
          contactNo: '09221231123'),
      Patient(
          firstName: 'Jedro',
          lastName: 'Pagayonan',
          middleInitial: 'Y',
          contactNo: '09999999999')
    ];
    testWidgets('Should display list of patients', (WidgetTester tester) async {
      await tester.runAsync(() async {
        final MockFirestoreInstance instance = MockFirestoreInstance();

        await tester.pumpWidget(MaterialApp(
            home: StreamProvider<User>.value(
          initialData: User(uid: uid),
          value: Stream<User>.value(User(uid: uid)),
          child: DoctorHomePage(
              mockDoctor: mockDoctor, mockPatients: mockPatients),
        )));

        final patient1 = find.text('Veto C. Bastiero III');
        expect(patient1, findsOneWidget);
      });
    });

    // testWidgets('Should show Notification Page', (WidgetTester tester) async {
    //   await tester.runAsync(() async {
    //     await tester.pumpWidget(MaterialApp(
    //         home: DoctorHomePage(
    //       mockDoctor: mockDoctor,
    //     )));

    //     final notifIcon = find.byKey(Key('notifBtn'));
    //     await tester.tap(notifIcon);
    //     await tester.pump();

    //     final notifPageFinder = find.byType(NotificationPage);

    //     expect(notifPageFinder, findsOneWidget);
    //   });
    // });
  });
}

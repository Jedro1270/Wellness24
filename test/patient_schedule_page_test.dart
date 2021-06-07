import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/pages/patient_screen/patient_schedule_page.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/user.dart';

void main() {
  group('Patient schedule page', () {
    final String uid = '101';
    Doctor mockDoctor = Doctor(
      firstName: 'Darla',
      lastName: 'Abagat',
      middleInitial: 'F',
      workingDays: 'Monday to Friday',
      clinicStart: '7:00 AM',
      clinicEnd: '5:00 PM'
    );

    Patient mockPatient = Patient(
      uid: uid,
      firstName: 'Veto',
      lastName: 'Bastiero III',
      middleInitial: 'C',
      contactNumber: '09221231123'
    );

    testWidgets('Should display details of doctor', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          home: StreamProvider<User>.value(
            initialData: User(uid: uid),
            value: Stream<User>.value(User(uid: uid)),
            child: PatientAppointmentPage(
                doctor: mockDoctor, currentPatient: mockPatient),
            )
          )
        );

        final workingDays = find.text('Monday to Friday');
        final clinicHours = find.text('7:00 AM - 5:00 PM');
        expect(workingDays, findsOneWidget);
        expect(clinicHours, findsOneWidget);
      });
    });

    testWidgets('Should be able to press schedule appointment button', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
            home: StreamProvider<User>.value(
          initialData: User(uid: uid),
          value: Stream<User>.value(User(uid: uid)),
          child: PatientAppointmentPage(
              doctor: mockDoctor, currentPatient: mockPatient),
        )));

        final appointmentBtn = find.byKey(Key('appointmentBtn'));

        await tester.tap(appointmentBtn);
        await tester.pump();

        final popUp = find.byType(AlertDialog);
        expect(appointmentBtn, findsOneWidget);
        expect(popUp, findsOneWidget);
      });
    });
  });
}
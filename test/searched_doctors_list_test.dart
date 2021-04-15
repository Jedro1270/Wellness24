import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/doctor_info.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/searched_doctors_list.dart';

void main() {
  group('SearchedDoctorsList', () {
    testWidgets(
        ' should render all available doctors if filter is "any" and search bar is empty',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        final instance = MockFirestoreInstance();

        await instance.collection('doctors').add({
          'email': 'elim@yahoo.com',
          'contactNumber': '12345689',
          'lastName': 'abagat',
          'firstName': 'elim',
          'middleInitial': 'c',
          'birthDate': '09-10-00',
          'address': 'antique',
          'gender': 'female',
          'licenseNo': '09328423',
          'clinicLocation': 'antique',
          'clinicStart': '7:00 am',
          'clinicEnd': '12:00 pm',
          'specialization': 'Neurologist'
        });

        await instance.collection('doctors').add({
          'email': 'jedro1270@gmail.com',
          'contactNumber': '43223441',
          'lastName': 'Pagayonan',
          'firstName': 'Jedro',
          'middleInitial': 'E',
          'birthDate': '01-27-00',
          'address': 'Antique',
          'gender': 'Male',
          'licenseNo': '09328423',
          'clinicLocation': 'antique',
          'clinicStart': '7:00 am',
          'clinicEnd': '12:00 pm',
          'specialization': 'General Medicine'
        });

        await tester.pumpWidget(
          MaterialApp(
              home: Scaffold(
                  body: SearchedDoctorsList(
                      doctorDatabaseRef: instance.collection('doctors'),
                      searchValue: '',
                      filterValue: 'any'))),
        );

        await tester.pump();

        final doctorsListFinder = find.byType(DoctorInfo);
        expect(doctorsListFinder, findsNWidgets(2));
      });
    });

    testWidgets(
        ' should render doctors based on specialization filter if search bar is empty',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        final instance = MockFirestoreInstance();

        await instance.collection('doctors').add({
          'email': 'elim@yahoo.com',
          'contactNumber': '12345689',
          'lastName': 'abagat',
          'firstName': 'elim',
          'middleInitial': 'c',
          'birthDate': '09-10-00',
          'address': 'antique',
          'gender': 'female',
          'licenseNo': '09328423',
          'clinicLocation': 'antique',
          'clinicStart': '7:00 am',
          'clinicEnd': '12:00 pm',
          'specialization': 'Neurologist'
        });

        await instance.collection('doctors').add({
          'email': 'jedro1270@gmail.com',
          'contactNumber': '43223441',
          'lastName': 'Pagayonan',
          'firstName': 'Jedro',
          'middleInitial': 'E',
          'birthDate': '01-27-00',
          'address': 'Antique',
          'gender': 'Male',
          'licenseNo': '09328423',
          'clinicLocation': 'antique',
          'clinicStart': '7:00 am',
          'clinicEnd': '12:00 pm',
          'specialization': 'General Medicine'
        });

        final doctorsListFinder = find.byType(DoctorInfo);

        await tester.pumpWidget(
          MaterialApp(
              home: Scaffold(
                  body: SearchedDoctorsList(
                      doctorDatabaseRef: instance.collection('doctors'),
                      searchValue: '',
                      filterValue: 'Neurologist'))),
        );

        await tester.pump();
        expect(doctorsListFinder, findsOneWidget);

        await tester.pumpWidget(
          MaterialApp(
              home: Scaffold(
                  body: SearchedDoctorsList(
                      doctorDatabaseRef: instance.collection('doctors'),
                      searchValue: '',
                      filterValue: 'General Medicine'))),
        );

        await tester.pump();
        expect(doctorsListFinder, findsOneWidget);
      });
    });
  });
}

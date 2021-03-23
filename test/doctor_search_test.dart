import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/doctor_info.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/doctor_search_page.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/searched_doctors_list.dart';

void main() {
  testWidgets('DoctorSearchPage should render a DoctorInfo widget if there is a doctor in the firestore based on the search and filter parameters', (WidgetTester tester) async {
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

    final doctorReference = instance.collection('doctors');

    Widget createWidgetForTesting({Widget child}) {
      return MaterialApp(home: child);
    }

    await tester.pumpWidget(createWidgetForTesting(
        child: DoctorSearchPage(
            searchValue: '',
            filterValue: 'neurologist',
            doctorDatabaseRef: doctorReference)));

    final doctorsListFinder = find.byType(SearchedDoctorsList);
    final doctorInfoFinder = find.byType(DoctorInfo);

    expect(doctorsListFinder, findsOneWidget);

    await tester.pump(Duration(seconds: 10));

    expect(doctorInfoFinder, findsOneWidget);
  });
}
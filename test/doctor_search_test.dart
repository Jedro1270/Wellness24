import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/components/pages/doctor_search_page/doctor_search_page.dart';
import 'package:wellness24/components/pages/doctor_search_page/doctors_list.dart';

void main() {
  testWidgets('search widget', (WidgetTester tester) async {

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

  //   print(instance.dump());

    await tester.pumpWidget(DoctorSearchPage(searchValue: '', filterValue: 'neurologist'));

    final doctorFinder = find.text('elim');
    expect(doctorFinder, findsOneWidget);
  });
}
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/doctor_search_page.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/searched_doctors_list.dart';

void main() {
  testWidgets('DoctorSearchPage should render SearchedDoctorsList',
      (WidgetTester tester) async {
    final instance = MockFirestoreInstance();
    final doctorReference = instance.collection('doctors');

    Widget createWidgetForTesting({Widget child}) {
      return MaterialApp(home: child);
    }

    await tester.pumpWidget(createWidgetForTesting(
        child: DoctorSearchPage(doctorDatabaseRef: doctorReference)));

    await tester.pump(Duration(seconds: 1));

    final doctorsListFinder = find.byType(SearchedDoctorsList);
    expect(doctorsListFinder, findsOneWidget);
  });
}

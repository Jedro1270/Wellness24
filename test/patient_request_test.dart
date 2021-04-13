import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/components/pages/doctor_screen/view_request_component.dart';
import 'package:wellness24/services/database.dart';

void main() {
  // testWidgets(
  //     'ViewRequestComponent should show 2 patients from patient requests collection',
  //     (WidgetTester tester) async {
  //   await tester.runAsync(() async {
  //     final MockFirestoreInstance instance = MockFirestoreInstance();
  //     final String uid = '123';
  //     final DatabaseService database =
  //         DatabaseService(uid: uid, firestore: instance);

  //     await instance.collection('doctors').document(uid).setData({
  //       'firstName': 'Elim',
  //       'middleInitial': 'C',
  //       'lastName': 'Abagat',
  //       'birthDate': DateTime(2000, 1, 22),
  //       'gender': 'Female',
  //     });

  //     // dummy account: 111A
  //     final String dummy1Uid = '111A';
  //     await instance.collection('patients').document(dummy1Uid).setData({
  //       'firstName': 'Jedro Vienne Deo',
  //       'middleInitial': 'E',
  //       'lastName': 'Pagayonan',
  //       'birthDate': DateTime(2000, 1, 27),
  //       'gender': 'Male',
  //       'bodyTemperature': 36.5,
  //       'bloodType': 'O',
  //       'weight': 75.00,
  //       'height': 172.72
  //     });

  //     // dummy acount: 222B
  //     final String dummy2Uid = '222B';
  //     await instance.collection('patients').document(dummy2Uid).setData({
  //       'firstName': 'Veto',
  //       'middleInitial': 'C',
  //       'lastName': 'Bastiero',
  //       'birthDate': DateTime(2000, 5, 27),
  //       'gender': 'Male',
  //       'bodyTemperature': 37,
  //       'bloodType': 'AB',
  //       'weight': 75.80,
  //       'height': 177.72
  //     });

  //     // both uid's on patient requests
  //     await instance.collection('patientRequests').document(uid).setData({
  //       'requests': [
  //         {'uid': dummy1Uid},
  //         {'uid': dummy2Uid}
  //       ]
  //     });

  //     await tester.pumpWidget(
  //       MaterialApp(
  //           home: ViewRequest(
  //               database: DatabaseService(uid: uid, firestore: instance))),
  //     );

  //     // expect(find.text('Jedro Vienne Deo E. Pagayonan'), findsOneWidget);
  //     // expect(find.text('Veto C. Bastiero'), findsOneWidget);
  //     // expect(find.textContaining('Jedro'),  findsOneWidget);

  //     // final requestPanels = find.byKey(Key('requestpanel'));
  //     // expect(requestPanels, findsNWidgets(2));

  //     //  idk why this works tho
  //     // final master = find.byKey(Key('master'));
  //     // expect(master, findsOneWidget);
  //   });
  // });
}

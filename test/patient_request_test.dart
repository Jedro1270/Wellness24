import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/pages/doctor_screen/view_request_component.dart';
import 'package:wellness24/models/user.dart';
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

  //     await instance
  //         .collection('bloodPressures')
  //         .document(dummy1Uid)
  //         .setData({'lastChecked': DateTime.now(), 'reading': '120/80 mm'});

  //     await instance
  //         .collection('bloodSugarLevels')
  //         .document(dummy1Uid)
  //         .setData({'lastChecked': DateTime.now(), 'reading': '100 mg'});

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

  //     await instance
  //         .collection('bloodPressures')
  //         .document(dummy2Uid)
  //         .setData({'lastChecked': DateTime.now(), 'reading': '110/90 mm'});

  //     await instance
  //         .collection('bloodSugarLevels')
  //         .document(dummy2Uid)
  //         .setData({'lastChecked': DateTime.now(), 'reading': '129 mg'});

  //     // both uid's on patient requests
  //     await instance.collection('patientRequests').document(uid).setData({
  //       'requests': [
  //         {'uid': dummy1Uid},
  //         {'uid': dummy2Uid}
  //       ]
  //     });

  //     await tester.pumpWidget(
  //       StreamProvider<User>.value(
  //           value: Stream.value(User(uid: uid, email: 'test@gmail.com')),
  //           initialData: null,
  //           child: MaterialApp(home: ViewRequest(database: database))),
  //     );

  //     expect(find.text('Jedro Vienne Deo E. Pagayonan'), findsOneWidget);
  //     expect(find.text('Veto C. Bastiero'), findsOneWidget);

  //     final requestPanels = find.byKey(Key('requestPanel'));
  //     expect(requestPanels, findsNWidgets(2));
  //   });
  // });
}

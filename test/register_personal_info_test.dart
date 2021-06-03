import 'package:flutter/material.dart';
import 'package:flutter_test/src/finders.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/components/pages/common_pages/register_personal_info.dart';
import 'package:wellness24/models/new_account.dart';

void main() {
  final firstNameField = find.byKey(Key('firstNameField'));
  final lastNameField = find.byKey(Key('lastNameField'));
  final middleInitialField = find.byKey(Key('middleInitialField'));
  final addressField = find.byKey(Key('addressField'), skipOffstage: false);
  // final birthField = find.byType(MaterialButton);
  final proceedBtn = find.byType(IconButton, skipOffstage: false);
  group("Register personal info page test", () {
    testWidgets(
    'Locates widgets',
    (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          home: RegisterPersonalInfo(NewAccount('Patient')),
        ));

      expect(firstNameField, findsOneWidget);
      expect(lastNameField, findsOneWidget);
      expect(middleInitialField, findsOneWidget);
      expect(addressField, findsOneWidget);
      //expect(birthField, findsOneWidget);
      expect(proceedBtn, findsOneWidget);
      });
    });

    // testWidgets(
    // 'Validates text fields are not empty',
    // (WidgetTester tester) async {
    //   await tester.runAsync(() async {
    //     await tester.pumpWidget(MaterialApp(
    //       home: RegisterPersonalInfo(NewAccount('Doctor'))
    //     ));
    //     await tester.longPressAt(Offset(751.0, 690.0));
    //     await tester.pump();

    //     expect(find.text('This field is required'), findsNWidgets(4));
    //   });
    // });
  });
}
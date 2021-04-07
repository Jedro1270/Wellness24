import 'package:flutter/material.dart';
import 'package:flutter_test/src/finders.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/components/pages/common_pages/register_personal_info.dart';
import 'package:wellness24/models/new_account.dart';


void main() {
  testWidgets(
  'Should alert when last name, first name, middle initial and address fields are empty',
  (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        home: RegisterPersonalInfo(NewAccount('Doctor'))
      ));

      final proceedBtnFinder = find.byType(IconButton, skipOffstage: false);

      await tester.tap(proceedBtnFinder);
      await tester.pump();

      final alertFinder = find.text('This field is required', skipOffstage: true);
      expect(alertFinder, findsNWidgets(4));
    });
  });
}
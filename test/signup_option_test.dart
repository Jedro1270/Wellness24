import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/components/pages/common_pages/sign_up_option.dart';

void main() {
  testWidgets(
      'Sign up option should route to registration page when role is selected',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        home: SignupOption(),
      ));

      final roleSelector1 = find.byKey(Key('Doctor'));
      final roleSelector2 = find.byKey(Key('Patient'));

      await tester.tap(roleSelector1);
      await tester.pump();

      await tester.tap(roleSelector2);
      await tester.pump();

      final roleFinder1 = find.text('Doctor');
      final roleFinder2 = find.text('Patient');

      expect(roleFinder1, findsOneWidget);
      expect(roleFinder2, findsOneWidget);
    });
  });
}

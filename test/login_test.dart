import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/components/pages/common_pages/login_page.dart';
import 'package:wellness24/components/pages/common_pages/sign_up_option.dart';

void main() {
  group('Login page', () {
    testWidgets(
        'should alert empty fields when email or password fields are empty',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          home: Login(),
        ));

        final loginBtnFinder = find.byKey(Key('loginButton'));

        await tester.tap(loginBtnFinder);
        await tester.pump();

        final alertFinder = find.text('This field is required');

        expect(alertFinder, findsNWidgets(2));
      });
    });

    testWidgets('should route to sign up options when tapping Sign up.",',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          home: Login(),
        ));

        final signupLinkFinder = find.byKey(Key('signup'));

        await tester.tap(signupLinkFinder);
        await tester.pumpAndSettle();

        final signupPageFinder = find.byType(SignupOption);

        expect(signupPageFinder, findsOneWidget);
      });
    });
  });
}

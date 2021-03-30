import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/components/pages/common_pages/register_credentials.dart';
import 'package:wellness24/components/pages/common_pages/login_page.dart';
import 'package:wellness24/models/new_account.dart';

void main() {
  Future <NewAccount> mockGetNewAccount(String uid, database) async {

  }
  group('Register credentials page', () {
    testWidgets(
      'Should alert when email, contact number and password fields are empty',
      (WidgetTester tester) async {
        await tester.runAsync(() async {
          await tester.pumpWidget(MaterialApp(
            home: RegisterCredentials(NewAccount('Patient')),
          ));

          final createAccBtnFinder = find.byType(MaterialButton);

          await tester.tap(createAccBtnFinder);
          await tester.pump();

          final alertFinder = find.text('This field is required');

          expect(alertFinder, findsNWidgets(3));
        });
      });
  });

  group('Route to login page', () {
    testWidgets(
      'Should route back to login page',
      (WidgetTester tester) async {
        await tester.runAsync(() async {
          await tester.pumpWidget(MaterialApp(
            home: RegisterCredentials(NewAccount('Patient')),
          ));

          final logInLinkFinder = find.byKey(Key('logInBtn'));

          await tester.tap(logInLinkFinder);
          await tester.pumpAndSettle();

          final logInPageFinder = find.byType(Login);

          expect(logInPageFinder, findsOneWidget);
        });
      });
  });
}
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/common/text_input.dart';
import 'package:wellness24/components/pages/doctor_registration.dart';

void main() {
  test('Firebase mock is working.', () async {
    final instance = MockFirestoreInstance();

    await instance
        .collection('doctors')
        .add({'name': 'Dr. Heinz Doofenshmirtz'});

    final snapshot = await instance.collection('doctors').get();

    expect(snapshot.docs.first.data()['name'], 'Dr. Heinz Doofenshmirtz');
  });

  testWidgets('Doctors must be registered after signing up.',
      (WidgetTester tester) async {
    final String testEmail = 'jedro1270@gmail.com';
    final String testContactNumber = '09954845486';
    final String testPassword = 'Jedro0987';

    final Widget emailInput = TextInput(
      hint: 'Email',
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
    );
    final Widget contactNumberInput = TextInput(
        hint: 'Contact Number',
        keyboardType: TextInputType.number,
        obscureText: false);
    final Widget passwordInput = TextInput(
        hint: 'Password',
        keyboardType: TextInputType.visiblePassword,
        obscureText: true);

    await tester.pumpWidget(DoctorRegistration());

    var email = find.byWidget(emailInput);
    var contactNumber = find.byWidget(contactNumberInput);
    var password = find.byWidget(passwordInput);

    await tester.enterText(email, testEmail);
    await tester.enterText(contactNumber, testContactNumber);
    await tester.enterText(password, testPassword);

    await tester.tap(find.byType(InkWell)); // Submit data to firestore, must take firestore as optional parameter for testing

    await tester.pump(); // Update the page
  });
}

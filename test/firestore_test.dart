// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wellness24/components/pages/registration.dart';

void main() {
  test('Firebase mock is working.', () async {
    final instance = MockFirestoreInstance();

    await instance
        .collection('doctors')
        .add({'name': 'Dr. Heinz Doofenshmirtz'});

    final snapshot = await instance.collection('doctors').get();

    expect(snapshot.docs.first.data()['name'], 'Dr. Heinz Doofenshmirtz');
  });

  // testWidgets('Doctors must be registered after signing up.',
  //     (WidgetTester tester) async {
  //   // Insert into doctors
  //   when(instance.collection('doctors')).thenReturn(mockCollectionReference);
  //   when(mockCollectionReference.document(any))
  //       .thenReturn(mockDocumentReference);
  //   when(mockDocumentReference.setData(any))
  //       .thenAnswer((_) async => mockDocumentSnapshot);

  //   // Check for inserted doctor
  //   when(instance.collection('doctors')).thenReturn(mockCollectionReference);
  //   when(mockCollectionReference.document(any))
  //       .thenReturn(mockDocumentReference);
  //   when(mockDocumentReference.get())
  //       .thenAnswer((_) async => mockDocumentSnapshot);

  //   final String testName = 'Dr. Heinz Doofenshmirtz'; // Replace
  //   // Add other values

  //   final Widget nameInput = Container(); // Replace
  //   // Add other widgets for fields
  //   final Widget submitButton = Container(); // Replace

  //   await tester.pumpWidget(Registration());

  //   var name = find.byWidget(nameInput);
  //   await tester.enterText(name, testName);

  //   // Insert all other fields like email, etc.

  //   await tester.tap(find.byWidget(submitButton));

  //   await tester.pump();

  //   final result = await
  // });
}

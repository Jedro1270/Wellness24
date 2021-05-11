import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:wellness24/components/pages/doctor_screen/doctor_queue_monitor.dart';
import 'package:wellness24/models/doctor.dart';

void main() {
  Doctor testDoctor = Doctor(uid: 'test123');
  group('Doctor queue monitor page', () {
    testWidgets('Should locate buttons and text', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester
            .pumpWidget(MaterialApp(home: DoctorQueueMonitor(testDoctor)));

        DateTime currentDate = DateTime.now();
        DateFormat format = DateFormat.yMMMMd('en_US');
        final switchBtn = find.byType(Switch);
        final initialMessage = find.text('Accepting Appointments');
        final date = find.text(format.format(currentDate));
        final arrowBtn = find.byType(IconButton);

        expect(switchBtn, findsOneWidget);
        expect(initialMessage, findsOneWidget);
        expect(date, findsOneWidget);
        expect(arrowBtn, findsNWidgets(3));
      });
    });

    testWidgets('Message would change if switch button is tapped',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester
            .pumpWidget(MaterialApp(home: DoctorQueueMonitor(testDoctor)));

        final switchBtn = find.byType(Switch);
        await tester.tap(switchBtn);
        await tester.pump();

        final alertPopUp = find.byType(AlertDialog);
        expect(alertPopUp, findsOneWidget);

        final elevatedBtnYes = find.byKey(Key('elevatedYes'));
        await tester.tap(elevatedBtnYes);
        await tester.pump();
        final message = find.text('Unavailable for Appointments');
        expect(message, findsOneWidget);
      });
    });
  });
}

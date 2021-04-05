import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/doctor_screen/doctor_home_page.dart';
import 'package:wellness24/components/pages/doctor_screen/notification_page.dart';

void main() {
  testWidgets('Should show Notification Page in Doctor home page', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(home: DoctorHomePage()));

      final notifIcon = find.byKey(Key('notifBtn'));
      await tester.tap(notifIcon);
      await tester.pump();

      final notifPageFinder = find.byType(NotificationPage);

      expect(notifPageFinder, findsOneWidget);
    });
  });
}

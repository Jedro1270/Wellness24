// import 'package:flutter_driver/driver_extension.dart';
// import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:test/test.dart';
import 'package:flutter_driver/flutter_driver.dart';
// import 'package:gherkin/gherkin.dart';
// import 'package:glob/glob.dart';

// import 'steps/test_steps.dart';

// Future<void> main() { // Flutter Gherkin
//   final config = FlutterTestConfiguration()
//     ..features = [Glob(r"test_driver/features/**.feature")]
//     ..reporters = [
//       ProgressReporter(),
//       TestRunSummaryReporter(),
//       JsonReporter(path: './report.json')
//     ] // you can include the "StdoutReporter()" without the message level parameter for verbose log information
//     ..stepDefinitions = [
//       CheckGivenWidgets(),
//       ClickSignupButton(),
//       CheckWidgetIsDisplayed()
//     ]
//     ..restartAppBetweenScenarios = true
//     ..targetAppPath = "test_driver/app.dart"
//     ..flutterBuildTimeout = Duration(minutes: 4)
//     // ..tagExpression = "@smoke" // uncomment to see an example of running scenarios based on tag expressions
//     ..exitAfterTestRun = true; // set to false if debugging to exit cleanly
//   return GherkinRunner().execute(config);
// }

void main() {
  group('Main Pages:', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver.close();
    });

    group('As a Patient', () {
      final patientHomePageFinder = find.byType('PatientHomePage');
      test('I can Log In.', () async {
        final signInButtonFinder = find.byValueKey('loginButton');

        final emailFieldFinder = find.byValueKey('emailField');
        final passwordFieldFinder = find.byValueKey('passwordField');

        await driver.tap(emailFieldFinder);
        await driver
            .enterText('patientjed@gmail.com'); // TODO: Change to test account

        await driver.tap(passwordFieldFinder);
        await driver.enterText('Jedro1270'); // TODO: Change to test account

        await driver.tap(signInButtonFinder);

        await driver.waitFor(patientHomePageFinder,
            timeout: Duration(minutes: 5));
      });

      group('I can navigate to', () {
        test('Search Page.', () async {
          final searchButtonFinder = find.byValueKey('doctorSearchPageButton');
          await driver.tap(searchButtonFinder);

          final doctorSearchPageFinder = find.byType('DoctorSearchPage');
          await driver.waitFor(doctorSearchPageFinder);

          await driver.tap(find.pageBack());

          await driver.waitFor(patientHomePageFinder);
        });

        test('Doctor Details.', () async {
          final doctorInfoFinder = find.byType('DoctorInfo');
          await driver.waitFor(doctorInfoFinder);
          await driver.tap(doctorInfoFinder);

          final doctorDetailsFinder = find.byType('DoctorDetails');
          await driver.waitFor(doctorDetailsFinder);

          await driver.tap(find.pageBack());

          await driver.waitFor(patientHomePageFinder);
        });

        test('Current Conditions.', () async {
          final currentConditionsButtonFinder =
              find.byValueKey('myCurrentConditionBtn');
          await driver.tap(currentConditionsButtonFinder);

          final patientProfileFinder = find.byType('PatientProfile');
          await driver.waitFor(patientProfileFinder);
        });

        test('Medical Records.', () async {
          final medicalRecordsButtonFinder =
              find.byValueKey('medicalRecordsBtn');
          final listViewFinder = find.byType('ListView');

          await driver.scrollUntilVisible(
              listViewFinder, medicalRecordsButtonFinder,
              dyScroll: -250);
          await driver.tap(medicalRecordsButtonFinder);

          final medicalRecordsPageFinder = find.byType('MedicalRecords');
          await driver.waitFor(medicalRecordsPageFinder);

          await driver.tap(find.pageBack()); // Back to Current Conditions
          await driver.tap(find.pageBack()); // Back to Home Page

          await driver.waitFor(patientHomePageFinder);
        });

        test('Chat.', () async {
          final chatButtonFinder = find.byValueKey('chatButton');
          await driver.tap(chatButtonFinder);

          final messagesPageFinder = find.byType('Messages');
          await driver.waitFor(messagesPageFinder);

          final userChatFinder = find.byType('UserTile');
          await driver.tap(userChatFinder);

          final chatRoomFinder = find.byType('ChatRoom');
          await driver.waitFor(chatRoomFinder);

          await driver.tap(find.pageBack());

          await driver.waitFor(messagesPageFinder);

          await driver.tap(find.pageBack());

          await driver.waitFor(patientHomePageFinder);
        });
      });

      // TODO: Add deeper chat page
      group('I can search for a doctor', () {
        test('I can search by entering a keyword', () async {
          final searchButton = find.byValueKey('doctorSearchPageButton');
          await driver.tap(searchButton);

          final doctorSearchPageFinder = find.byType('DoctorSearchPage');
          await driver.waitFor(doctorSearchPageFinder);
          final searchBar = find.byValueKey('doctorSearchBar');
          await driver.tap(searchBar);
          await driver.enterText('jedro');
          final doctorResult = find.byType('DoctorInfo');
          await driver.waitFor(doctorResult);
        });
      });

      test('I can Log Out', () async {
        final drawerFinder = find.byTooltip('Open navigation menu');
        await driver.tap(drawerFinder);

        final logOutButtonFinder = find.byValueKey('logOutButton');
        await driver.tap(logOutButtonFinder);

        final loginPageFinder = find.byType('Login');
        await driver.waitFor(loginPageFinder);
      });
    });

    group('As a Doctor', () {
      final doctorHomePageFinder = find.byType('DoctorHomePage');
      test('I can Log In.', () async {
        final signInButtonFinder = find.byValueKey('loginButton');

        final emailFieldFinder = find.byValueKey('emailField');
        final passwordFieldFinder = find.byValueKey('passwordField');

        await driver.tap(emailFieldFinder);
        await driver
            .enterText('jedro1270@gmail.com'); // TODO: Change to test account

        await driver.tap(passwordFieldFinder);
        await driver.enterText('Jedro1270'); // TODO: Change to test account

        await driver.tap(signInButtonFinder);

        await driver.waitFor(doctorHomePageFinder,
            timeout: Duration(minutes: 5));
      });

      group('I can navigate to', () {
        test('Patient Profile.', () async {
          final patientInfoFinder = find.byType('PatientInfo');
          await driver.waitFor(patientInfoFinder);
          await driver.tap(patientInfoFinder);

          final patientProfileFinder = find.byType('PatientProfile');
          await driver.waitFor(patientProfileFinder);
        });

        test('Medical Records.', () async {
          final medicalRecordsButtonFinder =
              find.byValueKey('medicalRecordsBtn');
          final listViewFinder = find.byType('ListView');

          await driver.scrollUntilVisible(
              listViewFinder, medicalRecordsButtonFinder,
              dyScroll: -250);
          await driver.tap(medicalRecordsButtonFinder);

          final medicalRecordsPageFinder = find.byType('MedicalRecords');
          await driver.waitFor(medicalRecordsPageFinder);

          final addMedicalRecordButton =
              find.byValueKey('addMedicalRecordButton');
          await driver.waitFor(addMedicalRecordButton);
          await driver.tap(addMedicalRecordButton);
        });

        test('Medical Record Page.', () async {
          final medicalRecordPageFinder = find.byType('MedicalRecordPage');
          await driver.waitFor(medicalRecordPageFinder);

          await driver.tap(find.pageBack()); // Back to Medical Records
          await driver.tap(find.pageBack()); // Back to Patient Profile
          await driver.tap(find.pageBack()); // Back to Home Page
        });

        test('Chat.', () async {
          final chatButtonFinder = find.byValueKey('chatButton');
          await driver.tap(chatButtonFinder);

          final messagesPageFinder = find.byType('Messages');
          await driver.waitFor(messagesPageFinder);

          final userChatFinder = find.byType('UserTile');
          await driver.tap(userChatFinder);

          final chatRoomFinder = find.byType('ChatRoom');
          await driver.waitFor(chatRoomFinder);

          await driver.tap(find.pageBack());

          await driver.waitFor(messagesPageFinder);

          await driver.tap(find.pageBack());

          await driver.waitFor(doctorHomePageFinder);
        });

        test('I can check notification', () async {
          final notificationIconFinder = find.byValueKey('notifications');
          await driver.tap(notificationIconFinder);

          final notificationPageFinder = find.byType('NotificationPage');
          await driver.waitFor(notificationPageFinder);

          final pageBackButton = find.byValueKey('pageBack');
          await driver.tap(pageBackButton);

          await driver.waitFor(doctorHomePageFinder);
        });

        test('Priority Numbers Page.', () async {
          final priorityNumbersPageButtonFinder =
              find.byValueKey('priorityNumbersPageButton');
          await driver.tap(priorityNumbersPageButtonFinder);

          final priorityNumbersPageFinder = find.byType('DoctorQueueMonitor');
          await driver.waitFor(priorityNumbersPageFinder);

          await driver.tap(find.pageBack());

          await driver.waitFor(doctorHomePageFinder);
        });
      });

      test('I can Log Out', () async {
        final drawerFinder = find.byTooltip('Open navigation menu');
        await driver.tap(drawerFinder);

        final logOutButtonFinder = find.byValueKey('logOutButton');
        await driver.tap(logOutButtonFinder);

        final loginPageFinder = find.byType('Login');
        await driver.waitFor(loginPageFinder);
      });
    });
  });
}

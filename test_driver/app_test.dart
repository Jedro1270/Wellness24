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

    // group('I can register as patient', () {
    //   test('Sign up page', () async {
    //     final signUpBtn = find.byValueKey('signup');
    //     final signupFinder = find.byType('SignupOption');

    //     await driver.tap(signUpBtn);
    //     await driver.waitFor(signupFinder);
    //   });

    //   test('Register as patient', () async {
    //     final registerCredFinder = find.byType('RegisterCredentials');
    //     final patientBtn = find.byValueKey('Patient');

    //     await driver.tap(patientBtn);
    //     await driver.waitFor(registerCredFinder);
    //   });

    //   test('Register credentials', () async {
    //     final emailFinder = find.byValueKey('email');
    //     final contactNumberFinder = find.byValueKey('contactNumber');
    //     final passwordFinder = find.byValueKey('password');
    //     final registerFinder = find.byValueKey('register');
    //     final registerPersonalInfo = find.byType('RegisterPersonalInfo');

    //     await driver.tap(emailFinder);
    //     await driver
    //         .enterText('temporarytest@gmail.com');

    //     await driver.tap(contactNumberFinder);
    //     await driver
    //         .enterText('09291294923');

    //     await driver.tap(passwordFinder);
    //     await driver
    //         .enterText('password');

    //     await driver.tap(registerFinder);
    //     await driver.waitFor(registerPersonalInfo);
    //   });

    //   test('Register Personal Information', () async {
    //     final lastNameFinder = find.byValueKey('lastNameField');
    //     final firstNameFinder = find.byValueKey('firstNameField');
    //     final middleInitialFinder = find.byValueKey('middleInitialField');
    //     final genderFinder = find.byValueKey('male');
    //     final addressFinder = find.byValueKey('addressField');
    //     final arrowBtnFinder = find.byValueKey('arrowBtn');
    //     final emergencyContactInfo = find.byType('EmergencyContactInfo');
    //     final listViewFinder = find.byType('ListView');

    //     await driver.tap(lastNameFinder);
    //     await driver
    //         .enterText('Cruz');

    //     await driver.tap(firstNameFinder);
    //     await driver
    //         .enterText('Joshua');

    //     await driver.tap(middleInitialFinder);
    //     await driver
    //         .enterText('C');

    //     await driver.tap(genderFinder);

    //     await driver.scrollUntilVisible(
    //           listViewFinder, arrowBtnFinder,
    //           dyScroll: -250);

    //     await driver.tap(addressFinder);
    //     await driver
    //         .enterText('Iloilo City');

    //     await driver.tap(arrowBtnFinder);
    //     await driver.waitFor(emergencyContactInfo);
    //   });

    //   test('Register Personal Information', () async {
    //     final lastNameFinder = find.byValueKey('lastNameField');
    //     final firstNameFinder = find.byValueKey('firstNameField');
    //     final middleInitialFinder = find.byValueKey('middleInitialField');
    //     final addressFinder = find.byValueKey('addressField');
    //     final contactNumFinder = find.byValueKey('contactNumField');
    //     final relationshipFinder = find.byValueKey('relationshipField');
    //     final arrowBtnFinder = find.byValueKey('arrowBtn');
    //     final medicalHistory = find.byType('MedicalHistory');
    //     final listViewFinder = find.byType('ListView');

    //     await driver.tap(lastNameFinder);
    //     await driver
    //         .enterText('Cruz');

    //     await driver.tap(firstNameFinder);
    //     await driver
    //         .enterText('Kyle');

    //     await driver.tap(middleInitialFinder);
    //     await driver
    //         .enterText('C');

    //     await driver.tap(addressFinder);
    //     await driver
    //         .enterText('Iloilo City');

    //     await driver.scrollUntilVisible(
    //           listViewFinder, arrowBtnFinder,
    //           dyScroll: -250);

    //     await driver.tap(contactNumFinder);
    //     await driver
    //         .enterText('09231934969');

    //     await driver.tap(relationshipFinder);
    //     await driver
    //         .enterText('Brother');

    //     await driver.tap(arrowBtnFinder);
    //     await driver.waitFor(medicalHistory);
    //   });

    //   test('Medical history', () async {
    //     final inputFinder = find.byValueKey('otherField');
    //     final addFinder = find.byValueKey('addBtn');

    //     await driver.tap(inputFinder);
    //     await driver
    //         .enterText('Brother');

    //     await driver.tap(addFinder);

    //     await driver.tap(find.pageBack()); // Back to Emergency Contact Information
    //     await driver.tap(find.pageBack()); // Back to Personal Information
    //     await driver.tap(find.pageBack()); // Back to Sign Up

    //     final loginFinder = find.byValueKey('logInBtn');
    //     await driver.tap(loginFinder);    //Back to register credentials

    //     final loginPage = find.byType('Login');
    //     await driver.waitFor(loginPage);
    //   });
    // });

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

          final findDoctor = find.text('Gastroenterologist');
          await driver.tap(findDoctor);

          final doctorsProfile = find.byType('DoctorDetails');
          await driver.waitFor(doctorsProfile);

          final singleChildScrollFinder = find.byValueKey('doctorDetailsSingleChildScrollView');
          final sendRequestFinder = find.text('Send Request');

          await driver.scrollUntilVisible(
              singleChildScrollFinder, sendRequestFinder,
              dyScroll: -250);
          await driver.tap(sendRequestFinder);

          final consentDialogFinder = find.byType('AlertDialog');
          await driver.waitFor(consentDialogFinder);

          final consentBtnFinder = find.byValueKey('ConsentBtn');
          await driver.tap(consentBtnFinder);

          await driver.waitFor(doctorsProfile);

          final cancelRequestFinder = find.text('Cancel Request');
          await driver.tap(cancelRequestFinder);

          await driver.waitFor(sendRequestFinder);

          await driver.tap(find.pageBack());

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
        final searchBar = find.byValueKey('doctorSearchBar');
        final searchBtn = find.byValueKey('searchBtn');
        test('I can search by entering a keyword', () async {
          final searchPageButton = find.byValueKey('doctorSearchPageButton');
          await driver.tap(searchPageButton);
          final doctorSearchPageFinder = find.byType('DoctorSearchPage');
          await driver.waitFor(doctorSearchPageFinder);

          await driver.tap(searchBar);
          await driver.enterText('jedro');
          await driver.tap(searchBtn);

          final doctorResult = find.byType('DoctorInfo');
          await driver.waitFor(doctorResult);
        });
        test('Shows "no results" if search value has no match', () async {
          await driver.tap(searchBar);
          await driver.enterText('oisefhjasdknvadg');
          await driver.tap(searchBtn);

          final emptyResults = find.byValueKey('emptySearchResults');
          await driver.waitFor(emptyResults);

          await driver.tap(find.pageBack());
          await driver.waitFor(patientHomePageFinder);
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

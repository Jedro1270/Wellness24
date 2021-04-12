import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckGivenWidgets extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(input1) async {
    final signupBtn = find.byValueKey(input1);
    final signupBtnExists =
        await FlutterDriverUtils.isPresent(world.driver, signupBtn);

    expectMatch(true, signupBtnExists);
  }

  @override
  RegExp get pattern => RegExp(r"I have {string}");
}

class CheckWidgetIsDisplayed extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(input1) async {
    final signUpOptionsPage = find.byType(input1);
    final signUpOptionsPageExists =
        await FlutterDriverUtils.isPresent(world.driver, signUpOptionsPage);

    expectMatch(true, signUpOptionsPageExists);
  }

  @override
  RegExp get pattern => RegExp(r"I should see {string} on screen");
}

class ClickSignupButton extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final signupBtn = find.byValueKey(input1);
    await FlutterDriverUtils.tap(world.driver, signupBtn);
  }

  @override
  RegExp get pattern => RegExp(r"I tap {string}");
}

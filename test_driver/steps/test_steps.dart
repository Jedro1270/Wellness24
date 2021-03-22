import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckGivenWidgets extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(input1) async {
    final signupBtn = find.byValueKey(input1);
    await FlutterDriverUtils.isPresent(world.driver, signupBtn);
  }

  @override
  RegExp get pattern => RegExp(r"i have {string}");
}

class ClickSignupButton extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final signupBtn = find.byValueKey(input1);
    await FlutterDriverUtils.tap(world.driver, signupBtn);
  }

  @override
  RegExp get pattern => RegExp(r"i tap {string}");
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/models/blood_pressure.dart';

void main() {
  group('BloodPressure', () {
    group('.sinceLastChecked', () {
      test(
          'should return the difference in days from lastChecked to current date if the difference is less than 32 days.',
          () {});
      test(
          'should return the difference in weeks from lastChecked to current date if the difference is greater or equal to 32 days.',
          () {});
    });
  });

  group('BloodSugarLevel', () {
    group('.sinceLastChecked', () {
      test(
          'should return the difference in days from lastChecked to current date if the difference is less than 32 days.',
          () {});
      test(
          'should return the difference in weeks from lastChecked to current date if the difference is greater or equal to 32 days.',
          () {});
    });
  });
  group('Doctor', () {
    test(
        '.fullName should return the firstName, middleInitial and lastName joined together.',
        () {});
  });

  group('NewAccount', () {
    test(
        '.supplyCredentials should add email, password and contactNo to NewAccount instance.',
        () {});
    test(
        '.supplyPersonalInfo should add lastName, firstName, middleInitial, gender, birthDate and address to NewAccount instance.',
        () {});
    test('.generateAllKeyWords should generate and supply keywords.', () {});
    test(
        '.addEmergencyContact should add emergencyContact to NewAccount instance.',
        () {});
  });

  group('Patient', () {
    test(
        '.fullName should return the firstName, middleInitial and lastName joined together.',
        () {});
  });
}

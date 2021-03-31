import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/emergency_contact.dart';
import 'package:wellness24/models/new_account.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
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
        () {
      NewAccount testAcc = NewAccount('Patient');
      testAcc.supplyCredentials(
          contactNo: '09221235212',
          email: 'test@gmail.com',
          password: 'test_password01');

      expect(testAcc.contactNo, '09221235212');
      expect(testAcc.email, 'test@gmail.com');
      expect(testAcc.password, 'test_password01');
    });
    test(
        '.supplyPersonalInfo should add lastName, firstName, middleInitial, gender, birthDate and address to NewAccount instance.',
        () {
      NewAccount testAcc = NewAccount('Doctor');
      testAcc.supplyPersonalInfo(
          firstName: 'Veto',
          lastName: 'Bastiero',
          middleInitial: 'C',
          address: 'Cabatuan, Iloilo',
          gender: 'Male',
          birthDate: DateTime(2000, 1, 1));

      expect(
        testAcc.firstName,
        'Veto',
      );
      expect(testAcc.lastName, 'Bastiero');
      expect(testAcc.middleInitial, 'C');
      expect(testAcc.address, 'Cabatuan, Iloilo');
      expect(testAcc.gender, 'Male');
      expect(testAcc.birthDate, DateTime(2000, 1, 1));
    });
    test('.generateAllKeyWords should generate and supply keywords.', () {
      NewAccount testAcc = NewAccount('Patient');
      testAcc.supplyPersonalInfo(
          firstName: 'Veto',
          lastName: 'Bastiero',
          middleInitial: 'C',
          address: 'Cabatuan, Iloilo',
          gender: 'Male',
          birthDate: DateTime(2000, 1, 1));

      testAcc.generateAllKeywords();

      List<String> expectedKeywords = [
        'v',
        've',
        'vet',
        'veto',
        'veto ',
        'veto b',
        'veto ba',
        'veto bas',
        'veto bast',
        'veto basti',
        'veto bastie',
        'veto bastier',
        'veto bastiero',
        'v',
        've',
        'vet',
        'veto',
        'veto ',
        'veto c',
        'veto c.',
        'veto c. ',
        'veto c. b',
        'veto c. ba',
        'veto c. bas',
        'veto c. bast',
        'veto c. basti',
        'veto c. bastie',
        'veto c. bastier',
        'veto c. bastiero',
        'b',
        'ba',
        'bas',
        'bast',
        'basti',
        'bastie',
        'bastier',
        'bastiero',
        'bastiero,',
        'bastiero, ',
        'bastiero, v',
        'bastiero, ve',
        'bastiero, vet',
        'bastiero, veto',
        'bastiero, veto ',
        'bastiero, veto c',
        'bastiero, veto c.'
      ];

      expect(testAcc.keywords, expectedKeywords);
    });
    test(
        '.addEmergencyContact should add emergencyContact to NewAccount instance.',
        () {
      NewAccount testAcc = NewAccount('Doctor');
      EmergencyContact contact = EmergencyContact(
          lastName: 'Bastiero',
          firstName: 'Mom',
          middleInitial: 'J',
          address: 'Cabatuan, Iloilo',
          contactNo: '09221321235',
          relationship: 'Mother');

      testAcc.addEmergencyContact(contact);
      expect(testAcc.emergencyContact, contact);
    });
  });

  group('Patient', () {
    test(
        '.fullName should return the firstName, middleInitial and lastName joined together.',
        () {});
  });
}

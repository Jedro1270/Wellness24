import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/services/auth_service.dart';

void main() {
  group('AuthService', () {
    group('.signInWithEmailAndPassword ', () {
      test('should return a User as a Future if credentials are valid',
          () async {});
      test('should return a null as a Future if credentials are invalid',
          () async {});
    });
    group('registerWithEmailAndPassword', () {
      test('should return a User as a Future if credentials are valid',
          () async {});
      test('should return a null as a Future if credentials are invalid',
          () async {});
    });
  });
  group('DatabaseService', () {});
}

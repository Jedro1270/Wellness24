import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/auth_service.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

void main() {
  group('AuthService', () {
    final FirebaseAuthMock firebaseAuthMock = FirebaseAuthMock();
    final AuthService testAuth = AuthService(auth: firebaseAuthMock);
    group('.signInWithEmailAndPassword ', () {
      when(firebaseAuthMock.signInWithEmailAndPassword(
              email: 'test@gmail.com', password: '123'))
          .thenAnswer((_) => Future<MockAuthResult>.value(MockAuthResult()));
      test('should return a User as a Future if credentials are valid',
          () async {
        final result =
            await testAuth.signInWithEmailAndPassword('test@gmail.com', '123');

        expect(result, isInstanceOf<User>());
      });
      test('should return a null as a Future if credentials are invalid',
          () async {
        final wrongPassword = await testAuth.signInWithEmailAndPassword(
            'test@gmail.com', 'invalidPassword');
        final wrongEmail = await testAuth.signInWithEmailAndPassword(
            'wrongEmail@gmail.com', '123');

        expect(wrongPassword, isInstanceOf<Null>());
        expect(wrongEmail, isInstanceOf<Null>());
      });
    });
    group('.registerWithEmailAndPassword ', () {
      when(firebaseAuthMock.createUserWithEmailAndPassword(
              email: 'newEmail@gmail.com', password: 'newPassword'))
          .thenAnswer((_) => Future<MockAuthResult>.value(MockAuthResult()));

      when(firebaseAuthMock.createUserWithEmailAndPassword(
              email: 'takenEmail@gmail.com', password: 'newPassword'))
          .thenAnswer((_) => Future<MockAuthResult>.value(null));

      test('should return a User as a Future if credentials are valid',
          () async {
        final result = await testAuth.registerWithEmailAndPassword(
            'newEmail@gmail.com', 'newPassword');

        expect(result, isInstanceOf<User>());
      });
      test('should return a null as a Future if email is already taken',
          () async {
        final result = await testAuth.registerWithEmailAndPassword(
            'takenEmail@gmail.com', 'newPassword');

        expect(result, isInstanceOf<Null>());
      });
    });
  });
  group('DatabaseService', () {});
}

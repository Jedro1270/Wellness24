import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/services/auth_service.dart';
import 'package:wellness24/services/database.dart';

void main() {
  // group('AuthService', () {
  //   group('.signInWithEmailAndPassword ', () {
  //     test('should return a User as a Future if credentials are valid',
  //         () async {});
  //     test('should return a null as a Future if credentials are invalid',
  //         () async {});
  //   });
  //   group('registerWithEmailAndPassword', () {
  //     test('should return a User as a Future if credentials are valid',
  //         () async {});
  //     test('should return a null as a Future if credentials are invalid',
  //         () async {});
  //   });
  // });
  group('DatabaseService', () {
    group('.getRole', () {
      MockFirestoreInstance instance = MockFirestoreInstance();
      String uid = '123';
      DatabaseService database = DatabaseService(uid: uid, firestore: instance);

      test('should return string role "Patient" on patient account"', () async {
        await instance
            .collection('roles')
            .document(uid)
            .setData({'role': 'Patient'});

        String role = await database.getRole();
        expect(role, 'Patient');
      });

      test('should return string role "Doctor" on doctor account', () async {
        await instance
            .collection('roles')
            .document(uid)
            .updateData({'role': 'Doctor'});

        String updatedRole = await database.getRole();
        expect(updatedRole, 'Doctor');
      });
    });
    
    group('.insertRole', () {
      test('should insert the role "Patient" to firestore', () async {
        MockFirestoreInstance instance = MockFirestoreInstance();
        String uid = '123';
        DatabaseService database =
            DatabaseService(uid: uid, firestore: instance);

        await database.insertRole('Patient');
        DocumentSnapshot snapshot =
            await instance.collection('roles').document(uid).get();
        String insertedRole = snapshot.data['role'];
        expect(insertedRole, 'Patient');
      });
    });
  });
}

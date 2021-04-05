import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/models/emergency_contact.dart';
import 'package:wellness24/models/new_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/auth_service.dart';
import 'package:wellness24/services/database.dart';

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
      test('should insert the role "Patient" to roles collection', () async {
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

      test('should insert the role "Doctor" to roles collection', () async {
        MockFirestoreInstance instance = MockFirestoreInstance();
        String uid = '123';
        DatabaseService database =
            DatabaseService(uid: uid, firestore: instance);

        await database.insertRole('Doctor');
        DocumentSnapshot snapshot =
            await instance.collection('roles').document(uid).get();
        String insertedRole = snapshot.data['role'];
        expect(insertedRole, 'Doctor');
      });
    });

    group('.insertDoctor', () {
      test('should insert newaccount object to firestore as doctor', () async {
        NewAccount testAcc = NewAccount('Doctor');
        testAcc.keywords = ['v', 've', 'vet', 'veto'];
        testAcc.email = 'veto@gmail.com';
        testAcc.contactNo = '09123312312';
        testAcc.lastName = 'Bastiero';
        testAcc.firstName = 'Veto';
        testAcc.middleInitial = 'Y';
        testAcc.birthDate = DateTime(2000, 1, 1);
        testAcc.address = 'Cabatuan, Iloilo';
        testAcc.gender = 'Male';
        testAcc.licenseNo = '2312';
        testAcc.clinicLocation = 'Iloilo City';
        testAcc.workingDays = 'Monday to Friday';
        testAcc.clinicStart = '8:30 AM';
        testAcc.clinicEnd = '5:30 PM';
        testAcc.specialization = 'Family Medicine';
        testAcc.education = 'Phd in Family Medicine';
        testAcc.about = 'Lorem ipsum dolor sit amet';

        MockFirestoreInstance instance = MockFirestoreInstance();
        String uid = '123';
        DatabaseService database =
            DatabaseService(uid: uid, firestore: instance);

        await database.insertDoctor(testAcc);

        DocumentSnapshot document =
            await instance.collection('doctors').document(uid).get();

        expect(document.data['keywords'], testAcc.keywords);
        expect(document.data['email'], testAcc.email);
        expect(document.data['contactNumber'], testAcc.contactNo);
        expect(document.data['lastName'], testAcc.lastName);
        expect(document.data['firstName'], testAcc.firstName);

        // TODO: Fix test case
        // expect(document.data['birthDate'], testAcc.birthDate);
        //
        expect(document.data['middleInitial'], testAcc.middleInitial);
        expect(document.data['address'], testAcc.address);
        expect(document.data['gender'], testAcc.gender);
        expect(document.data['licenseNo'], testAcc.licenseNo);
        expect(document.data['clinicLocation'], testAcc.clinicLocation);
        expect(document.data['workingDays'], testAcc.workingDays);
        expect(document.data['clinicStart'], testAcc.clinicStart);
        expect(document.data['clinicEnd'], testAcc.clinicEnd);
        expect(document.data['specialization'], testAcc.specialization);
        expect(document.data['education'], testAcc.education);
        expect(document.data['about'], testAcc.about);
      });
    });

    group('.insertPatient', () {
      test('should insert newacc object to firestore as patient', () async {
        EmergencyContact testContact = EmergencyContact(
            lastName: 'Bastiero',
            firstName: 'Mom',
            middleInitial: 'F',
            address: 'Cabatuan, Iloilo',
            contactNo: '09221231232',
            relationship: 'Mother');

        NewAccount testAcc = NewAccount('Patient');
        testAcc.keywords = ['v', 've', 'vet', 'veto'];
        testAcc.email = 'veto@gmail.com';
        testAcc.contactNo = '09123312312';
        testAcc.lastName = 'Bastiero';
        testAcc.firstName = 'Veto';
        testAcc.middleInitial = 'Y';
        testAcc.birthDate = DateTime(2000, 1, 1);
        testAcc.address = 'Cabatuan, Iloilo';
        testAcc.gender = 'Male';
        testAcc.medicalHistory = ['Anemia', 'Diabetes', 'AIDS'];
        testAcc.emergencyContact = testContact;

        MockFirestoreInstance instance = MockFirestoreInstance();
        String uid = '123';
        DatabaseService database =
            DatabaseService(uid: uid, firestore: instance);
        await database.insertPatient(testAcc);
        DocumentSnapshot patientDoc =
            await instance.collection('patients').document(uid).get();

        expect(patientDoc.data['keywords'], testAcc.keywords);
        expect(patientDoc.data['email'], testAcc.email);
        expect(patientDoc.data['contactNumber'], testAcc.contactNo);
        expect(patientDoc.data['lastName'], testAcc.lastName);
        expect(patientDoc.data['firstName'], testAcc.firstName);

        // TODO: Fix test case
        // expect(document.data['birthDate'], testAcc.birthDate);

        expect(patientDoc.data['middleInitial'], testAcc.middleInitial);
        expect(patientDoc.data['address'], testAcc.address);
        expect(patientDoc.data['gender'], testAcc.gender);
        expect(patientDoc.data['medicalHistory'], testAcc.medicalHistory);

        // TODO: add test cases to check contact
      });
    });

    group('.getPatient', () {
      test('returns patient instance given uid parameter from firestore',
          () async {
        MockFirestoreInstance instance = MockFirestoreInstance();
        String uid = '123';
        DatabaseService database =
            DatabaseService(uid: uid, firestore: instance);

        await instance.collection('patients').document(uid).setData({
          'firstName': 'Veto',
          'middleInitial': 'X',
          'lastName': 'Bastiero',
          'gender': 'Male',
          'birthDate': DateTime(2000, 1, 1),
          'address': 'Cabatuan, Iloilo',
          'contactNumber': '09121231234',
          'medicalHistory': ['Anemia', 'AIDS', 'Diabetes'],
          // emergency contact
          'bloodType': 'B',
          'weight': 57,
          'height': 166,
          'bodyTemperature': 37
        });

        await instance
            .collection('bloodPressures')
            .document(uid)
            .setData({'lastChecked': DateTime.now(), 'reading': '120/80 mm'});

        await instance
            .collection('bloodSugarLevels')
            .document(uid)
            .setData({'lastChecked': DateTime.now(), 'reading': '100mg'});

        Patient testPatient = await database.getPatient(uid);
        
      });
    });
  });
}

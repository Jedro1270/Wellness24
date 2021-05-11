import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/blood_sugar_level.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/emergency_contact.dart';
import 'package:wellness24/models/new_account.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/services/database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      DatabaseService database = DatabaseService(uid: uid, firestore: instance);

      await database.insertRole('Patient');
      DocumentSnapshot snapshot =
          await instance.collection('roles').document(uid).get();
      String insertedRole = snapshot.data['role'];
      expect(insertedRole, 'Patient');
    });

    test('should insert the role "Doctor" to roles collection', () async {
      MockFirestoreInstance instance = MockFirestoreInstance();
      String uid = '123';
      DatabaseService database = DatabaseService(uid: uid, firestore: instance);

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
      testAcc.contactNumber = '09123312312';
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
      DatabaseService database = DatabaseService(uid: uid, firestore: instance);

      await database.insertDoctor(testAcc);

      DocumentSnapshot document =
          await instance.collection('doctors').document(uid).get();

      expect(document.data['keywords'], testAcc.keywords);
      expect(document.data['email'], testAcc.email);
      expect(document.data['contactNumber'], testAcc.contactNumber);
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
    EmergencyContact testContact = EmergencyContact(
        lastName: 'Bastiero',
        firstName: 'Mom',
        middleInitial: 'F',
        address: 'Cabatuan, Iloilo',
        contactNumber: '09221231232',
        relationship: 'Mother');

    NewAccount testAcc = NewAccount('Patient');
    testAcc.keywords = ['v', 've', 'vet', 'veto'];
    testAcc.email = 'veto@gmail.com';
    testAcc.contactNumber = '09123312312';
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
    DatabaseService database = DatabaseService(uid: uid, firestore: instance);
    test('should insert newacc object to firestore as patient', () async {
      await database.insertPatient(testAcc);
      DocumentSnapshot patientDoc =
          await instance.collection('patients').document(uid).get();

      expect(patientDoc.data['keywords'], testAcc.keywords);
      expect(patientDoc.data['email'], testAcc.email);
      expect(patientDoc.data['contactNumber'], testAcc.contactNumber);
      expect(patientDoc.data['lastName'], testAcc.lastName);
      expect(patientDoc.data['firstName'], testAcc.firstName);

      // TODO: Fix test case
      // expect(document.data['birthDate'], testAcc.birthDate);

      expect(patientDoc.data['middleInitial'], testAcc.middleInitial);
      expect(patientDoc.data['address'], testAcc.address);
      expect(patientDoc.data['gender'], testAcc.gender);
      expect(patientDoc.data['medicalHistory'], testAcc.medicalHistory);
    });
    test('should insert emergency contact info, to emergencyContacts collecion',
        () async {
      DocumentSnapshot emergContactInfo =
          await instance.collection('emergencyContacts').document(uid).get();

      expect(emergContactInfo.data['firstName'], testContact.firstName);
      expect(emergContactInfo.data['lastName'], testContact.lastName);
      expect(emergContactInfo.data['address'], testContact.address);
      expect(emergContactInfo.data['contactNumber'], testContact.contactNumber);
      expect(emergContactInfo.data['relationship'], testContact.relationship);
    });
  });

  group('.getPatient', () {
    test('returns patient instance given uid parameter from firestore',
        () async {
      MockFirestoreInstance instance = MockFirestoreInstance();
      String uid = '123';
      DatabaseService database = DatabaseService(uid: uid, firestore: instance);

      await instance.collection('patients').document(uid).setData({
        'firstName': 'Veto',
        'middleInitial': 'X',
        'lastName': 'Bastiero',
        'gender': 'Male',
        'birthDate': DateTime(2000, 1, 1).toIso8601String(),
        'address': 'Cabatuan, Iloilo',
        'contactNumber': '09121231234',
        'medicalHistory': ['Anemia', 'AIDS', 'Diabetes'],
        // emergency contact
        'bloodType': 'B',
        'weight': 57.0,
        'height': 166.0,
        'bodyTemperature': 37.0
      });

      await instance
          .collection('bloodPressures')
          .document(uid)
          .setData({'lastChecked': DateTime.now().toIso8601String(), 'reading': '120/80 mm'});

      await instance
          .collection('bloodSugarLevels')
          .document(uid)
          .setData({'lastChecked': DateTime.now().toIso8601String(), 'reading': '100mg'});

      Patient testPatient = await database.getPatient(uid);

      expect(testPatient, isInstanceOf<Patient>());
      expect(testPatient.fullName, 'Veto X. Bastiero');
      expect(testPatient.address, 'Cabatuan, Iloilo');
      expect(testPatient.height, 166);
      expect(testPatient.weight, 57);

      expect(testPatient.bloodPressure, isInstanceOf<BloodPressure>());
      expect(testPatient.bloodPressure.reading, '120/80 mm');
      expect(testPatient.bloodSugarLevel, isInstanceOf<BloodSugarLevel>());
      expect(testPatient.bloodSugarLevel.reading, '100mg');
    });
  });
  group('.getDoctor', () {
    test('returns doctor instance given uid parameter from firestore',
        () async {
      MockFirestoreInstance instance = MockFirestoreInstance();
      String uid = '123';
      DatabaseService database = DatabaseService(uid: uid, firestore: instance);

      String education =
          'Phd Pediatrics - UP Diliman,  Medicine - UST, BS Bio Central Philippine University';
      String about =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus at sem feugiat, hendrerit ex sed, tincidunt diam. Praesent et pellentesque mi. Vivamus luctus libero in tempus tristique. Mauris dapibus nunc sit amet nibh fringilla, sed accumsan magna commodo. Praesent quis maximus metus. Suspendisse nec gravida est. Donec finibus libero vel augue fringilla volutpat. Maecenas nec neque volutpat, rutrum nunc sit amet, maximus sem. Fusce sit amet placerat mi. Aliquam sodales ligula erat, in sagittis lectus commodo nec. Proin tincidunt enim et augue euismod laoreet. Donec dapibus quam ut ullamcorper aliquam. Nulla facilisi.';

      await instance.collection('doctors').document(uid).setData({
        'firstName': 'Veto',
        'middleInitial': 'X',
        'lastName': 'Bastiero',
        'gender': 'Male',
        'birthDate': DateTime(2000, 1, 1).toIso8601String(),
        'address': 'Cabatuan, Iloilo',
        'contactNumber': '09121231234',
        'specialization': 'Pediatrician',
        'workingDays': 'Monday to Friday',
        'about': about,
        'clinicStart': '8:30 AM',
        'clinicEnd': '9:00 PM',
        'education': education
      });

      Doctor testDoc = await database.getDoctor(uid);

      expect(testDoc, isInstanceOf<Doctor>());
      expect(testDoc.firstName, 'Veto');
      expect(testDoc.lastName, 'Bastiero');
      expect(testDoc.middleInitial, 'X');
      expect(testDoc.specialization, 'Pediatrician');
      expect(testDoc.about, about);
      expect(testDoc.workingDays, 'Monday to Friday');
      expect(testDoc.clinicStart, '8:30 AM');
      expect(testDoc.clinicEnd, '9:00 PM');
      expect(testDoc.education, education);
    });
  });
  group('.updatePatient', () {
    MockFirestoreInstance instance = MockFirestoreInstance();
    String uid = '123';
    DatabaseService database = DatabaseService(uid: uid, firestore: instance);

    Patient testPatient = Patient(
        weight: 60.0,
        bloodType: 'A',
        birthDate: DateTime(2000, 1, 1),
        bodyTemperature: 35.9,
        height: 166,
        bloodPressure:
            BloodPressure(reading: '120/80 mm', lastChecked: DateTime.now()),
        bloodSugarLevel:
            BloodSugarLevel(lastChecked: DateTime.now(), reading: '100mg'));

    test('updates patient fields with data from patient instance', () async {
      await instance.collection('patients').document(uid).setData({
        'firstName': 'Veto',
        'middleInitial': 'X',
        'lastName': 'Bastiero',
        'gender': 'Male',
        'birthDate': DateTime(2000, 1, 1).toIso8601String(),
        'address': 'Cabatuan, Iloilo',
        'contactNumber': '09121231234',
        'medicalHistory': ['Anemia', 'AIDS', 'Diabetes'],
      });

      await database.updatePatient(testPatient);

      DocumentSnapshot updatedData =
          await instance.collection('patients').document(uid).get();

      expect(updatedData.data['weight'], 60);
      expect(updatedData.data['height'], 166);
      expect(updatedData.data['bloodType'], 'A');
      expect(updatedData.data['bodyTemperature'], 35.9);
    });
    test(
        'updates/sets bloodPressure fields on firestore given data from patient instance',
        () async {
      await instance.collection('patients').document(uid).setData({
        'firstName': 'Veto',
        'middleInitial': 'X',
        'lastName': 'Bastiero',
        'gender': 'Male',
        'birthDate': DateTime(2000, 1, 1).toIso8601String(),
        'address': 'Cabatuan, Iloilo',
        'contactNumber': '09121231234',
        'medicalHistory': ['Anemia', 'AIDS', 'Diabetes'],
      });

      await database.updatePatient(testPatient);

      DocumentSnapshot updatedBloodPressure =
          await instance.collection('bloodPressures').document(uid).get();

      expect(updatedBloodPressure.data['reading'], '120/80 mm');
    });

    test(
        'updates/sets bloodSugarLevels fields on firestore given data from patient instance',
        () async {
      await instance.collection('patients').document(uid).setData({
        'firstName': 'Veto',
        'middleInitial': 'X',
        'lastName': 'Bastiero',
        'gender': 'Male',
        'birthDate': DateTime(2000, 1, 1).toIso8601String(),
        'address': 'Cabatuan, Iloilo',
        'contactNumber': '09121231234',
        'medicalHistory': ['Anemia', 'AIDS', 'Diabetes'],
      });

      await database.updatePatient(testPatient);

      DocumentSnapshot updatedBloodSugar =
          await instance.collection('bloodSugarLevels').document(uid).get();

      expect(updatedBloodSugar.data['reading'], '100mg');
    });
  });
  group('.requestExists', () {
    MockFirestoreInstance instance = MockFirestoreInstance();
    String doctorId = '123';
    DatabaseService database =
        DatabaseService(uid: doctorId, firestore: instance);

    test(
        'should return false if patient id does not exist on doctor\'s requests',
        () async {
      await instance.collection('patientRequests').document(doctorId).setData({
        'requests': [
          {'uid': 'A1'},
          {'uid': 'B2'}
        ]
      });

      bool exists =
          await database.requestExists(doctorId: doctorId, patientId: 'C3');

      expect(exists, false);
    });
    test('should return true if patient id is present in doctor\'s requests',
        () async {
      await instance.collection('patientRequests').document(doctorId).setData({
        'requests': [
          {'uid': 'A1'},
          {'uid': 'B2'}
        ]
      });

      bool exists =
          await database.requestExists(doctorId: doctorId, patientId: 'B2');

      expect(exists, true);
    });
    test(
        'should return false if doctor still doesn\'t have patientRequest fields',
        () async {
      MockFirestoreInstance newInstance = MockFirestoreInstance();
      String doctorId = '123';
      DatabaseService newDatabase =
          DatabaseService(uid: doctorId, firestore: newInstance);
      bool exists =
          await newDatabase.requestExists(doctorId: doctorId, patientId: 'B2');

      expect(exists, false);
    });
  });
  group('.getPatientRequests', () {
    String doctorId = '123';
    test('should return array of patient requests', () async {
      MockFirestoreInstance instance = MockFirestoreInstance();
      DatabaseService database =
          DatabaseService(uid: doctorId, firestore: instance);
      List requestsValue = [
        {'uid': 'A1'},
        {'uid': 'A2'}
      ];
      await instance
          .collection('patientRequests')
          .document(doctorId)
          .setData({'requests': requestsValue});

      List requests = await database.getPatientRequest();

      expect(requests, requestsValue);
    });
    test('should return empty array if no patient request document', () async {
      MockFirestoreInstance instance = MockFirestoreInstance();
      DatabaseService database =
          DatabaseService(uid: doctorId, firestore: instance);
      List requests = await database.getPatientRequest();

      expect(requests, []);
    });
  });
  group('.isDoctor', () {
    test('should return true if doctorId is present in patient\'s doctors',
        () async {
      String patientId = '123';
      String doctorId = '321';
      MockFirestoreInstance instance = MockFirestoreInstance();
      DatabaseService database =
          DatabaseService(uid: patientId, firestore: instance);
      await instance.collection('patients').document(patientId).setData({
        'firstName': 'Veto',
        'lastName': 'Bastiero',
        'birthDate': DateTime(2000, 1, 1).toIso8601String(),
        'contactNumber': '09221231221',
        'email': 'v@gmail.com',
        'gender': 'Male',
        'keywords': ['v', 've', 'vet'],
        'medicalHistory': ['Anemia', 'Alergic Rhinitis'],
        'doctors': [
          {'uid': doctorId}
        ]
      });

      bool isDoctor = await database.isMyDoctor(doctorId);
      expect(isDoctor, true);
    });
    test('should return false if doctorId is not present in patient\'s doctors',
        () async {
      String patientId = '123';
      MockFirestoreInstance instance = MockFirestoreInstance();
      DatabaseService database =
          DatabaseService(uid: patientId, firestore: instance);
      await instance.collection('patients').document(patientId).setData({
        'firstName': 'Veto',
        'lastName': 'Bastiero',
        'birthDate': DateTime(2000, 1, 1).toIso8601String(),
        'contactNumber': '09221231221',
        'email': 'v@gmail.com',
        'gender': 'Male',
        'keywords': ['v', 've', 'vet'],
        'medicalHistory': ['Anemia', 'Alergic Rhinitis'],
        'doctors': [
          {'uid': '321'}
        ]
      });

      bool isDoctor = await database.isMyDoctor('111');
      expect(isDoctor, false);
    });
    test('should return false if patient does not have doctors field',
        () async {
      String patientId = '123';
      MockFirestoreInstance instance = MockFirestoreInstance();
      DatabaseService database =
          DatabaseService(uid: patientId, firestore: instance);
      await instance.collection('patients').document(patientId).setData({
        'firstName': 'Veto',
        'lastName': 'Bastiero',
        'birthDate': DateTime(2000, 1, 1).toIso8601String(),
        'contactNumber': '09221231221',
        'email': 'v@gmail.com',
        'gender': 'Male',
        'keywords': ['v', 've', 'vet'],
        'medicalHistory': ['Anemia', 'Alergic Rhinitis']
      });

      bool isDoctor = await database.isMyDoctor('123');
      expect(isDoctor, false);
    });
  });
  group('.uploadMessage', () {
    String patientId = '123';
    String doctorId = '321';
    MockFirestoreInstance instance = MockFirestoreInstance();
    DatabaseService database =
        DatabaseService(uid: patientId, firestore: instance);
    test('should insert message to firestore messages collection', () async {
      await database.uploadMessage(patientId, doctorId, 'Test message');
      QuerySnapshot snapshots =
          await instance.collection('messages').getDocuments();
      Map messageData = snapshots.documents.first.data;
      expect(messageData['senderUid'], patientId);
      expect(messageData['receiverUid'], doctorId);
      expect(messageData['content'], 'Test message');
    });
  });

  group('.isScheduled', () {
    MockFirestoreInstance instance = MockFirestoreInstance();
    String patientId = 'patient123';
    String doctorId = 'doctor321';
    DatabaseService database =
        DatabaseService(uid: patientId, firestore: instance);
    test('should return true if patient appointments contains doctor id',
        () async {
      await instance.collection('patients').document(patientId).setData({
        'firstName': 'Veto',
        'lastName': 'Bastiero',
        'appointments': {
          '01-01-2021': [
            {'doctorId': doctorId, 'priorityNum': 5},
            {'doctorId': 'dummy1', 'priorityNum': 1}
          ],
          '01-02-2021': [
            {'doctorId': 'dummy2', 'priorityNum': '2'}
          ]
        }
      });

      bool result = await database.isScheduled(DateTime(2021, 1, 1), doctorId);
      expect(result, true);
    });
  });
  group('.getPriorityNum', () {
    MockFirestoreInstance instance = MockFirestoreInstance();
    String patientId = 'patient123';
    String doctorId = 'doctor321';
    DatabaseService database =
        DatabaseService(uid: patientId, firestore: instance);

    test('should return priority number when fetched', () async {
      await database.patients.document(patientId).setData({
        'firstName': 'Veto',
        'lastName': 'Bastiero',
        'appointments': {
          '01-01-2021': [
            {'doctorId': doctorId, 'priorityNum': 7}
          ]
        }
      });

      int result =
          await database.getPriorityNum(doctorId, DateTime(2021, 1, 1));
      expect(result, 7);
    });
  });

  group('.getAppointmentQueueCap', () {
    MockFirestoreInstance instance = MockFirestoreInstance();
    String doctorId = 'doctor321';
    DatabaseService database =
        DatabaseService(uid: doctorId, firestore: instance);
    test('should return number of appointment reservations', () async {
      await database.doctors.document(doctorId).setData({
        'firstName': 'Veto',
        'lastName': 'Bastiero',
        'appointments': {'01-01-2021': 22}
      });

      int result = await database.getAppointmentQueueCap(DateTime(2021, 1, 1));
      expect(result, 22);
    });
  });
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/emergency_contact.dart';
import 'package:wellness24/models/new_account.dart';
import 'package:wellness24/models/patient.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference roles = Firestore.instance.collection('roles');
  final CollectionReference doctors = Firestore.instance.collection('doctors');
  final CollectionReference patients =
      Firestore.instance.collection('patients');
  final CollectionReference emergencyContacts =
      Firestore.instance.collection('emergencyContacts');
  final CollectionReference patientRequests =
      Firestore.instance.collection('patientRequests');
  final CollectionReference bloodPressure =
      Firestore.instance.collection('bloodPressure');

  Future<String> getRole() async {
    String snapshot = await roles
        .document(this.uid)
        .get()
        .then((snapshots) => snapshots.data['role']);
    return snapshot;
  }

  Future insertRole(String role) async {
    roles.document(uid).setData({'role': role});
  }

  Future insertDoctor(NewAccount doctorAccount) async {
    await doctors.document(uid).setData({
      'keywords': doctorAccount.keywords,
      'email': doctorAccount.email,
      'contactNumber': doctorAccount.contactNo,
      'lastName': doctorAccount.lastName,
      'firstName': doctorAccount.firstName,
      'middleInitial': doctorAccount.middleInitial,
      'birthDate': doctorAccount.birthDate,
      'address': doctorAccount.address,
      'gender': doctorAccount.gender,
      'licenseNo': doctorAccount.licenseNo,
      'clinicLocation': doctorAccount.clinicLocation,
      'workingDays': doctorAccount.workingDays,
      'clinicStart': doctorAccount.clinicStart,
      'clinicEnd': doctorAccount.clinicEnd,
      'specialization': doctorAccount.specialization,
      'education': doctorAccount.education,
      'about': doctorAccount.about
    });
  }

  Future insertPatient(NewAccount patientAccount) async {
    await patients.document(uid).setData({
      'keywords': patientAccount.keywords,
      'email': patientAccount.email,
      'contactNumber': patientAccount.contactNo,
      'lastName': patientAccount.lastName,
      'firstName': patientAccount.firstName,
      'middleInitial': patientAccount.middleInitial,
      'birthDate': patientAccount.birthDate,
      'address': patientAccount.address,
      'gender': patientAccount.gender,
      'medicalHistory': patientAccount.medicalHistory
    });

    EmergencyContact emergencyContact = patientAccount.emergencyContact;

    await emergencyContacts.add({
      'patientId': uid,
      'lastName': emergencyContact.lastName,
      'firstName': emergencyContact.firstName,
      'middleInitial': emergencyContact.middleInitial,
      'address': emergencyContact.address,
      'contactNumber': emergencyContact.contactNo,
      'relationship': emergencyContact.relationship
    });
  }

  Patient patientFromSnapshot(DocumentSnapshot document) {
    return document == null
        ? null
        : Patient(
            uid: document.documentID,
            firstName: document.data['firstName'],
            lastName: document.data['lastName'],
            middleInitial: document.data['middleInitial'],
            gender: document.data['gender'],
            birthDate: document.data['birthDate'],
            address: document.data['address'],
            contactNo: document.data['contactNumber'],
            emergencyContact: document.data['emergencyContact'] ?? null,
            medicalHistory: document.data['medicalHistory'],
            bloodPressure: null,
            bloodType: document.data['bloodType'],
            weight: document.data['weight']);
  }

  BloodPressure bloodPressureFromSnapshot(DocumentSnapshot document) {
    return BloodPressure(
        reading: document.data['reading'],
        lastChecked: document.data['lastChecked']);
  }

  Stream<Patient> get currentPatient {
    return patients.document(uid).snapshots().map(patientFromSnapshot);
  }

  Stream<BloodPressure> get currentBloodPressure {
    return bloodPressure
        .document(uid)
        .snapshots()
        .map(bloodPressureFromSnapshot);
  }

  Future<Patient> getPatient(String uid) async {
    DocumentSnapshot snapshotPatient = await patients.document(uid).get();
    DocumentSnapshot snapshotBloodPressure =
        await bloodPressure.document(uid).get();

    return Patient(
        firstName: snapshotPatient.data['firstName'],
        middleInitial: snapshotPatient.data['middleInitial'],
        lastName: snapshotPatient.data['lastName'],
        gender: snapshotPatient.data['gender'],
        birthDate: snapshotPatient.data['birthDate'],
        address: snapshotPatient.data['address'],
        contactNo: snapshotPatient.data['contactNo'],
        medicalHistory: snapshotPatient.data['medicalHistory'],
        emergencyContact: snapshotPatient.data['emergencyContact'],
        bloodPressure: BloodPressure(
            reading: snapshotBloodPressure.data['reading'],
            lastChecked: snapshotBloodPressure.data['lastChecked'].toDate()),
        bloodType: snapshotPatient.data['bloodType'],
        weight: snapshotPatient.data['weight']);
  }

  Future<Doctor> getDoctor(String uid) async {
    DocumentSnapshot snapshotDoctor = await doctors.document(uid).get();

    return Doctor(
        uid: uid,
        firstName: snapshotDoctor['firstName'],
        middleInitial: snapshotDoctor['middleInitial'],
        lastName: snapshotDoctor['lastName'],
        specialization: snapshotDoctor['specialization'],
        about: snapshotDoctor['about'],
        workingDays: snapshotDoctor['workingDays'],
        clinicStartHour: snapshotDoctor['clinicStartHour'],
        clinicEndHour: snapshotDoctor['clinicEndHour'],
        clinicDayStart: snapshotDoctor['clinicDayStart'],
        clinicDayEnd: snapshotDoctor['clinicDayEnd']);
  }

  Future updatePatient(Patient patient) async {
    await patients.document(uid).updateData({
      'weight': patient.weight,
      'bloodType': patient.bloodType,
      'birthDate': patient.birthDate
    });

    await bloodPressure.document(uid).setData({
      'reading': patient.bloodPressure.reading,
      'lastChecked': patient.bloodPressure.lastChecked
    });
  }

  Future sendRequest({String doctorId, Patient patient}) async {
    await patientRequests.document(doctorId).setData({
      'requests': FieldValue.arrayUnion([
        {
          'uid': patient.uid,
          'firstName': patient.firstName,
          'lastName': patient.lastName,
          'birthDate': patient.birthDate,
          'address': patient.address,
          'contactNo': patient.contactNo,
          'medicalHistory': patient.medicalHistory,
          'bloodType': patient.bloodType,
          'weight': patient.weight
        }
      ])
    });
  }

  Future<List> getPatientRequest() async {
    DocumentSnapshot document = await patientRequests.document(uid).get();
    return document == null ? [] : document.data['requests'];
  }

  Future acceptPatient(dynamic patientInfo) async {
    await doctors.document(uid).setData({
      'patients': FieldValue.arrayUnion([patientInfo])
    }, merge: true);

    await patientRequests.document(uid).updateData({
      'requests': FieldValue.arrayRemove([patientInfo])
    });
  }

  Future declinePatient(dynamic patientInfo) async {
    await patientRequests.document(uid).updateData({
      'requests': FieldValue.arrayRemove([patientInfo])
    });
  }
}

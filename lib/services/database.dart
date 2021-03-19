import 'package:cloud_firestore/cloud_firestore.dart';
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
            firstName: document.data['firstName'],
            lastName: document.data['lastname'],
            middleInitial: document.data['lastname'],
            gender: document.data['gender'],
            birthDate: document.data['birthDate'],
            address: document.data['address'],
            contactNo: document.data['contactNo'],
            emergencyContact: null,
            medicalHistory: document.data['medicalHistory'],
            bloodPressure: null,
            bloodType: document.data['bloodType'],
            weight: document.data['weight']);
  }

  Stream<Patient> get currentPatient {
    return patients.document(uid).snapshots().map(patientFromSnapshot);
  }

  Stream<DocumentSnapshot> get cPatient {
    return patients.document(uid).snapshots();
  }
}

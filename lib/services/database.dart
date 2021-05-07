import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/blood_sugar_level.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/emergency_contact.dart';
import 'package:wellness24/models/medical_record.dart';
import 'package:wellness24/models/new_account.dart';
import 'package:wellness24/models/patient.dart';

class DatabaseService {
  final String uid;
  var firestore;

  CollectionReference roles;
  CollectionReference doctors;
  CollectionReference patients;
  CollectionReference emergencyContacts;
  CollectionReference patientRequests;
  CollectionReference bloodPressures;
  CollectionReference bloodSugarLevels;
  CollectionReference messages;
  CollectionReference medicalRecords;

  DatabaseService({this.uid, this.firestore}) {
    if (this.firestore == null) {
      this.firestore = Firestore.instance;
    }

    roles = firestore.collection('roles');
    doctors = firestore.collection('doctors');
    patients = firestore.collection('patients');
    emergencyContacts = firestore.collection('emergencyContacts');
    patientRequests = firestore.collection('patientRequests');
    bloodPressures = firestore.collection('bloodPressures');
    bloodSugarLevels = firestore.collection('bloodSugarLevels');
    messages = firestore.collection('messages');
    medicalRecords = firestore.collection('medicalRecords');
  }

  Future<String> getRole() async {
    String snapshot = await roles
        .document(this.uid)
        .get()
        .then((snapshots) => snapshots.data['role']);
    return snapshot;
  }

  Future insertRole(String role) async {
    await roles.document(uid).setData({'role': role});
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

    await emergencyContacts.document(uid).setData({
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
    return bloodPressures
        .document(uid)
        .snapshots()
        .map(bloodPressureFromSnapshot);
  }

  Future<Patient> getPatient(String uid) async {
    DocumentSnapshot snapshotPatient = await patients.document(uid).get();
    DocumentSnapshot snapshotBloodPressure =
        await bloodPressures.document(uid).get();

    DocumentSnapshot snapshotBloodSugarLevel =
        await bloodSugarLevels.document(uid).get();

    return Patient(
        uid: snapshotPatient.documentID,
        firstName: snapshotPatient.data['firstName'],
        middleInitial: snapshotPatient.data['middleInitial'],
        lastName: snapshotPatient.data['lastName'],
        gender: snapshotPatient.data['gender'],
        birthDate: snapshotPatient.data['birthDate'].toDate(),
        address: snapshotPatient.data['address'],
        contactNo: snapshotPatient.data['contactNumber'],
        medicalHistory: snapshotPatient.data['medicalHistory'],
        emergencyContact: snapshotPatient.data['emergencyContact'],
        bloodPressure: snapshotBloodPressure.data == null ||
                snapshotBloodPressure.data.isEmpty
            ? null
            : BloodPressure(
                reading: snapshotBloodPressure.data['reading'],
                lastChecked:
                    snapshotBloodPressure.data['lastChecked'].toDate()),
        bloodSugarLevel: snapshotBloodSugarLevel.data == null ||
                snapshotBloodSugarLevel.data.isEmpty
            ? null
            : BloodSugarLevel(
                reading: snapshotBloodSugarLevel.data['reading'],
                lastChecked:
                    snapshotBloodSugarLevel.data['lastChecked'].toDate()),
        bloodType: snapshotPatient.data['bloodType'],
        weight: snapshotPatient.data['weight'],
        height: snapshotPatient.data['height'],
        bodyTemperature: snapshotPatient.data['bodyTemperature']);
  }

  Future<Doctor> getDoctor(String uid) async {
    DocumentSnapshot snapshotDoctor = await doctors.document(uid).get();

    return Doctor(
        uid: snapshotDoctor.documentID,
        firstName: snapshotDoctor['firstName'],
        middleInitial: snapshotDoctor['middleInitial'],
        lastName: snapshotDoctor['lastName'],
        specialization: snapshotDoctor['specialization'],
        about: snapshotDoctor['about'],
        workingDays: snapshotDoctor['workingDays'],
        clinicStartHour: snapshotDoctor['clinicStart'],
        clinicEndHour: snapshotDoctor['clinicEnd'],
        clinicDayStart: snapshotDoctor['clinicDayStart'],
        clinicDayEnd: snapshotDoctor['clinicDayEnd'],
        education: snapshotDoctor['education']);
  }

  Future updatePatient(Patient patient) async {
    await patients.document(uid).updateData({
      'weight': patient.weight,
      'bloodType': patient.bloodType,
      'birthDate': patient.birthDate,
      'bodyTemperature': patient.bodyTemperature,
      'height': patient.height
    });

    await bloodPressures.document(uid).setData({
      'reading': patient.bloodPressure.reading,
      'lastChecked': patient.bloodPressure.lastChecked
    });

    await bloodSugarLevels.document(uid).setData({
      'reading': patient.bloodSugarLevel.reading,
      'lastChecked': patient.bloodSugarLevel.lastChecked
    });
  }

  Future sendRequest({String doctorId, String patientId}) async {
    await patientRequests.document(doctorId).setData({
      'requests': FieldValue.arrayUnion([
        {'uid': patientId}
      ])
    }, merge: true);
  }

  Future cancelRequest({String doctorId, String patientId}) async {
    await patientRequests.document(doctorId).updateData({
      'requests': FieldValue.arrayRemove([
        {'uid': patientId}
      ])
    });
  }

  Future<bool> requestExists({String doctorId, String patientId}) async {
    DocumentSnapshot document = await patientRequests.document(doctorId).get();
    if (document.data['requests'] == null) {
      return false;
    }

    return document.data['requests'].any((e) {
      return e['uid'] == patientId;
    });
  }

  Future<List> getPatientRequest() async {
    DocumentSnapshot document = await patientRequests.document(uid).get();
    return document == null
        ? []
        : document.data['requests'] == null
            ? []
            : document.data['requests'];
  }

  Future acceptPatient(String patientId) async {
    // adds patient id to doctor.patients
    await doctors.document(uid).setData({
      'patients': FieldValue.arrayUnion([
        {'uid': patientId}
      ])
    }, merge: true);

    // removes patient on patient requests
    await patientRequests.document(uid).updateData({
      'requests': FieldValue.arrayRemove([
        {'uid': patientId}
      ])
    });

    // adds doctor id to patient.doctors
    await patients.document(patientId).setData({
      'doctors': FieldValue.arrayUnion([
        {'uid': uid}
      ])
    }, merge: true);
  }

  Future declinePatient(String patientId) async {
    await patientRequests.document(uid).updateData({
      'requests': FieldValue.arrayRemove([
        {'uid': patientId}
      ])
    });
  }

  Future<bool> isMyDoctor(String doctorId) async {
    DocumentSnapshot document = await patients.document(uid).get();
    if (document.data['doctors'] != null) {
      return document.data['doctors'].any((e) {
        return e['uid'] == doctorId;
      });
    }

    return false;
  }

  Future uploadMessage(
      String senderUid, String receiverUid, String content) async {
    await messages.add({
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'dateCreated': DateTime.now(),
      'content': content
    });
  }

  Future<bool> isScheduled(DateTime date, String doctorId) async {
    String dateString = DateFormat('MM-dd-yyyy').format(date);
    DocumentSnapshot document = await patients.document(uid).get();
    List dateAppointment = document.data['appointments'][dateString];
    if (dateAppointment != null) {
      return dateAppointment.any((info) => info['doctorId'] == doctorId);
    }

    return false;
  }

  Future uploadMedicalRecord(MedicalRecord medicalRecord) async {
    await medicalRecords.add({
      'patientUid': medicalRecord.patientUid,
      'title': medicalRecord.title,
      'notes': medicalRecord.notes,
      'lastEdited': medicalRecord.lastEdited,
      'imageUrl': medicalRecord.imageUrl
    });
  }

  Future updateMedicalRecord(MedicalRecord medicalRecord) async {
    await medicalRecords.document(medicalRecord.id).setData({
      'patientUid': medicalRecord.patientUid,
      'title': medicalRecord.title,
      'notes': medicalRecord.notes,
      'lastEdited': medicalRecord.lastEdited,
      'imageUrl': medicalRecord.imageUrl
    });
  }

  Future<List<MedicalRecord>> getMedicalRecords(String patientUid) async {
    QuerySnapshot snapshot =
        await medicalRecords.orderBy('lastEdited').getDocuments();
    var result = snapshot.documents
        .where((document) => document.data['patientUid'] == patientUid)
        .toList();

    return result
        .map((document) => MedicalRecord(
              id: document.documentID,
              patientUid: document.data['patientUid'],
              title: document.data['title'],
              notes: document.data['notes'],
              lastEdited: document.data['lastEdited'].toDate(),
              imageUrl: document.data['imageUrl'],
            ))
        .toList();
  }

  Future addAppointment(String doctorId, DateTime date) async {
    String dateString = DateFormat('MM-dd-yyyy').format(date);

    await doctors.document(doctorId).updateData({
      'appointments.$dateString':
          FieldValue == null ? 1 : FieldValue.increment(1)
    });

    DocumentSnapshot updatedDoc = await doctors.document(doctorId).get();
    dynamic priorityNum = updatedDoc.data['appointments'][dateString];

    await patients.document(uid).updateData({
      'appointments.$dateString': FieldValue.arrayUnion([
        {'doctorId': doctorId, 'priorityNum': priorityNum}
      ])
    });
  }

  Future<int> getPriorityNum(String doctorId, DateTime date) async {
    String dateString = DateFormat('MM-dd-yyyy').format(date);
    DocumentSnapshot patientDoc = await patients.document(uid).get();
    List appointmentsOnDate = patientDoc.data['appointments'][dateString];

    Map appointmentData = appointmentsOnDate.firstWhere((el) {
      return el['doctorId'] == doctorId;
    });

    return appointmentData['priorityNum'];
  }

  Future<int> getAppointmentQueueCap(DateTime date) async {
    String dateString = DateFormat('MM-dd-yyyy').format(date);
    DocumentSnapshot document = await doctors.document(uid).get();
    return document.data['appointments'][dateString];
  }
}

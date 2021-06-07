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
    await doctors.document(uid).setData(doctorAccount.toJson());
  }

  Future insertPatient(NewAccount patientAccount) async {
    await patients.document(uid).setData(patientAccount.toJson());

    EmergencyContact emergencyContact = patientAccount.emergencyContact;

    await emergencyContacts.document(uid).setData(emergencyContact.toJson());
  }

  Patient patientFromSnapshot(DocumentSnapshot document) {
    return document == null
        ? null
        : Patient.fromJson(document.data, document.documentID);
  }

  BloodPressure bloodPressureFromSnapshot(DocumentSnapshot document) {
    return BloodPressure.fromJson(document.data);
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

    Patient patient =
        Patient.fromJson(snapshotPatient.data, snapshotPatient.documentID);

    if (snapshotBloodPressure.data != null) {
      patient.bloodPressure =
          BloodPressure.fromJson(snapshotBloodPressure.data);
    } else {
      patient.bloodPressure = BloodPressure();
    }

    if (snapshotBloodSugarLevel.data != null) {
      patient.bloodSugarLevel =
          BloodSugarLevel.fromJson(snapshotBloodSugarLevel.data);
    } else {
      patient.bloodSugarLevel = BloodSugarLevel();
    }

    return patient;
  }

  Future<Doctor> getDoctor(String uid) async {
    DocumentSnapshot snapshotDoctor = await doctors.document(uid).get();

    return Doctor.fromJson(snapshotDoctor.data, snapshotDoctor.documentID);
  }

  Future updatePatient(Patient patient) async {
    await patients.document(uid).updateData(patient.toJson());

    await bloodPressures.document(uid).setData(patient.bloodPressure.toJson());

    await bloodSugarLevels
        .document(uid)
        .setData(patient.bloodSugarLevel.toJson());
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
    if (document.data == null) return false;

    if (document.data['requests'] == null) return false;

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
    await medicalRecords.add(medicalRecord.toJson());
  }

  Future updateMedicalRecord(MedicalRecord medicalRecord) async {
    await medicalRecords
        .document(medicalRecord.id)
        .setData(medicalRecord.toJson());
  }

  Future<List<MedicalRecord>> getMedicalRecords(String patientUid) async {
    QuerySnapshot snapshot =
        await medicalRecords.orderBy('lastEdited').getDocuments();
    var result = snapshot.documents
        .where((document) => document.data['patientUid'] == patientUid)
        .toList();

    return result
        .map((document) => MedicalRecord.fromJson(document.data))
        .toList();
  }

  Future addAppointment(String doctorId, DateTime date) async {
    String dateString = DateFormat('MM-dd-yyyy').format(date);

    int limit = await getAppointmentQueueCap(date, doctorId: doctorId);
    int priorityNum = await doctors
        .document(doctorId)
        .get()
        .then((value) => value['appointments'][dateString] + 1);

    if (priorityNum <= limit) {
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
    } else {
      return 'Limit reached';
    }
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

  Future<void> updateAppointmentQueueCap(int newLimit, DateTime date) async {
    String dateString = DateFormat('MM-dd-yyyy').format(date);

    return await doctors
        .document(uid)
        .updateData({'appointmentLimits.$dateString': newLimit});
  }

  Future<int> getAppointmentQueueCap(DateTime date, {String doctorId}) async {
    String dateString = DateFormat('MM-dd-yyyy').format(date);
    DocumentSnapshot document = await doctors.document(doctorId ?? uid).get();

    int output = document.data['appointmentLimits'] == null
        ? 15
        : document.data['appointmentLimits'][dateString];

    return output;
  }

  Future updateProfilePicture(String profilePictureUrl) async {
    String role = await getRole();

    if (role == 'Doctor') {
      doctors
          .document(this.uid)
          .updateData({'profilePictureUrl': profilePictureUrl});
    } else {
      patients
          .document(this.uid)
          .updateData({'profilePictureUrl': profilePictureUrl});
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wellness24/models/new_account.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference roles = Firestore.instance.collection('roles');
  final CollectionReference doctors = Firestore.instance.collection('doctors');

  //gets user role "doctor/patient"
  Future getRole() async {
    return await roles.document(uid).get();
  }

  void insertDoctor(NewAccount doctorAccount) {
    doctors.document(uid).setData({
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
      'clinicStart': doctorAccount.clinicStart,
      'clinicEnd': doctorAccount.clinicEnd,
      'specialization': doctorAccount.specialization
    });
  }
}

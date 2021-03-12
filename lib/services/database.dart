import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference roles = Firestore.instance.collection('roles');

  //gets user role "doctor/patient"
  Future getRole() async {
    return await roles.document(uid).get();
  }
}

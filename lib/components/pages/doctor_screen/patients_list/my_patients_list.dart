import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/doctor_screen/patients_list/patient_info.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/services/database.dart';

class MyPatientsList extends StatefulWidget {
  final CollectionReference doctorDatabaseRef;
  final String doctorId;

  MyPatientsList({this.doctorDatabaseRef, this.doctorId});

  @override
  _MyPatientsListState createState() => _MyPatientsListState();
}

class _MyPatientsListState extends State<MyPatientsList> {
  List<PatientInfo> patients = [];
  DatabaseService database;

  void getPatients() async {
    database = DatabaseService(uid: widget.doctorId);

    List<PatientInfo> mappedPatients = [];

    DocumentSnapshot snapshot =
        await widget.doctorDatabaseRef.document(widget.doctorId).get();

    await Future.forEach(snapshot.data['patients'], (patient) async {
      Patient currentPatient = await database.getPatient(patient['uid']);

      mappedPatients.add(PatientInfo(patient: currentPatient));
    });

    setState(() {
      patients = mappedPatients;
    });
  }

  @override
  void initState() {
    getPatients();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(primary: false, children: patients);
  }
}

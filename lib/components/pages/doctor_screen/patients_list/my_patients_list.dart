import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/pages/doctor_screen/patients_list/patient_info.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/services/database.dart';

class MyPatientsList extends StatefulWidget {
  final CollectionReference doctorDatabaseRef;
  final String doctorId;
  final List mockPatients;

  MyPatientsList({this.doctorDatabaseRef, this.doctorId, this.mockPatients});

  @override
  _MyPatientsListState createState() => _MyPatientsListState();
}

class _MyPatientsListState extends State<MyPatientsList> {
  List<PatientInfo> patients = [];
  DatabaseService database;

  void getPatients() async {
    if (widget.mockPatients.isEmpty) {
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
    } else {
      setState(() {
        patients =
            widget.mockPatients.map((p) => PatientInfo(patient: p)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPatients();
  }

  @override
  Widget build(BuildContext context) {
    Widget page = Loading();

    if (patients.isEmpty) {
      setState(() {
        page = Container(
          alignment: Alignment.center,
          child: Text(
            'No patients yet',
            style: TextStyle(
              color: Colors.grey[600],
              fontFamily: "ShipporiMincho",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          height: 40,
        );
      });
    } else {
      setState(() {
        page = ListView(
          primary: false,
          children: patients,
          shrinkWrap: true,
        );
      });
    }
    return page;
  }
}

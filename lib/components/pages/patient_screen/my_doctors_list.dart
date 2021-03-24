import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/doctor_info.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/services/database.dart';

class MyDoctorsList extends StatefulWidget {
  final CollectionReference patientDatabaseRef;
  final String patientId;

  MyDoctorsList({this.patientDatabaseRef, this.patientId});

  @override
  _MyDoctorsListState createState() => _MyDoctorsListState();
}

class _MyDoctorsListState extends State<MyDoctorsList> {
  List<DoctorInfo> doctors = [];
  DatabaseService database;

  void getDoctors() async {
    database = DatabaseService(uid: widget.patientId);

    List<DoctorInfo> mappedDoctors = [];

    DocumentSnapshot snapshot =
        await widget.patientDatabaseRef.document(widget.patientId).get();

    await Future.forEach(snapshot.data['doctors'], (doctor) async {
      Doctor currentDoctor = await database.getDoctor(doctor['uid']);

      mappedDoctors.add(DoctorInfo(doctor: currentDoctor));
    });

    setState(() {
      doctors = mappedDoctors;
    });
  }

  @override
  void initState() {
    getDoctors();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(primary: false, children: doctors);
  }
}

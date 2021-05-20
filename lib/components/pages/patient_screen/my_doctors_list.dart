import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/doctor_info.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/services/database.dart';

class MyDoctorsList extends StatefulWidget {
  final CollectionReference patientDatabaseRef;
  final String patientId;
  final Patient currentPatient;

  MyDoctorsList({this.patientDatabaseRef, this.patientId, this.currentPatient});

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

    if (snapshot.data['doctors'] != null) {
      await Future.forEach(snapshot.data['doctors'], (doctor) async {
        Doctor currentDoctor = await database.getDoctor(doctor['uid']);

        mappedDoctors.add(DoctorInfo(
          doctor: currentDoctor,
          currentPatient: widget.currentPatient,
        ));
      });
    }

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
    Widget page = Loading();

    if (doctors.isEmpty) {
      setState(() {
        page = Container(
          alignment: Alignment.center,
          child: Text(
            'No doctors yet',
            style: TextStyle(
              color: Colors.grey[600],
              fontFamily: "ShipporiMincho",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          height: 80,
        );
      });
    } else {
      setState(() {
        page = ListView(
          primary: false,
          children: doctors,
          shrinkWrap: true,
        );
      });
    }
    return page;
  }
}

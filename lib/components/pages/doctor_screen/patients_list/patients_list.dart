import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/doctor_screen/patients_list/patient_info.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/services/database.dart';

class PatientsList extends StatefulWidget {
  final CollectionReference patientDatabaseRef;
  final String doctorId;

  PatientsList({this.patientDatabaseRef, this.doctorId});

  @override
  _PatientsListState createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  List<PatientInfo> patients = [];
  DatabaseService database;

  void getPatients() async {
    // List mappedPatients; // TO DO: implement this once we have finished patient requests to doctor

    // QuerySnapshot snapshots = await widget.patientDatabaseRef
    //     .where('doctorIds', arrayContains: widget.doctorId)
    //     .orderBy('lastName')
    //     .getDocuments();

    // mappedPatients = snapshots.documents.map((document) async {
    //   Patient currentPatient = await database.getPatient(document.documentID);

    //   return PatientInfo(patient: currentPatient);
    // }).toList();

    // setState(() {
    //   patients = mappedPatients;
    // });

    setState(() {
      List<Patient> temPatients = [
        Patient(
            firstName: 'Darla',
            middleInitial: 'A',
            lastName: 'Abagat',
            gender: 'Female',
            birthDate: '01-01-2000',
            address: 'San Jose',
            contactNo: '704230234',
            medicalHistory: [],
            emergencyContact: null,
            bloodPressure: BloodPressure(
                reading: '120/80 mm', lastChecked: DateTime.now()),
            bloodType: 'A+',
            weight: 55),
        Patient(
            firstName: 'Darla',
            middleInitial: 'A',
            lastName: 'Abagat',
            gender: 'Female',
            birthDate: '01-01-2000',
            address: 'San Jose',
            contactNo: '704230234',
            medicalHistory: [],
            emergencyContact: null,
            bloodPressure: BloodPressure(
                reading: '120/80 mm', lastChecked: DateTime.now()),
            bloodType: 'A+',
            weight: 55),
        Patient(
            firstName: 'Darla',
            middleInitial: 'A',
            lastName: 'Abagat',
            gender: 'Female',
            birthDate: '01-01-2000',
            address: 'San Jose',
            contactNo: '704230234',
            medicalHistory: [],
            emergencyContact: null,
            bloodPressure: BloodPressure(
                reading: '120/80 mm', lastChecked: DateTime.now()),
            bloodType: 'A+',
            weight: 55)
      ];

      patients = temPatients.map<PatientInfo>((Patient patient) {
        return PatientInfo(patient: patient);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();

    getPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'My Patients',
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.home_outlined),
            iconSize: 30.0,
          )
        ],
      ),
      body: Container(
        child: ListView(children: patients),
      ),
    );
  }
}

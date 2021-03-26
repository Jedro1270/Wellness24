import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/doctor_info.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/patient.dart';

class SearchedDoctorsList extends StatefulWidget {
  final Patient currentPatient;
  final String searchValue;
  final String filterValue;
  final CollectionReference doctorDatabaseRef;

  SearchedDoctorsList(
      {this.searchValue,
      this.filterValue,
      this.doctorDatabaseRef,
      this.currentPatient});

  @override
  _SearchedDoctorsListState createState() => _SearchedDoctorsListState();
}

class _SearchedDoctorsListState extends State<SearchedDoctorsList> {
  List<DoctorInfo> doctors = [];

  void getDoctors() async {
    var snapshots;

    if (widget.searchValue.trim() == '') {
      snapshots = await widget.doctorDatabaseRef.getDocuments();
    } else {
      snapshots = await widget.doctorDatabaseRef
          .where('keywords', arrayContains: widget.searchValue.toLowerCase())
          .orderBy('lastName')
          .getDocuments();
    }

    final filteredDoctors = snapshots.documents.where((document) {
      if (widget.filterValue == document.data['specialization']) {
        return true;
      }

      return widget.filterValue.toLowerCase() == 'any';
    }).toList();

    setState(() {
      doctors = filteredDoctors.map<DoctorInfo>((document) {
        Doctor currentDoctor = Doctor(
            uid: document.documentID,
            firstName: document.data['firstName'],
            middleInitial: document.data['middleInitial'],
            lastName: document.data['lastName'],
            specialization: document.data['specialization'],
            about: document.data['about'],
            workingDays: document.data['workingDays'],
            clinicStartHour: document.data['clinicStart'],
            clinicEndHour: document.data['clinicEnd'],
            education: document.data['education']);

        return DoctorInfo(
          doctor: currentDoctor,
          currentPatient: widget.currentPatient,
        );
      }).toList();
    });
  }

  @override
  void initState() {
    getDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: doctors);
  }
}

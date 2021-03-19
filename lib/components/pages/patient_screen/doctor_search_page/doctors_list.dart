import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/doctor_info.dart';
import 'package:wellness24/models/doctor.dart';

class DoctorsList extends StatefulWidget {
  final String searchValue;
  final String filterValue;
  final CollectionReference doctorDatabaseRef;

  DoctorsList({this.searchValue, this.filterValue, this.doctorDatabaseRef});

  @override
  DoctorsListState createState() => DoctorsListState();
}

class DoctorsListState extends State<DoctorsList> {
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
      if (widget.filterValue == null) {
        return true;
      }

      return document.data['specialization'].toLowerCase() ==
              widget.filterValue.toLowerCase() ||
          widget.filterValue.toLowerCase() == 'any';
    }).toList();

    setState(() {
      doctors = filteredDoctors.map<DoctorInfo>((document) {
        Doctor currentDoctor = Doctor(
            uid: document.documentId,
            firstName: document.data['firstName'],
            middleInitial: document.data['middleInitial'],
            lastName: document.data['lastName'],
            specialization: document.data['specialization'],
            about: document.data['about'],
            workingDays: document.data['workingDays'],
            clinicStartHour: document.data['clinicStart'],
            clinicEndHour: document.data['clinicEnd']);

        return DoctorInfo(doctor: currentDoctor);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();

    getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: doctors);
  }
}

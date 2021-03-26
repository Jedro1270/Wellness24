import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/searched_doctors_list.dart';
import 'package:wellness24/models/patient.dart';

class DoctorSearchPage extends StatefulWidget {
  final Patient currentPatient;
  final String searchValue;
  final String filterValue;
  final CollectionReference doctorDatabaseRef;

  DoctorSearchPage(
      {this.searchValue,
      this.filterValue,
      this.doctorDatabaseRef,
      this.currentPatient});

  @override
  _DoctorSearchPageState createState() => _DoctorSearchPageState();
}

class _DoctorSearchPageState extends State<DoctorSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Registered Doctors',
       
      ),
      body: Container(
          child: SearchedDoctorsList(
              currentPatient: widget.currentPatient,
              searchValue: widget.searchValue,
              filterValue: widget.filterValue,
              doctorDatabaseRef: widget.doctorDatabaseRef)),
    );
  }
}

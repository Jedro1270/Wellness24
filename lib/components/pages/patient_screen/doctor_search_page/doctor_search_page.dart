import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/doctors_list.dart';

class DoctorSearchPage extends StatefulWidget {
  final String searchValue;
  final String filterValue;
  final CollectionReference doctorDatabaseRef;

  DoctorSearchPage({this.searchValue, this.filterValue, this.doctorDatabaseRef});

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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.home_outlined),
            iconSize: 30.0,
          )
        ],
      ),
      body: Container(
          child: DoctorsList(
              searchValue: widget.searchValue,
              filterValue: widget.filterValue,
              doctorDatabaseRef: widget.doctorDatabaseRef)),
    );
  }
}
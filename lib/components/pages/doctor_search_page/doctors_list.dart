import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/doctor_search_page/doctor_info.dart';
import 'package:wellness24/services/database.dart';

class DoctorsList extends StatefulWidget {
  String searchValue;
  List<Widget> doctors = [];

  DoctorsList({this.searchValue});

  @override
  DoctorsListState createState() => DoctorsListState();
}

class DoctorsListState extends State<DoctorsList> {
  @override
  Widget build(BuildContext context) {
    void getDoctors() async {
      DatabaseService database = DatabaseService();

      var snapshots = await database.doctors
          .where('keywords', arrayContains: widget.searchValue.toLowerCase())
          .orderBy('lastName')
          .getDocuments();

      setState(() {
        widget.doctors = snapshots.documents.map((document) {
          print(document.data['firstName']);
          return DoctorInfo(
            firstName: document.data['firstName'],
            middleInitial: document.data['middleInitial'],
            lastName: document.data['lastName'],
          );
        }).toList();
      });
    }

    getDoctors();

    return ListView(children: widget.doctors);
  }
}

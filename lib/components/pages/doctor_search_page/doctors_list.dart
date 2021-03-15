import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/doctor_search_page/doctor_info.dart';
import 'package:wellness24/services/database.dart';

class DoctorsList extends StatefulWidget {
  final String searchValue;
  final String filterValue;

  DoctorsList({this.searchValue, this.filterValue});

  @override
  DoctorsListState createState() => DoctorsListState();
}

class DoctorsListState extends State<DoctorsList> {
  List<DoctorInfo> doctors = [];

  void getDoctors() async {
    DatabaseService database = DatabaseService();
    var snapshots;

    if (widget.searchValue.trim() == '') {
      snapshots = await database.doctors.getDocuments();
    } else {
      snapshots = await database.doctors
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
        print(document.data['firstName']);
        return DoctorInfo(
            firstName: document.data['firstName'],
            middleInitial: document.data['middleInitial'],
            lastName: document.data['lastName'],
            specialization: document.data['specialization'],
            clinicHours:
                "${document.data['clinicStart']} to ${document.data['clinicEnd']}");
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

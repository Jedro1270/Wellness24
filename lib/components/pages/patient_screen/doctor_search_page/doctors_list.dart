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
            firstName: document.data['firstName'],
            middleInitial: document.data['middleInitial'],
            lastName: document.data['lastName'],
            specialization: document.data['specialization'],
            about:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris tempor tellus sed sollicitudin egestas. Integer dignissim aliquet arcu ac venenatis. Suspendisse posuere dui sed ex finibus pharetra. Suspendisse eu orci lacus. Suspendisse a felis tempus, feugiat nibh vitae, tincidunt lorem. Vestibulum consectetur est dolor, a vestibulum urna lobortis ut. Morbi et orci eget ante feugiat posuere. Morbi finibus dolor metus, congue semper urna dapibus ut. Vivamus sit amet sollicitudin massa. Sed et risus eu turpis consequat aliquam. Donec sed quam nec arcu mattis porta sit amet et leo. Suspendisse fringilla tortor non mauris facilisis fringilla. Pellentesque eu arcu interdum, sagittis leo nec, egestas augue. Donec sit amet erat diam. Fusce ultricies, nunc ut mollis mattis, sapien est posuere mi, luctus facilisis velit nibh eget nisi. Ut ullamcorper turpis quis blandit pretium.', // TO DO: replace
            workingDays: 'Monday - Friday', // TO DO: replace
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

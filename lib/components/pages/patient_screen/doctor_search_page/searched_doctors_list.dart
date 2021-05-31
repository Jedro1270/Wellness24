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
      this.currentPatient,
      Key key})
      : super(key: key);

  @override
  _SearchedDoctorsListState createState() => _SearchedDoctorsListState();
}

class _SearchedDoctorsListState extends State<SearchedDoctorsList> {
  List<DoctorInfo> doctors = [];

  ScrollController _scrollController = ScrollController();
  Widget loadMore = Container();
  int doctorsLimit = 3;
  bool screenInitialized = false;

  void getDoctors() async {
    QuerySnapshot snapshots;

    if (widget.searchValue.trim() == '') {
      snapshots =
          await widget.doctorDatabaseRef.limit(doctorsLimit).getDocuments();
    } else {
      snapshots = await widget.doctorDatabaseRef
          .where('keywords', arrayContains: widget.searchValue.toLowerCase())
          .orderBy('lastName')
          .limit(doctorsLimit)
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
        Doctor currentDoctor =
            Doctor.fromJson(document.data, document.documentID);

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

    _scrollController.addListener(() {
      double currentScroll = _scrollController.position.pixels;

      if (currentScroll == 0) {
        setState(() {
          loadMore = InkWell(
            onTap: () {
              setState(() {
                doctorsLimit += 3;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Load More'),
            ),
          );
        });
      } else {
        setState(() {
          loadMore = Container();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //return ListView(children: doctors, controller: _scrollController,);
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: doctors.isNotEmpty
                  ? doctors
                  : [
                      Container(
                          margin: EdgeInsets.all(30),
                          child: Text(
                            'No Search Results. Please try a different keyword.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'ShipporiMincho',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
            ),
          ),
          loadMore
        ],
      ),
    );
  }
}

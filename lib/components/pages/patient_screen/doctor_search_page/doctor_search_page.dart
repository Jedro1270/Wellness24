import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_search_page/searched_doctors_list.dart';
import 'package:wellness24/models/patient.dart';

class DoctorSearchPage extends StatefulWidget {
  final Patient currentPatient;
  final CollectionReference doctorDatabaseRef;

  DoctorSearchPage({this.doctorDatabaseRef, this.currentPatient});

  @override
  _DoctorSearchPageState createState() => _DoctorSearchPageState();
}

class _DoctorSearchPageState extends State<DoctorSearchPage> {
  String searchValue = '';
  String temporarySearchValue = '';
  String filterValue = 'Any';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Registered Doctors',
      ),
      body: Container(
          child: Column(
        children: [
          Center(
            child: SizedBox(
              child: DropdownButton<String>(
                value: filterValue,
                icon: const Icon(Icons.filter_alt_sharp),
                iconSize: 24,
                elevation: 16,
                onChanged: (String newValue) {
                  setState(() {
                    filterValue = newValue;
                  });
                },
                items: <String>[
                  'Any',
                  'Family Physician',
                  'Internal Medicine Physician',
                  'Pediatrician',
                  'Obstetrician/Gynecologist (OB/GYN)',
                  'Surgeon',
                  'Psychiatrist',
                  'Cardiologist',
                  'Dermatologist',
                  'Endocrinologist',
                  'Gastroenterologist',
                  'Infectious Disease Physician',
                  'Ophthalmologist',
                  'Otolaryngologist',
                  'Pulmonologist',
                  'Nephrologist',
                  'Oncologist',
                  'General Medicine',
                  'Neurologist',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      color: Color(0xffF2F2F2),
                      borderRadius: BorderRadius.circular(30)),
                  child: TextField(
                    onChanged: (val) =>
                        temporarySearchValue = val,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search for doctors'),
                  ),
                ),
                Align(
                  key: Key('searchBtn'),
                  alignment: Alignment.centerRight,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        searchValue = temporarySearchValue;
                      });
                    },
                    color: Colors.lightBlue,
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Icon(
                      Icons.search,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SearchedDoctorsList(
                key: UniqueKey(),
                currentPatient: widget.currentPatient,
                searchValue: searchValue,
                filterValue: filterValue,
                doctorDatabaseRef: widget.doctorDatabaseRef),
          ),
        ],
      )),
    );
  }
}

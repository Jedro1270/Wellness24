import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/common_pages/patient_profile/patient_profile.dart';
import 'package:wellness24/components/pages/patient_screen/emergency_page.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_details.dart';
import 'package:wellness24/components/pages/patient_screen/patient_schedule_page.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';
import 'package:wellness24/components/common/navigation_bar.dart';

import './doctor_search_page/doctor_search_page.dart';

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  String searchValue = '';
  String filterValue = 'Any';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final currentPatient = Provider.of<Patient>(context);
    print(currentPatient.fullName);

    return Scaffold(
      drawer: NavBar(),
      appBar: CustomAppBar(
        title: 'Home Page',
        actions: [
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                print('Notif button clicked');
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          print("Message Icon click");
        },
      ),
      body: Container(
        child: ListView(
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
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 20),
              child: SizedBox(
                width: 250,
                child: TextField(
                  onChanged: (val) => setState(() => searchValue = val),
                  decoration: InputDecoration(
                    // labelText: 'Search Doctor',
                    hintText: 'Search Doctor',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctorSearchPage(
                                      searchValue: searchValue,
                                      filterValue: filterValue,
                                      doctorDatabaseRef:
                                          DatabaseService().doctors,
                                    )));
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text("EMERGENCY",
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    onPressed: () {
                      print("EMERGENCY");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmergencyPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      primary: Colors.redAccent[700],
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 50, color: Colors.transparent),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text("My Doctors",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    onPressed: () {
                      print("My Doctors");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorDetails()));
                    },
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 117, vertical: 20),
                        primary: Colors.lightBlueAccent[100]),
                  )
                ],
              ),
            ),
            Divider(height: 20, color: Colors.transparent),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text("My Current Conditions",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    onPressed: () {
                      print("My Current Conditions");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientProfile(
                                    editable: true,
                                    // patient: currentPatient,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                        primary: Colors.lightBlueAccent[100]),
                  )
                ],
              ),
            ),
            Divider(height: 20, color: Colors.transparent),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text("Schedule Appointment",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    onPressed: () {
                      print("Schedule Appointment");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientAppointmentPage()));
                    },
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 68, vertical: 20),
                        primary: Colors.lightBlueAccent[100]),
                  )
                ],
              ),
            ),
            Divider(height: 20, color: Colors.transparent),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text("My Medical Records",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    onPressed: () {
                      print("My Medical Records");
                    },
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                        primary: Colors.lightBlueAccent[100]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

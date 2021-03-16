import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/patient_screen/emergency_page.dart';
import 'package:wellness24/components/pages/doctor_screen/doctor_info_page.dart';
import 'package:wellness24/components/pages/patient_screen/patient_schedule_page.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/models/user.dart';

import '../doctor_search_page/doctor_search_page.dart';

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
    print(user.uid);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home Page',
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              print('menu button pressed');
            }),
        actions: [
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                print("Clicked Notif icon");
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
                    'General Medicine',
                    'Neurologist',
                    'Psychiatrist',
                    'Pediatrician'
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
                                    filterValue: filterValue)));
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
                    child: Text("Doctor's Info",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    onPressed: () {
                      print("Doctor's info");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorDetail()));
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

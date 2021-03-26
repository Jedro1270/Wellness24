import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/common/schedule_card.dart';
import 'package:wellness24/components/pages/common_pages/chat/messages.dart';
import 'package:wellness24/components/pages/common_pages/patient_profile/patient_profile.dart';
import 'package:wellness24/components/pages/patient_screen/messages_patient.dart';
import 'package:wellness24/components/pages/patient_screen/emergency_page.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/pages/patient_screen/my_doctors_list.dart';
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
  Patient currentPatient;

  initializePatient(String uid) async {
    DatabaseService database = DatabaseService();
    Patient patient = await database.getPatient(uid);

    setState(() {
      currentPatient = patient;
    });
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context);
    // Patient currentPatient = Provider.of<Patient>(context);

    initializePatient(currentUser.uid);

    return Scaffold(
      drawer: NavBar(
          name: currentPatient == null ? '' : currentPatient.fullName,
          email: currentUser.email),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => PatientMessages()));
        },
      ),
      body: currentPatient == null
          ? Loading()
          : Container(
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Find Your Desired\nDoctor',
                      style: TextStyle(
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
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
                                setState(() => searchValue = val),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search for doctors'),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DoctorSearchPage(
                                            currentPatient: currentPatient,
                                            searchValue: searchValue,
                                            filterValue: filterValue,
                                            doctorDatabaseRef:
                                                DatabaseService().doctors,
                                          )));
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
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            child: Text("EMERGENCY",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: "ShipporiMincho",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EmergencyPage(patient: currentPatient)));
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 90, vertical: 20),
                              primary: Colors.redAccent[700],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'My Doctors',
                      style: TextStyle(
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: MyDoctorsList(
                        patientDatabaseRef:
                            DatabaseService(uid: currentUser.uid).patients,
                        patientId: currentUser.uid),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'My Appointments',
                      style: TextStyle(
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  buildAppointmentList(),
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
                                          patient: currentPatient,
                                        )));
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 20),
                              primary: Colors.lightBlueAccent[100]),
                        )
                      ],
                    ),
                  ),
                  Divider(height: 20, color: Colors.transparent),
                ],
              ),
            ),
    );
  }
}

buildAppointmentList() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30),
    child: Column(
      children: <Widget>[
        ScheduleCard('12', 'Jan', 'Consultation', 'Sunday 9am - 11am'),
        SizedBox(height: 20),
        ScheduleCard('15', 'Oct', 'Consultation', 'Monday 1pm - 3pm')
      ],
    ),
  );
}

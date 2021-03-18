import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/common_pages/patient_profile/patient_condition.dart';
import 'package:wellness24/models/patient.dart';

class PatientProfile extends StatefulWidget {
  final bool editable;
  final Patient patient;

  PatientProfile({this.editable, this.patient});

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Patient',
        actions: [
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                print("Clicked Notif icon");
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.patient.fullName,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'ShipporiMincho',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.patient.gender,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'ShipporiMincho',
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 150.0,
                    width: 300.0,
                    child: Image(
                      image: AssetImage('assets/sample-patient.jpg'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(
              color: Colors.black,
            ),
            SizedBox(height: 10),
            PatientCondition(
                editable: true,
                icon: Image(image: AssetImage('assets/weight.png')),
                content: '${widget.patient.weight.toString()} kg',
                title: 'Weight'),
            PatientCondition(
                editable: true,
                icon: Image(image: AssetImage('assets/droplet.png')),
                content: widget.patient.bloodType,
                title: 'Blood Type'),
            PatientCondition(
                editable: true,
                icon: Image(image: AssetImage('assets/double-person.png')),
                content: '${widget.patient.age} y.o',
                title: 'Age'),
            PatientCondition(
                editable: true,
                icon: Icon(
                  Icons.cake_outlined,
                  size: 30,
                ),
                content: widget.patient.birthDate,
                title: 'Birthday'),
            Divider(color: Colors.black),
            SizedBox(height: 10),
            Container(
              child: Row(
                children: <Widget>[
                  Text('Blood Pressure:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'ShipporiMincho')),
                  SizedBox(width: 20),
                  Text(
                    widget.patient.bloodPressure.reading,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        fontFamily: 'ShipporiMincho'),
                  ),
                  SizedBox(
                    height: 20,
                    width: 80,
                    child: Container(
                        color: Colors.redAccent[700],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.patient.bloodPressure.sinceLastChecked,
                              style: TextStyle(fontFamily: 'ShipporiMincho'),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.black),
            SizedBox(height: 10),
            Container(
              child: Row(
                children: <Widget>[
                  Text('History',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'ShipporiMincho')),
                  SizedBox(width: 230),
                  Container(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                            height: 50,
                            width: 50,
                            child: Image(
                              image: AssetImage('assets/dots.png'),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

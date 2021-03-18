import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
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
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage('assets/weight.png'),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.patient.weight.toString(),
                          style: TextStyle(
                              fontFamily: 'ShipporiMincho',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Weight',
                          style: TextStyle(
                            fontFamily: 'ShipporiMincho',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage('assets/droplet.png'),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.patient.bloodType,
                          style: TextStyle(
                              fontFamily: 'ShipporiMincho',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Blood Type',
                          style: TextStyle(
                            fontFamily: 'ShipporiMincho',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage('assets/double-person.png'),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${widget.patient.age} y.o',
                          style: TextStyle(
                              fontFamily: 'ShipporiMincho',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Age',
                          style: TextStyle(
                            fontFamily: 'ShipporiMincho',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: Icon(
                        Icons.cake_outlined,
                        size: 30,
                      )),
                  SizedBox(width: 10.0),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.patient.birthDate,
                          style: TextStyle(
                              fontFamily: 'ShipporiMincho',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Birth Date',
                          style: TextStyle(
                            fontFamily: 'ShipporiMincho',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/pages/common_pages/patient_profile/patient_condition.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/blood_sugar_level.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';

class PatientProfile extends StatefulWidget {
  final bool editable;
  final Patient patient;

  PatientProfile({this.editable, this.patient});

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  TextEditingController bloodPressureController;
  TextEditingController bloodSugarController;
  bool editingBloodPressure = false;
  bool edititngBloodSugarLevel = false;
  BloodPressure newBloodPressure;
  BloodSugarLevel newBloodSugarLevel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    if (widget.patient != null) {
      newBloodPressure = widget.patient.bloodPressure;
      newBloodSugarLevel = widget.patient.bloodSugarLevel;

      if (widget.patient.bloodPressure != null) {
        bloodPressureController =
            TextEditingController(text: widget.patient.bloodPressure.reading);
      }

      if (widget.patient.bloodSugarLevel != null) {
        bloodSugarController =
            TextEditingController(text: widget.patient.bloodSugarLevel.reading);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final DatabaseService database = DatabaseService(uid: user.uid);

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
      body: widget.patient == null
          ? Loading()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: Image(
                            image: AssetImage(
                                'assets/sample-patient.jpg'), // _imageUrl
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(height: 20),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(height: 10),
                  PatientCondition(
                    editable: widget.editable,
                    icon: Image(image: AssetImage('assets/weight.png')),
                    content: widget.patient.bodyTemperature.toString(),
                    title: 'Body Temperature',
                    onChanged: (newContent) async {
                      widget.patient.bodyTemperature = double.parse(newContent);
                      await database.updatePatient(widget.patient);
                    },
                  ),
                  PatientCondition(
                    editable: widget.editable,
                    icon: Image(image: AssetImage('assets/weight.png')),
                    content: widget.patient.weight.toString(),
                    title: 'Weight',
                    onChanged: (newContent) async {
                      widget.patient.weight = double.parse(newContent);
                      await database.updatePatient(widget.patient);
                    },
                  ),
                  PatientCondition(
                    editable: widget.editable,
                    icon: Image(image: AssetImage('assets/weight.png')),
                    content: widget.patient.height.toString(),
                    title: 'Height',
                    onChanged: (newContent) async {
                      widget.patient.height = double.parse(newContent);
                      await database.updatePatient(widget.patient);
                    },
                  ),
                  PatientCondition(
                      editable: widget.editable,
                      icon: Image(image: AssetImage('assets/droplet.png')),
                      content: widget.patient.bloodType,
                      title: 'Blood Type',
                      onChanged: (newContent) async {
                        widget.patient.bloodType = newContent;
                        await database.updatePatient(widget.patient);
                      }),
                  PatientCondition(
                      editable: false,
                      icon:
                          Image(image: AssetImage('assets/double-person.png')),
                      content: '${widget.patient.age} y.o',
                      title: 'Age'),
                  PatientCondition(
                      editable: widget.editable,
                      icon: Icon(
                        Icons.cake_outlined,
                        size: 30,
                      ),
                      content:
                          DateFormat.yMd().format(widget.patient.birthDate),
                      title: 'Birthday',
                      onChanged: (newContent) async {
                        widget.patient.birthDate = newContent;
                        await database.updatePatient(widget.patient);
                      }),
                  Divider(color: Colors.black),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      setState(() {
                        editingBloodPressure = true;
                      });
                    },
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text('Blood Pressure:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: 'ShipporiMincho')),
                          SizedBox(width: 20),
                          editingBloodPressure && widget.editable
                              ? SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: TextField(
                                    onSubmitted: (newValue) {
                                      setState(() {
                                        newBloodPressure = BloodPressure(
                                            reading: newValue,
                                            lastChecked: DateTime.now());
                                        editingBloodPressure = false;
                                        widget.patient.bloodPressure =
                                            newBloodPressure;
                                        database.updatePatient(widget.patient);
                                      });
                                    },
                                    autofocus: true,
                                    controller: bloodPressureController,
                                  ),
                                )
                              : Text(
                                  newBloodPressure == null
                                      ? ''
                                      : newBloodPressure.reading,
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
                                      widget.patient.bloodPressure == null
                                          ? 'NA'
                                          : widget.patient.bloodPressure
                                              .sinceLastChecked,
                                      style: TextStyle(
                                          fontFamily: 'ShipporiMincho',
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 40, color: Colors.black),
                  InkWell(
                    onTap: () {
                      setState(() {
                        edititngBloodSugarLevel = true;
                      });
                    },
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text('Blood Sugar Level:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: 'ShipporiMincho')),
                          SizedBox(width: 20),
                          edititngBloodSugarLevel && widget.editable
                              ? SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: TextField(
                                    onSubmitted: (newValue) {
                                      setState(() {
                                        newBloodSugarLevel = BloodSugarLevel(
                                            reading: newValue,
                                            lastChecked: DateTime.now());
                                        edititngBloodSugarLevel = false;
                                        widget.patient.bloodSugarLevel =
                                            newBloodSugarLevel;
                                        database.updatePatient(widget.patient);
                                      });
                                    },
                                    autofocus: true,
                                    controller: bloodSugarController,
                                  ),
                                )
                              : Text(
                                  newBloodSugarLevel == null
                                      ? ''
                                      : newBloodSugarLevel.reading,
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
                                      widget.patient.bloodSugarLevel == null
                                          ? 'NA'
                                          : widget.patient.bloodSugarLevel
                                              .sinceLastChecked,
                                      style: TextStyle(
                                          fontFamily: 'ShipporiMincho',
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

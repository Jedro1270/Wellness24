import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/pages/common_pages/medical_records/medical_records.dart';
import 'package:wellness24/components/pages/common_pages/patient_profile/patient_condition.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/blood_sugar_level.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/services/database.dart';

class PatientProfile extends StatefulWidget {
  final bool editable;
  final Patient patient;
  final DatabaseService database;

  PatientProfile({this.editable, this.patient, this.database});

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  TextEditingController bloodPressureController;
  TextEditingController bloodSugarController;
  bool editingBloodPressure = false;
  bool editingBloodSugarLevel = false;
  BloodPressure newBloodPressure;
  BloodSugarLevel newBloodSugarLevel;

  PickedFile _imageFile;
  final ImagePicker _imagePicker = ImagePicker();
  String imagePath;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    //loadImage();

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
    bool loading = false;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Patient Conditions',
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
                  Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: Icon(Icons.more_vert),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: ((builder) => optionView()));
                        },
                      )),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: Image(
                            image: _imageFile == null
                                ? AssetImage('assets/sample-patient.jpg')
                                : FileImage(File(_imageFile.path)),
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
                    key: Key('bodyTemp'),
                    editable: widget.editable,
                    loading: loading,
                    icon: Image(image: AssetImage('assets/body-temp.png')),
                    content: widget.patient.bodyTemperature.toString(),
                    title: 'Body Temperature',
                    unit: 'celsius',
                    inputFormat: "[0-9.]",
                    onChanged: (newContent) async {
                      setState(() {
                        loading = true;
                        widget.patient.bodyTemperature =
                            double.parse(newContent);
                      });

                      await widget.database.updatePatient(widget.patient);

                      setState(() {
                        loading = false;
                      });
                    },
                  ),
                  PatientCondition(
                    key: Key('weight'),
                    editable: widget.editable,
                    loading: loading,
                    icon: Image(image: AssetImage('assets/weight.png')),
                    content: widget.patient.weight.toString(),
                    title: 'Weight',
                    unit: 'kg',
                    inputFormat: "[0-9.]",
                    onChanged: (newContent) async {
                      setState(() {
                        loading = true;
                        widget.patient.weight = double.parse(newContent);
                      });

                      await widget.database.updatePatient(widget.patient);

                      setState(() {
                        loading = false;
                      });
                    },
                  ),
                  PatientCondition(
                    key: Key('height'),
                    editable: widget.editable,
                    loading: loading,
                    icon: Image(image: AssetImage('assets/height.png')),
                    content: widget.patient.height.toString(),
                    title: 'Height',
                    unit: 'cm',
                    inputFormat: "[0-9.]",
                    onChanged: (newContent) async {
                      setState(() {
                        loading = true;
                        widget.patient.height = double.parse(newContent);
                      });

                      await widget.database.updatePatient(widget.patient);

                      setState(() {
                        loading = false;
                      });
                    },
                  ),
                  PatientCondition(
                      editable: widget.editable,
                      loading: loading,
                      icon: Image(image: AssetImage('assets/droplet.png')),
                      content: widget.patient.bloodType,
                      title: 'Blood Type',
                      unit: '',
                      inputFormat: "[A,O,B,a,b,o,+,-]",
                      onChanged: (newContent) async {
                        setState(() {
                          loading = true;
                          widget.patient.bloodType = newContent;
                        });

                        await widget.database.updatePatient(widget.patient);

                        setState(() {
                          loading = false;
                        });
                      }),
                  PatientCondition(
                      editable: false,
                      loading: loading,
                      icon:
                          Image(image: AssetImage('assets/double-person.png')),
                      content: '${widget.patient.age} ',
                      unit: 'y.o',
                      title: 'Age'),
                  PatientCondition(
                      editable: false,
                      loading: loading,
                      unit: '',
                      inputFormat: "[0-9.]",
                      icon: Icon(
                        Icons.cake_outlined,
                        size: 30,
                      ),
                      content:
                          DateFormat.yMd().format(widget.patient.birthDate),
                      title: 'Birthday'),
                  Divider(color: Colors.black),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      setState(() {
                        editingBloodPressure = true;
                      });
                    },
                    child: Container(
                      height: 120,
                      child: Column(
                        children: <Widget>[
                          Text('Blood Pressure:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'ShipporiMincho',
                              )),
                          SizedBox(width: 20),
                          editingBloodPressure && widget.editable
                              ? SizedBox(
                                  height: 40,
                                  width: 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: TextField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9/]'))
                                      ],
                                      onSubmitted: (newValue) {
                                        setState(() {
                                          newBloodPressure = BloodPressure(
                                              reading: newValue,
                                              lastChecked: DateTime.now());
                                          editingBloodPressure = false;
                                          widget.patient.bloodPressure =
                                              newBloodPressure;
                                          widget.database
                                              .updatePatient(widget.patient);
                                        });
                                      },
                                      autofocus: true,
                                      controller: bloodPressureController,
                                    ),
                                  ),
                                )
                              : RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: newBloodPressure == null
                                            ? ''
                                            : newBloodPressure.reading,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                            fontFamily: 'ShipporiMincho'),
                                      ),
                                      TextSpan(
                                        text: ' mmHg',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                            fontFamily: 'ShipporiMincho'),
                                      ),
                                      WidgetSpan(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Icon(Icons.edit_outlined),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 30,
                            width: 120,
                            child: widget.patient.bloodPressure == null
                                ? Container()
                                : Container(
                                    color: Colors.redAccent[700],
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          widget.patient.bloodPressure
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
                        editingBloodSugarLevel = true;
                      });
                    },
                    child: Container(
                      height: 120,
                      child: Column(
                        children: <Widget>[
                          Text('Blood Sugar Level:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: 'ShipporiMincho')),
                          SizedBox(width: 20),
                          editingBloodSugarLevel && widget.editable
                              ? SizedBox(
                                  height: 40,
                                  width: 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: TextField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onSubmitted: (newValue) {
                                        setState(() {
                                          newBloodSugarLevel = BloodSugarLevel(
                                              reading: newValue,
                                              lastChecked: DateTime.now());
                                          editingBloodSugarLevel = false;
                                          widget.patient.bloodSugarLevel =
                                              newBloodSugarLevel;
                                          widget.database
                                              .updatePatient(widget.patient);
                                        });
                                      },
                                      autofocus: true,
                                      controller: bloodSugarController,
                                    ),
                                  ),
                                )
                              : RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: newBloodSugarLevel == null
                                            ? ''
                                            : newBloodSugarLevel.reading,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                            fontFamily: 'ShipporiMincho'),
                                      ),
                                      TextSpan(
                                        text: ' mmol/L',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                            fontFamily: 'ShipporiMincho'),
                                      ),
                                      WidgetSpan(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Icon(Icons.edit_outlined),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 30,
                            width: 120,
                            child: widget.patient.bloodSugarLevel == null
                                ? Container()
                                : Container(
                                    color: Colors.redAccent[700],
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          widget.patient.bloodSugarLevel
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
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          key: Key('medicalRecordsBtn'),
                          child: Text("Medical Records",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "ShipporiMincho",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MedicalRecords(
                                          patient: widget.patient,
                                          role: widget.editable
                                              ? 'Patient'
                                              : 'Doctor',
                                        )));
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 20),
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

  Widget optionView() {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 200,
      child: Column(children: [
        Text(
          'Choose your Profile',
          style: TextStyle(
            fontFamily: "ShipporiMincho",
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
        Divider(height: 40, color: Colors.transparent),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                onPressed: () {
                  print('open camera');
                  updatePhoto(ImageSource.camera);
                },
                child: Column(
                  children: [
                    Icon(Icons.camera_alt_sharp),
                    Text('Camera',
                        style: TextStyle(
                          fontFamily: "ShipporiMincho",
                          fontSize: 18,
                        )),
                  ],
                )),
            SizedBox(width: 50),
            MaterialButton(
                onPressed: () {
                  print('open gallery');
                  updatePhoto(ImageSource.gallery);
                },
                child: Column(
                  children: [
                    Icon(Icons.image),
                    Text('Gallery',
                        style: TextStyle(
                          fontFamily: "ShipporiMincho",
                          fontSize: 18,
                        )),
                  ],
                )),
          ],
        ),
        Divider(height: 25, color: Colors.transparent),
        MaterialButton(
          onPressed: () {
            print('Save Photo');
            uploadPhoto(this.context);
          },
          child: Text('Save Photo', style: TextStyle()),
          color: Colors.blueAccent[400],
          textColor: Colors.black,
        )
      ]),
    );
  }

  void updatePhoto(ImageSource source) async {
    final pickedFile = await _imagePicker.getImage(source: source);

    setState(() {
      _imageFile = pickedFile;
      print(_imageFile.path);
    });
  }

  void uploadPhoto(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);

    //converts pickedFile to file
    File convertedFile = File(_imageFile.path);

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(convertedFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    setState(() {
      print("Profile Picture Uploaded");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Profile Picture Uploaded'),
      ));
    });
  }
}

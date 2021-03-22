import 'package:flutter/material.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/pages/patient_screen/patient_home_page.dart';
import 'package:wellness24/models/new_account.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';

class MedicalHistory extends StatefulWidget {
  final NewAccount account;
  MedicalHistory(this.account);
  @override
  _MedicalHistoryState createState() => _MedicalHistoryState(this.account);
}

class _MedicalHistoryState extends State<MedicalHistory> {
  final medicalList = [
    MedicalHistoryList(title: "Anemia"),
    MedicalHistoryList(title: "Asthma"),
    MedicalHistoryList(title: "Diabetes"),
    MedicalHistoryList(title: "Hypertension"),
    MedicalHistoryList(title: "Alergic Rhintis"),
    MedicalHistoryList(title: "Obesity")
  ];

  final NewAccount account;
  bool loading = false;
  String additional;

  _MedicalHistoryState(this.account);

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 35.0, horizontal: 25.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 25,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Medical History",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "ShipporiMincho",
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.black),
                  SizedBox(height: 20),
                  ...medicalList
                      .map((item) => Container(
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  item.value = !item.value;
                                });
                              },
                              leading: Checkbox(
                                value: item.value,
                                activeColor: Colors.blueAccent,
                                onChanged: (value) {
                                  setState(() {
                                    item.value = item.value;
                                  });
                                },
                              ),
                              title: Text(item.title,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "ShipporiMincho",
                                      fontWeight: FontWeight.normal)),
                              minVerticalPadding: 2,
                            ),
                          ))
                      .toList(),
                  SizedBox(height: 15.0),
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text('Other/s ',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "ShipporiMincho",
                                fontWeight: FontWeight.normal)),
                        Icon(Icons.add_box),
                      ])
                    ],
                  )),
                  Divider(height: 10),
                  SizedBox(
                      height: 50.0,
                      width: 30.0,
                      child: TextFormField(
                          obscureText: false,
                          onChanged: (val) =>
                              setState(() => additional = val))),
                  SizedBox(height: 10.0),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 55.0,
                          width: 150.0,
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(color: Colors.black12)),
                              color: Colors.grey.withOpacity(0.5),
                              // minWidth: 100,
                              // padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              onPressed: () async {
                                List patientMedHistory = medicalList
                                    .where((c) => c.value == true)
                                    .map((e) => e.title)
                                    .toList();

                                if (additional.isNotEmpty) {
                                  patientMedHistory.add(additional);
                                }

                                print(patientMedHistory.toString());

                                setState(() {
                                  loading = true;
                                });

                                User patient = await account
                                    .registerPatient(patientMedHistory);

                                final database =
                                    DatabaseService(uid: patient.uid);

                                await database.insertPatient(account);

                                if (patient == null) {
                                  setState(() {
                                    // error = 'Invalid credentials'; // TO DO: add error message
                                    loading = false;
                                  });
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PatientHomePage()));
                                }
                              },
                              child: Text("Submit",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 25,
                                      fontFamily: "ShipporiMincho",
                                      fontWeight: FontWeight.normal))),
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

class MedicalHistoryList {
  String title;
  bool value;

  MedicalHistoryList({
    @required this.title,
    this.value = false,
  });
}

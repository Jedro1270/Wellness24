import 'package:flutter/material.dart';
import 'package:wellness24/components/auth/auth_wrapper.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/common/restart_widget.dart';
import 'package:wellness24/components/pages/common_pages/login_page.dart';
import 'package:wellness24/components/pages/patient_screen/medical_histories/medical_history_tile.dart';
import 'package:wellness24/models/medical_history_entry.dart';
import 'package:wellness24/models/new_account.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/auth_service.dart';
import 'package:wellness24/services/database.dart';

class MedicalHistory extends StatefulWidget {
  final NewAccount account;
  MedicalHistory(this.account);
  @override
  _MedicalHistoryState createState() => _MedicalHistoryState(this.account);
}

class _MedicalHistoryState extends State<MedicalHistory> {
  final medicalList = [
    MedicalHistoryEntry(title: "Anemia"),
    MedicalHistoryEntry(title: "Asthma"),
    MedicalHistoryEntry(title: "Diabetes"),
    MedicalHistoryEntry(title: "Hypertension"),
    MedicalHistoryEntry(title: "Alergic Rhintis"),
    MedicalHistoryEntry(title: "Obesity")
  ];

  final NewAccount account;
  bool loading = false;
  String additional = '';

  String error = '';
  bool timeout = false;

  _MedicalHistoryState(this.account);

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: CustomAppBar(
              title: ('Register Medical Records'),
            ),
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
                            "Health History",
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
                      .map((item) => MedicalHistoryTile(
                            onTap: () {
                              setState(() {
                                item.value = !item.value;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                item.value = value;
                              });
                            },
                            medicalHistoryEntry: item,
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
                        InkWell(
                            key: Key('addBtn'),
                            onTap: () {
                              setState(() {
                                if (additional.length > 1) {
                                  medicalList.add(
                                      MedicalHistoryEntry(title: additional));
                                  additional = '';
                                }
                              });
                            },
                            child: Icon(Icons.add_box)),
                      ])
                    ],
                  )),
                  Divider(height: 10),
                  SizedBox(
                      height: 50.0,
                      width: 30.0,
                      child: TextFormField(
                          key: Key('otherField'),
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
                              key: Key('register'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(color: Colors.black12)),
                              color: Colors.grey.withOpacity(0.5),
                              onPressed: () {
                                _showDialog(context);
                              },
                              child: Text("Register",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 25,
                                      fontFamily: "ShipporiMincho",
                                      fontWeight: FontWeight.normal))),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    error,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          );
  }

  _showDialog(BuildContext parentContext) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Do You Consent to Share Your Medical Information?'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      'By using this app, you agree to share your medical information.',
                    ),
                    Text(
                      '\nOnly doctors you give consent to can access, append and edit your medical information.',
                    ),
                    Text('\nWould you like to continue?'),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('CANCEL'),
                ),
                ElevatedButton(
                  key: Key('elevatedYes'),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    Navigator.pop(context);

                    List<String> patientMedHistory = medicalList
                        .where((c) => c.value == true)
                        .map((e) => e.title)
                        .toList();

                    User patient = await account
                        .registerPatient(patientMedHistory)
                        .timeout(Duration(seconds: 120), onTimeout: () {
                      timeout = true;
                      return null;
                    });

                    if (patient == null) {
                      setState(() {
                        if (timeout) {
                          error =
                              'The connection has timed out, please try again';
                          timeout = false;
                        } else {
                          error = 'Email is already taken';
                        }
                        loading = false;
                      });
                    } else {
                      AuthService().signOut();
                      Navigator.push(parentContext,
                          MaterialPageRoute(builder: (context) => Login()));
                    }
                  },
                  child: Text('CONSENT'),
                ),
              ],
            ));
  }
}

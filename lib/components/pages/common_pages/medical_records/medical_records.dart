import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/common_pages/medical_records/add_medical_record.dart';
import 'package:wellness24/components/pages/common_pages/medical_records/record_card.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';

class MedicalRecords extends StatefulWidget {
  final Patient patient;
  final bool editable;

  MedicalRecords({this.patient, this.editable});

  @override
  _MedicalRecordsState createState() => _MedicalRecordsState();
}

class _MedicalRecordsState extends State<MedicalRecords> {
  List<RecordCard> healthHistory = [];
  List<RecordCard> medicalRecords = [];

  bool isDoctor = false;

  @override
  void initState() {
    if (widget.patient != null) {
      healthHistory = widget.patient.medicalHistory.map((title) {
        return RecordCard(title: title);
      }).toList();
    }

    super.initState();
  }

  _initializeBody(String uid) async {
    String role = await DatabaseService(uid: uid).getRole();

    if (role == 'Doctor') {
      if (mounted) {
        setState(() {
          isDoctor = true;
        });
      }
    }

    medicalRecords = [
      RecordCard(
        title: 'Blood Test',
        date: DateTime.now(),
        onTap: isDoctor
            ? () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddMedicalRecord(
                              title: 'Blood Test',
                              patient: widget.patient,
                            )));
              }
            : null,
      ) // TODO: replace placeholder
    ];
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context);

    _initializeBody(currentUser.uid);

    return Scaffold(
        appBar: CustomAppBar(
          title: 'Medical Records',
          actions: [
            IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  print('Notif button clicked');
                })
          ],
        ),
        floatingActionButton: isDoctor
            ? FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddMedicalRecord(patient: widget.patient)));
                },
              )
            : Container(),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent[100],
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Health History",
                        style: TextStyle(
                            fontSize: 23,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(thickness: 2, height: 22),
                      SizedBox(
                        height: 180,
                        child:
                            ListView(primary: false, children: healthHistory),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'View all',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "ShipporiMincho",
                            ),
                          ))
                    ],
                  )),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent[100],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Medical Records",
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(thickness: 2),
                      SizedBox(
                          height: 180,
                          child: ListView(
                              primary: false, children: medicalRecords)),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddMedicalRecord()));
                        },
                        icon: Icon(Icons.add),
                        label: Text('Add Medical Record'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.orange[200],
                            onPrimary: Colors.black),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'View all',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "ShipporiMincho",
                            ),
                          ))
                    ],
                  ))
            ])));
  }
}

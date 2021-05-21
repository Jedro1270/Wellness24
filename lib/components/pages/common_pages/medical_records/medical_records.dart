import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/common_pages/medical_records/medical_record_page.dart';
import 'package:wellness24/components/pages/common_pages/medical_records/record_card.dart';
import 'package:wellness24/components/pages/patient_screen/medical_histories/medical_history.dart';
import 'package:wellness24/models/medical_record.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';

class MedicalRecords extends StatefulWidget {
  final String role;
  final Patient patient;
  final bool editable;

  MedicalRecords({this.patient, this.editable, this.role});

  @override
  _MedicalRecordsState createState() => _MedicalRecordsState();
}

class _MedicalRecordsState extends State<MedicalRecords> {
  List<RecordCard> healthHistory = [];
  List<RecordCard> medicalRecordCards = [];
  DatabaseService databaseService;

  bool isDoctor = false;

  void _initializeBody() async {
    if (widget.role == 'Doctor') {
      if (mounted) {
        setState(() {
          isDoctor = true;
        });
      }
    }

    List<MedicalRecord> medicalRecords =
        await databaseService.getMedicalRecords(widget.patient.uid);

    List recordCards = medicalRecords
        .map((medicalRecord) => RecordCard(
            title: medicalRecord.title,
            date: medicalRecord.lastEdited,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MedicalRecordPage(
                            patient: widget.patient,
                            medicalRecord: medicalRecord,
                            createNewRecord: false,
                            editable: isDoctor,
                            refresh: refresh,
                          )));
            }))
        .toList();

    if (mounted) {
      setState(() {
        medicalRecordCards = recordCards;
      });
    }
  }

  void refresh() {
    _initializeBody();
  }

  @override
  void initState() {
    if (widget.patient != null) {
      healthHistory = widget.patient.medicalHistory.map((title) {
        return RecordCard(title: title);
      }).toList();
    }

    databaseService = DatabaseService();

    _initializeBody();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          onPressed: () {
                            modalListHistory(context);
                          },
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
                          height: 80,
                          child: ListView(
                              primary: false, children: medicalRecordCards)),
                      isDoctor
                          ? ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MedicalRecordPage(
                                              patient: widget.patient,
                                              createNewRecord: true,
                                              refresh: refresh,
                                            )));
                              },
                              icon: Icon(Icons.add),
                              label: Text('Add Medical Record'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange[200],
                                  onPrimary: Colors.black),
                            )
                          : Container(),
                      TextButton(
                          onPressed: () {
                            isDoctor
                                ? modalListRecords(context)
                                : showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                        title: Text('Notice'),
                                        content: Text(
                                            'Patients are Prohibited to view Medical Records')));
                          },
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

  modalListHistory(context) {
    return showGeneralDialog(
        context: context,
        transitionDuration: Duration(microseconds: 1000),
        pageBuilder: (BuildContext context, Animation first, Animation second) {
          return Scaffold(
              body: Container(
                  margin: EdgeInsets.all(30),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent[100],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            alignment: Alignment.topRight,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                      ),
                      Container(
                          child: Text(
                        'Medical Records',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.bold),
                      )),
                      Expanded(
                        flex: 8,
                        child:
                            ListView(primary: false, children: healthHistory),
                      ),
                    ],
                  )));
        });
  }

  modalListRecords(context) {
    return showGeneralDialog(
        context: context,
        transitionDuration: Duration(microseconds: 1000),
        pageBuilder: (BuildContext context, Animation first, Animation second) {
          return Scaffold(
              body: Container(
                  margin: EdgeInsets.all(30),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent[100],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            alignment: Alignment.topRight,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                      ),
                      Column(
                        children: [
                          Text(
                            'Medical Records',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "ShipporiMincho",
                                fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MedicalRecordPage(
                                            patient: widget.patient,
                                            createNewRecord: true,
                                            refresh: refresh,
                                          )));
                            },
                            icon: Icon(Icons.add),
                            label: Text('Add Medical Record'),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.orange[200],
                                onPrimary: Colors.black),
                          ),
                          SizedBox(
                              height: 150,
                              child: ListView(
                                  primary: false, children: medicalRecordCards))
                        ],
                      )
                    ],
                  )));
        });
  }
}

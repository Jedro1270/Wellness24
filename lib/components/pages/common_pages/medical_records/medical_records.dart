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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                "Health History",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "ShipporiMincho",
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(thickness: 2),
            Expanded(
              flex: 1,
              child: ListView(primary: false, children: healthHistory),
            ),
            Divider(thickness: 2),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                "Medical Records",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "ShipporiMincho",
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView(primary: false, children: medicalRecords),
            ),
          ],
        ),
      ),
    );
  }
}

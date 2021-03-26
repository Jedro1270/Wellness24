import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/common_pages/medical_records/record_card.dart';
import 'package:wellness24/models/patient.dart';

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

  @override
  void initState() {
    if (widget.patient != null) {
      healthHistory = widget.patient.medicalHistory.map((title) {
        return RecordCard(title: title);
      }).toList();

      medicalRecords = [
        RecordCard(
          title: 'Blood Test',
          date: DateTime.now(),
        ) // TODO: replace placeholder
      ];
    }

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
            Container(
              height: 200,
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
            Container(
              height: 275,
              child: ListView(primary: false, children: medicalRecords),
            ),
          ],
        ),
      ),
    );
  }
}

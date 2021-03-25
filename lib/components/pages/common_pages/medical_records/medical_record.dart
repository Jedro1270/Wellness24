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
  List<RecordCard> records = [];

  @override
  void initState() {
    if (widget.patient != null) {
      records = widget.patient.medicalHistory.map((title) {
        return RecordCard(title: title);
      }).toList();
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
                "Medical History",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "ShipporiMincho",
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(thickness: 2),
            Container(
              height: 300,
              child: ListView(children: records),
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
          ],
        ),
      ),
    );
  }
}

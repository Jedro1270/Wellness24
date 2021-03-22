import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/patient_screen/medical_records/record_card.dart';
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
    records = widget.patient.medicalHistory.map((title) {
      return RecordCard(title: title);
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.patient.fullName,
        actions: [
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                print('Notif button clicked');
              })
        ],
      ),
      body: Container(
        child: ListView(children: records),
      ),
    );
  }
}

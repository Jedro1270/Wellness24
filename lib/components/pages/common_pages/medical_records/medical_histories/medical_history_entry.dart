import 'package:flutter/material.dart';
import 'package:wellness24/models/medical_history_entry.dart';

class MedicalHistoryTile extends StatelessWidget {
  final Function onTap;
  final Function onChanged;
  final MedicalHistoryEntry medicalHistoryEntry;

  MedicalHistoryTile({this.onTap, this.onChanged, this.medicalHistoryEntry});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          value: medicalHistoryEntry.value,
          activeColor: Colors.blueAccent,
          onChanged: (value) {
            onChanged(value);
          },
        ),
        title: Text(medicalHistoryEntry.title,
            style: TextStyle(
                fontSize: 20,
                fontFamily: "ShipporiMincho",
                fontWeight: FontWeight.normal)),
        minVerticalPadding: 2,
      ),
    );
  }
}

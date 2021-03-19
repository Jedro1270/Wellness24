import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/common_pages/patient_profile/patient_profile.dart';
import 'package:wellness24/models/patient.dart';

class PatientInfo extends StatelessWidget {
  final Patient patient;

  PatientInfo({this.patient});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(10.0),
      height: 200,
      width: 200,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PatientProfile(patient: patient, editable: false)),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 10,
          child: Container(
            child: Row(
              children: <Widget>[
                SizedBox(width: 15),
                CircleAvatar(
                  radius: 25.0,
                  child: Image(
                    image: AssetImage("assets/patient.png"),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(patient.fullName,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "ShipporiMincho",
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start),
                      Text('Contact Number: ${patient.contactNo}',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "ShipporiMincho",
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.start)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

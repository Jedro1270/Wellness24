import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/patient_screen/doctor_details.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/patient.dart';

class DoctorInfo extends StatelessWidget {
  final Doctor doctor;
  final Patient currentPatient;

  DoctorInfo({this.doctor, this.currentPatient});

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
                builder: (context) => DoctorDetails(doctor: doctor, currentPatient: currentPatient)),
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
                    image: AssetImage("assets/doctor.png"),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Doctor ${doctor.fullName}",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "ShipporiMincho",
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start),
                      Text("${doctor.specialization}",
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

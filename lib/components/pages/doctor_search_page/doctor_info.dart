import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/doctor_screen/doctor_info_page.dart';

class DoctorInfo extends StatelessWidget {
  final String firstName;
  final String middleInitial;
  final String lastName;
  final String specialization;
  final String clinicHours;

  DoctorInfo(
      {this.firstName,
      this.middleInitial,
      this.lastName,
      this.specialization,
      this.clinicHours});

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
            MaterialPageRoute(builder: (context) => DoctorDetail()),
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
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Doctor $firstName $middleInitial. $lastName",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "ShipporiMincho",
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      Text("Specialization: $specialization",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "ShipporiMincho",
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center),
                      Text("Clinic Hours: $clinicHours",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "ShipporiMincho",
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center),
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

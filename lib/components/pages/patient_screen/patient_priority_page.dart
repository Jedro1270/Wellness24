import 'package:flutter/material.dart';

class PatientPriorityNumber extends StatefulWidget {
  @override
  _PatientPriorityNumberState createState() => _PatientPriorityNumberState();
}

class _PatientPriorityNumberState extends State<PatientPriorityNumber> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(vertical: 90),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image(
              image: AssetImage('assets/sample-patient.jpg'),
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Divider(height: 20, color: Colors.transparent),
          Text('Doctor',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "ShipporiMincho",
                  color: Colors.black)),
          Divider(height: 30, color: Colors.transparent),
          Text(
            'April 25, 2021',
            style: TextStyle(
              fontFamily: "ShipporiMincho",
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Divider(height: 10, color: Colors.transparent),
          Text(
            'Your priority number is: ',
            style: TextStyle(
              fontFamily: "ShipporiMincho",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            '24',
            style: TextStyle(
              fontFamily: "ShipporiMincho",
              fontWeight: FontWeight.bold,
              fontSize: 150,
            ),
          ),
          Text(
            'Please take a screenshot',
            style: TextStyle(
              fontFamily: "ShipporiMincho",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'Present this to the secretary or doctor',
            style: TextStyle(
              fontFamily: "ShipporiMincho",
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    ));
  }
}

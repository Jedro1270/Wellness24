import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DoctorQueueMonitor extends StatefulWidget {
  @override
  _DoctorQueueMonitorState createState() => _DoctorQueueMonitorState();
}

class _DoctorQueueMonitorState extends State<DoctorQueueMonitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(75),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Schedules',
            style: TextStyle(
              fontFamily: "ShipporiMincho",
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
          Divider(height: 50, color: Colors.transparent),
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
            'Now Serving',
            style: TextStyle(
              fontFamily: "ShipporiMincho",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_rounded),
              Text(
                '24',
                style: TextStyle(
                  fontFamily: "ShipporiMincho",
                  fontWeight: FontWeight.bold,
                  fontSize: 90,
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded)
            ],
          ),
          Container(
              child: Text(
                'Accept Appointments',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "ShipporiMincho",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              color: Colors.greenAccent[700],
              padding: EdgeInsets.all(25)),
        ],
      ),
    ));
  }
}
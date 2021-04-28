import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/models/doctor.dart';

class PatientPriorityNumber extends StatefulWidget {
  final Doctor doctor;
  final DateTime date;

  PatientPriorityNumber({@required this.doctor, @required this.date});

  @override
  _PatientPriorityNumberState createState() => _PatientPriorityNumberState();
}

class _PatientPriorityNumberState extends State<PatientPriorityNumber> {
  DateFormat format = DateFormat.yMMMMd('en_US');

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: '',
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Text('Doctor ${widget.doctor.fullName}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          color: Colors.black)),
                ),
              ),
              Divider(height: 30, color: Colors.transparent),
              Text(
                format.format(widget.date),
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
                '24', // TODO: Replace with number generated based on previous number from database
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

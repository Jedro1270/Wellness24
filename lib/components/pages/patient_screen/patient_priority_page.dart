import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/services/database.dart';

class PatientPriorityNumber extends StatefulWidget {
  final Doctor doctor;
  final DateTime date;
  final Patient currentPatient;

  PatientPriorityNumber(
      {@required this.doctor,
      @required this.date,
      @required this.currentPatient});

  @override
  _PatientPriorityNumberState createState() => _PatientPriorityNumberState();
}

class _PatientPriorityNumberState extends State<PatientPriorityNumber> {
  DateFormat format = DateFormat.yMMMMd('en_US');
  int priorityNum;

  void fetchPriorityNum() async {
    DatabaseService _database = DatabaseService(uid: widget.currentPatient.uid);
    int result = await _database.getPriorityNum(widget.doctor.uid, widget.date);
    setState(() {
      priorityNum = result;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPriorityNum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Appointment',
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                '${priorityNum ?? ""}',
                style: TextStyle(
                  fontFamily: "ShipporiMincho",
                  fontWeight: FontWeight.bold,
                  fontSize: 75,
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

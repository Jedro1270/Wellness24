import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/patient_screen/patient_home_page.dart';

class PatientAppointmentPage extends StatefulWidget {
  @override
  _PatientAppointmentState createState() => _PatientAppointmentState();
}

class _PatientAppointmentState extends State<PatientAppointmentPage> {
  DateTime _date = DateTime.now();
  DateFormat format = DateFormat('MM-dd-yyyy');
  TimeOfDay _time;

  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1921),
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime val) =>
          val.weekday == 6 || val.weekday == 7 ? false : true,
    );

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _time = TimeOfDay.now();
  }

  _pickTime() async {
    TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: _time,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(),
            child: child,
          );
        });

    if (time != null) {
      setState(() {
        _time = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Schedule Appointment',
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => PatientHomePage()));
            }),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 25.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Elimjoyce Abagat\n',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "ShipporiMincho",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                  text: "Cardiologist",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: "ShipporiMincho",
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(height: 30, color: Colors.transparent),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SCHEDULE",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "Limit: 30",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              Divider(height: 20, thickness: 2, color: Colors.black),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Clinic Hours:",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "ShipporiMincho",
                              color: Colors.black)),
                      SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("12:00 pm - 4:00 pm",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "ShipporiMincho",
                                  color: Colors.black)),
                          Text("Thursday - Saturday",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "ShipporiMincho",
                                  color: Colors.black)),
                        ],
                      )
                    ],
                  )),
              Divider(height: 30, thickness: 2, color: Colors.black),
              Row(
                children: [
                  Text("Date:   ",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          color: Colors.black)),
                  Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFF40BEEE), width: 1),
                          borderRadius: BorderRadius.circular(20.0)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${format.format(_date)}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "ShipporiMincho",
                                  color: Colors.black)),
                          IconButton(
                            icon:
                                Icon(Icons.calendar_today, color: Colors.blue),
                            onPressed: () {
                              setState(() {
                                _selectDate(context);
                                print(format.format(_date));
                              });
                            },
                          ),
                        ],
                      ))
                ],
              ),
              Divider(height: 20, thickness: 2, color: Colors.transparent),
              Row(
                children: [
                  Text("Time:  ",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          color: Colors.black)),
                  Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFF40BEEE), width: 1),
                          borderRadius: BorderRadius.circular(20.0)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${_time.hour}:${_time.minute}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "ShipporiMincho",
                                  color: Colors.black)),
                          IconButton(
                            icon: Icon(Icons.access_time, color: Colors.blue),
                            onPressed: () {
                              setState(() {
                                _pickTime();
                              });
                            },
                          ),
                        ],
                      ))
                ],
              ),
              Divider(height: 10, color: Colors.transparent),
              MaterialButton(
                  minWidth: 200,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black12)),
                  color: Color(0xFF40BEEE),
                  onPressed: () {},
                  child: Text("Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.normal)))
            ],
          )),
    );
  }
}
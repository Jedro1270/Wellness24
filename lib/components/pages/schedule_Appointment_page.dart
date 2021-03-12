import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/patient_home_page.dart';

class PatientAppointmentPage extends StatefulWidget {
  @override
  _PatientAppointmentState createState() => _PatientAppointmentState();
}

class _PatientAppointmentState extends State<PatientAppointmentPage> {
  DateTime _date = DateTime.now();
  DateFormat format = DateFormat('MM-dd-yyyy');

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Schedule Appointment',
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Date:  ${format.format(_date)}",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          color: Colors.black)),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      setState(() {
                        _selectDate(context);
                        print(format.format(_date));
                      });
                    },
                  ),
                  Divider(height: 10, color: Colors.transparent),
                ],
              ),
              Divider(height: 10, color: Colors.transparent),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Time:  ",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          color: Colors.black)),
                  IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () {
                      print('time');
                    },
                  ),
                  Divider(height: 10, color: Colors.transparent),
                ],
              ),
              Divider(height: 10, color: Colors.transparent),
              MaterialButton(
                  minWidth: 200,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black12)),
                  color: Colors.grey.withOpacity(0.5),
                  onPressed: () {
                    print("submit");
                  },
                  child: Text("Submit",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 25,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.normal)))
            ],
          )),
    );
  }
}
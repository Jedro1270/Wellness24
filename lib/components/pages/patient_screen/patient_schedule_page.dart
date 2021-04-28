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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PatientHomePage()));
            }),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 25.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image(
                        image: AssetImage('assets/sample-patient.jpg'),
                        width: 180,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Divider(height: 30, color: Colors.transparent),
                    Text('Doctor',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            color: Colors.black)),
                    Divider(height: 30, color: Colors.transparent),
                    Text(
                      "Doctor's Schedule",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Divider(height: 5, color: Colors.transparent),
                    Text("12:00 pm - 4:00 pm",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "ShipporiMincho",
                            color: Colors.black)),
                    Text("Thursday - Saturday",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "ShipporiMincho",
                            color: Colors.black)),
                    Divider(height: 30, color: Colors.transparent),
                    Row(
                      children: [
                        Text("Pick Date:   ",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "ShipporiMincho",
                                color: Colors.black)),
                        Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFF40BEEE), width: 1),
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("${format.format(_date)}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "ShipporiMincho",
                                        color: Colors.black)),
                                IconButton(
                                  icon: Icon(Icons.calendar_today,
                                      color: Colors.blue),
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
                  ],
                ),
              ),
              Divider(height: 30, color: Colors.transparent),
              MaterialButton(
                  minWidth: 200,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black12)),
                  color: Color(0xFF40BEEE),
                  onPressed: () {
                     _showDialog(context);
                  },
                  child: Text("Schedule Appointment",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.normal)))
            ],
          )),
    );
  }

  
 _showDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      content: Text('Are you sure you want to schedule an appointment?'),
      actions: [
        ElevatedButton(onPressed: (){
          
        }, child: Text('YES')),
        ElevatedButton(onPressed: (){
          
        }, child: Text('NO'))
      ],
    ));
 }
}

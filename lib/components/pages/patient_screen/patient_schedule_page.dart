import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/pages/patient_screen/patient_priority_page.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/services/database.dart';

class PatientAppointmentPage extends StatefulWidget {
  final Doctor doctor;
  final Patient currentPatient;

  PatientAppointmentPage({@required this.doctor, this.currentPatient});

  @override
  _PatientAppointmentState createState() => _PatientAppointmentState();
}

class _PatientAppointmentState extends State<PatientAppointmentPage> {
  DateTime _date = DateTime.now();
  DateFormat format = DateFormat('MM-dd-yyyy');
  bool isScheduled = false;
  bool isAvailable = true; // Change to database data
  bool loading = false;

  Future updateScheduledStatus(DateTime date) async {
    bool scheduledStatus = await DatabaseService(uid: widget.currentPatient.uid)
        .isScheduled(date, widget.doctor.uid);
    setState(() {
      isScheduled = scheduledStatus;
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime val) =>
          val.weekday == 6 || val.weekday == 7 ? false : true,
    );

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
      });
      await updateScheduledStatus(_date);
    }
  }

  @override
  void initState() {
    super.initState();
    updateScheduledStatus(_date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Schedule Appointment',
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: loading
          ? Loading()
          : Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 250,
                            width: 250,
                            child: widget.doctor.profilePictureUrl == null
                                ? Image(
                                    image: AssetImage('assets/logo.jpg'),
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    widget.doctor.profilePictureUrl,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        Divider(height: 30, color: Colors.transparent),
                        Text('Doctor ${widget.doctor.fullName}',
                            textAlign: TextAlign.center,
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
                        Text(widget.doctor.workingDays,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "ShipporiMincho",
                                color: Colors.black)),
                        Text(
                            '${widget.doctor.clinicStart} - ${widget.doctor.clinicEnd}',
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
                                    Text(format.format(_date),
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
                  isAvailable
                      ? MaterialButton(
                          minWidth: 200,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(color: Colors.black12)),
                          color: Color(0xFF40BEEE),
                          onPressed: () {
                            isScheduled
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PatientPriorityNumber(
                                              doctor: widget.doctor,
                                              date: _date,
                                              currentPatient:
                                                  widget.currentPatient,
                                            )))
                                : _showDialog(context);
                          },
                          child: Text(
                              isScheduled
                                  ? "View Appointment Number"
                                  : "Schedule Appointment",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontFamily: "ShipporiMincho",
                                  fontWeight: FontWeight.normal)))
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.red,
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Sorry. your doctor is no longer available for appointments. \n\nPlease schedule for a priority number again tomorrow.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                ],
              )),
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Are you sure you want to schedule an appointment?'),
        actions: [
          ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);

                setState(() {
                  loading = true;
                });

                DatabaseService database =
                    DatabaseService(uid: widget.currentPatient.uid);

                String result =
                    await database.addAppointment(widget.doctor.uid, _date);

                if (result == null) {
                  setState(() {
                    loading = false;
                    isScheduled = true;
                  });
                } else {
                  setState(() {
                    loading = false;
                  });

                  _showLimitReachedDialog();
                }
              },
              child: Text('YES')),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('NO'))
        ],
      ),
    );
  }

  _showLimitReachedDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Capacity Reached!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'The number of appointments for this day has been reached, please reschedule for another day.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Close',
                )),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/common/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/common/schedule_card.dart';
import 'package:wellness24/components/pages/common_pages/chat/messages.dart';
import 'package:wellness24/components/pages/doctor_screen/notification_page.dart';
import 'package:wellness24/components/pages/doctor_screen/patients_list/my_patients_list.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/components/pages/common_pages/login_page.dart';
import 'package:wellness24/services/database.dart';

class DoctorHomePage extends StatefulWidget {
  final Doctor mockDoctor;
  final List mockPatients;
  DoctorHomePage({this.mockDoctor, this.mockPatients});
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  Doctor currentDoctor;

  initializeDoctor() async {
    if (widget.mockDoctor == null) {
      User user = Provider.of<User>(context, listen: false);
      DatabaseService database = DatabaseService(uid: user.uid);
      Doctor doctor = await database.getDoctor(user.uid);
      setState(() {
        currentDoctor = doctor;
      });
    } else {
      setState(() {
        currentDoctor = widget.mockDoctor;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initializeDoctor();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    if (user == null) {
      return Login();
    }

    return Scaffold(
      drawer: NavBar(
          name: currentDoctor == null ? '' : currentDoctor.fullName,
          email: user.email),
      appBar: CustomAppBar(
        title: 'Home Page',
        actions: [
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationPage()));
                print("Clicked Notif icon");
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Messages(currentUser: user)));
        },
      ),
      body: currentDoctor == null
          ? Loading()
          : Container(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: Text(
                      'My Patients',
                      style: TextStyle(
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                      height: 200,
                      child: MyPatientsList(
                        mockPatients: widget.mockPatients ?? [],
                        doctorDatabaseRef:
                            DatabaseService(uid: user.uid).doctors,
                        doctorId: user.uid,
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: Text(
                      'My Appointments',
                      style: TextStyle(
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  buildAppointmentList(),
                ],
              ),
            ),
    );
  }
}

buildAppointmentList() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30),
    child: Column(
      children: <Widget>[
        ScheduleCard('12', 'Jan', 'Consultation', 'Sunday 9am - 11am'),
        SizedBox(height: 20),
        ScheduleCard('15', 'Oct', 'Consultation', 'Monday 1pm - 3pm')
      ],
    ),
  );
}

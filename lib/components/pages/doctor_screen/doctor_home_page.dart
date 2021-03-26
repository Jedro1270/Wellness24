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
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  Doctor currentDoctor;

  initializeDoctor(String uid) async {
    DatabaseService database = DatabaseService(uid: uid);
    Doctor doctor = await database.getDoctor(uid);

    setState(() {
      currentDoctor = doctor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Login();
    }

    initializeDoctor(user.uid);

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
              context, MaterialPageRoute(builder: (context) => Messages()));
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

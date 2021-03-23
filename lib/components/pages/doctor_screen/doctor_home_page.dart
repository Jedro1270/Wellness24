import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/common/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/common/schedule_card.dart';
import 'package:wellness24/components/pages/doctor_screen/notification_page.dart';
import 'package:wellness24/components/pages/doctor_screen/patients_list/patients_list.dart';
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

    initializeDoctor(user.uid);

    if (user == null) {
      return Login();
    }

    return Scaffold(
      drawer: NavBar(),
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
          print("Message Icon click");
        },
      ),
      body: currentDoctor == null
          ? Loading()
          : Container(
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 30.0),
                  Container(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child:
                              Image(image: AssetImage("assets/mypatient.png")),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PatientsList(
                                          doctorDatabaseRef:
                                              DatabaseService(uid: user.uid)
                                                  .doctors,
                                          doctorId: user.uid,
                                        )));
                          },
                          child: Text(
                            "My patients",
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: "ShipporiMincho",
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'My Appointments',
                      style: TextStyle(
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  buildAppointmentList(),
                  SizedBox(height: 30.0),
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

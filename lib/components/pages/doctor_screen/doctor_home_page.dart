import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/common/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/pages/doctor_screen/patients_list/patients_list.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/components/pages/common_pages/login_page.dart';
import 'package:wellness24/services/database.dart';

class DoctorHomePage extends StatefulWidget {
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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
      body: Container(
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
                    child: Image(image: AssetImage("assets/mypatient.png")),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientsList(
                                    patientDatabaseRef:
                                        DatabaseService(uid: user.uid).patients,
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
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Image(image: AssetImage("assets/schedule.png")),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "My Appointments",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

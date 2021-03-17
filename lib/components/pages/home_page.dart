import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/pages/doctor_screen/doctor_home_page.dart';
import 'package:wellness24/components/pages/patient_screen/patient_home_page.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<User>(context);
//     final DatabaseService database = DatabaseService(uid: user.uid);
//     var page = Scaffold();

//     void renderPage() async {
//       String role = await database.getRole();
//       print(role);
//       if (role == 'Doctor') {
//         setState(() => page = DoctorHomePage());
//       } else {
//         setState(() => page = PatientHomePage());
//       }
//     }

//     renderPage();

//     return page;
//   }
// }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final DatabaseService database = DatabaseService(uid: user.uid);
    dynamic page = Scaffold(
      body: Container(),
    );

    void renderPage() async {
      String role = await database.getRole();

      //prints doctor/patient string (ga gana na ni)
      print(role);

      if (role == 'Doctor') {
        setState(() => page.body.child = DoctorHomePage());
      } else {
        setState(() => page.body.child = PatientHomePage());
      }
    }

    renderPage();

    return page;
  }
}

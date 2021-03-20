import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/pages/doctor_screen/doctor_home_page.dart';
import 'package:wellness24/components/pages/patient_screen/patient_home_page.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final DatabaseService database = DatabaseService(uid: user.uid);

    Future<String> getRole() async {
      String role = await database.getRole();
      return role;
    }

    return FutureBuilder<String>(
        future: getRole(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'Doctor') {
              return DoctorHomePage();
            } else {
              return StreamProvider<Patient>.value(
                  initialData: null,
                  value: DatabaseService(uid: user.uid).currentPatient,
                  child: PatientHomePage());
            }
          } else {
            return Loading();
          }
        });
  }
}

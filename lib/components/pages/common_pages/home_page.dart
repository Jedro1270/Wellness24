import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/pages/common_pages/login_page.dart';
import 'package:wellness24/components/pages/doctor_screen/doctor_home_page.dart';
import 'package:wellness24/components/pages/patient_screen/patient_home_page.dart';
import 'package:wellness24/models/blood_pressure.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Login();
    }

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
              return MultiProvider(providers: [
                StreamProvider<Patient>.value(
                  initialData: null,
                  value: DatabaseService(uid: user.uid).currentPatient,
                ),
                StreamProvider<BloodPressure>.value(
                  initialData: null,
                  value: DatabaseService(uid: user.uid).currentBloodPressure,
                )
              ], child: PatientHomePage());
            }
          } else {
            return Loading();
          }
        });
  }
}

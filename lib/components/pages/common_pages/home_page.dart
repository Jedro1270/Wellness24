import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/pages/doctor_screen/doctor_home_page.dart';
import 'package:wellness24/components/pages/patient_screen/patient_home_page.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';

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
            return snapshot.data == 'Doctor'
                ? DoctorHomePage()
                : PatientHomePage();
          } else {
            return Loading();
          }
        });
  }
}

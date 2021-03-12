import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/pages/doctor_home_page.dart';
import 'package:wellness24/components/pages/front_page.dart';
import 'package:wellness24/models/user.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return login or front page
    return user == null ? FrontPage() : DoctorHomePage();
  }
}

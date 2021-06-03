import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/common/navigation_bar.dart';
import 'package:wellness24/components/pages/common_pages/login_page.dart';
import 'package:wellness24/components/pages/doctor_screen/view_request_component.dart';
import 'package:wellness24/components/pages/doctor_screen/doctor_home_page.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Login();
    }

    return Scaffold(
        drawer: NavBar(),
        appBar: CustomAppBar(
          leading: IconButton(
            key: Key('pageBack'),
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DoctorHomePage()));
              }),
          title: 'Notifications',
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print("Clicked Search icon");
                })
          ],
        ),
        body: ViewRequest(
          database: DatabaseService(uid: user.uid),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/common/navigation_bar.dart';
import 'package:wellness24/components/common/view_request_component.dart';
import 'package:wellness24/components/pages/doctor_screen/doctor_home_page.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: CustomAppBar(
          leading: IconButton(
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
        body: ViewRequest());
  }
}

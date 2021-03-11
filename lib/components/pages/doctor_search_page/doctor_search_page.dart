import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/doctor_search_page/doctors_list.dart';

class DoctorSearchPage extends StatefulWidget {
  @override
  _DoctorSearchPageState createState() => _DoctorSearchPageState();
}

class _DoctorSearchPageState extends State<DoctorSearchPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Registered Doctors',
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.home_outlined),
            iconSize: 30.0,
          )
        ],
      ),
      body: Container(child: DoctorsList()),
    );
  }
}
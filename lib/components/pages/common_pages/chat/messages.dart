import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/common_pages/chat/user_tile.dart';
import 'package:wellness24/models/doctor.dart';
import 'package:wellness24/models/patient.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';

class Messages extends StatefulWidget {
  final User currentUser;

  Messages({this.currentUser});

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  List<UserTile> users = [];
  DatabaseService database;

  void getUsers() async {
    database = DatabaseService(uid: widget.currentUser.uid);
    String role = await database.getRole();

    List<UserTile> mappedUsers = [];

    DocumentSnapshot snapshot = role == 'Patient'
        ? await database.patients.document(widget.currentUser.uid).get()
        : await database.doctors.document(widget.currentUser.uid).get();

    if (role == 'Patient') {
      await Future.forEach(snapshot.data['doctors'], (doctor) async {
        Doctor currentDoctor = await database.getDoctor(doctor['uid']);

        mappedUsers.add(UserTile(
          name: currentDoctor.fullName,
          userUid: currentDoctor.uid,
          profilePictureUrl: currentDoctor.profilePictureUrl,
        ));
      });
    } else {
      await Future.forEach(snapshot.data['patients'], (patient) async {
        Patient currentPatient = await database.getPatient(patient['uid']);

        mappedUsers.add(UserTile(
          name: currentPatient.fullName,
          userUid: currentPatient.uid,
          profilePictureUrl: currentPatient.profilePictureUrl,
        ));
      });
    }

    setState(() {
      users = mappedUsers;
    });
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Messages',
      ),
      body: Container(child: ListView(children: users)),
    );
  }
}

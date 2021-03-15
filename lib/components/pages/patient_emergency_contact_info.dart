import 'package:flutter/material.dart';
import 'package:wellness24/components/common/text_input.dart';
import 'package:wellness24/components/pages/medical_history.dart';
import 'package:wellness24/models/new_account.dart';

class EmergencyContactInfo extends StatefulWidget {
  final NewAccount account;
  EmergencyContactInfo(this.account);
  @override
  _EmergencyContactInfoState createState() =>
      _EmergencyContactInfoState(account);
}

class _EmergencyContactInfoState extends State<EmergencyContactInfo> {
  final NewAccount account;

  _EmergencyContactInfoState(this.account);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 25.0),
        child: ListView(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    "Emergency Contact Information",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(children: <Widget>[
                Text(
                  "Last Name",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "ShipporiMincho",
                      fontWeight: FontWeight.normal),
                ),
              ]),
            ),
            SizedBox(height: 5),
            TextInput(obscureText: false),
            SizedBox(height: 15),
            Container(
              child: Row(children: <Widget>[
                Text(
                  "First Name",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "ShipporiMincho",
                      fontWeight: FontWeight.normal),
                ),
              ]),
            ),
            SizedBox(height: 5),
            TextInput(obscureText: false),
            SizedBox(height: 15),
            Container(
              child: Row(children: <Widget>[
                Text(
                  "Middle Name",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "ShipporiMincho",
                      fontWeight: FontWeight.normal),
                ),
              ]),
            ),
            SizedBox(height: 5),
            TextInput(obscureText: false),
            SizedBox(height: 15),
            Container(
              child: Row(children: <Widget>[
                Text("Address",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.normal)),
              ]),
            ),
            SizedBox(height: 5),
            TextInput(obscureText: false),
            SizedBox(height: 15),
            Container(
              child: Row(children: <Widget>[
                Text("Contact Number",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.normal)),
              ]),
            ),
            SizedBox(height: 5),
            TextInput(obscureText: false),
            SizedBox(height: 15),
            Container(
              child: Row(children: <Widget>[
                Text("Relationship",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.normal)),
              ]),
            ),
            SizedBox(height: 5),
            TextInput(obscureText: false),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_forward_sharp, size: 45),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicalHistory(account)),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

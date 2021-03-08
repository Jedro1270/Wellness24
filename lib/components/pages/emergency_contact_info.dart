import 'package:flutter/material.dart';
import 'package:wellness24/components/common/text_input.dart';
import 'package:wellness24/components/pages/medical_history.dart';

class EmergencyContantInfo extends StatefulWidget {
  @override
  _EmergencyContantInfoState createState() => _EmergencyContantInfoState();
}

class _EmergencyContantInfoState extends State<EmergencyContantInfo> {
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
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: Row(children: <Widget>[
                Text(
                  "Name (Last, First, Middle)",
                  style: TextStyle(fontSize: 20),
                ),
              ]),
            ),
            SizedBox(height: 5),
            TextInput(),
            SizedBox(height: 15),
            Container(
              child: Row(children: <Widget>[
                Text("Address", style: TextStyle(fontSize: 20)),
              ]),
            ),
            SizedBox(height: 5),
            TextInput(),
            SizedBox(height: 15),
            Container(
              child: Row(children: <Widget>[
                Text("Contact Number", style: TextStyle(fontSize: 20)),
              ]),
            ),
            SizedBox(height: 5),
            TextInput(),
            SizedBox(height: 15),
            Container(
              child: Row(children: <Widget>[
                Text("Relationship", style: TextStyle(fontSize: 20)),
              ]),
            ),
            SizedBox(height: 5),
            TextInput(),
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
                            builder: (context) => MedicalHistory()),
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

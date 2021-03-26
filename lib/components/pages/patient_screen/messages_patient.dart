import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/patient_screen/chat_room_patient.dart';

class PatientMessages extends StatefulWidget {
  @override
  _PatientMessagesState createState() => _PatientMessagesState();
}

class _PatientMessagesState extends State<PatientMessages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Messages',
      ),
      body: Container(
          child: ListView(children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatRoomPatient()));
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.grey,
                  child: ClipOval(
                    child: SizedBox(
                        width: 100.0,
                        height: 100.0,
                        // child: Image(
                        //     image: AssetImage('assets/sample-patient.jpg'))
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Dr. Marie C. Ozamu",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 15.0,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(thickness: 2),
      ])),
    );
  }
}

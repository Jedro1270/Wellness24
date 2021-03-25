import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/common_pages/patient_profile/patient_condition.dart';
import 'package:wellness24/components/pages/patient_screen/patient_home_page.dart';
import 'package:intl/intl.dart';
import 'package:wellness24/models/patient.dart';

class EmergencyPage extends StatefulWidget {
  final Patient patient;

  EmergencyPage({this.patient});

  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Emergency',
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PatientHomePage()));
            }),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Date: ${DateFormat.yMd().format(DateTime.now())}",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(height: 20),
            Container(
              height: 75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Patient Name: ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "ShipporiMincho",
                        color: Colors.black),
                  ),
                  Expanded(
                    child: Text(
                      widget.patient.fullName,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Age: ${widget.patient.age}",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        color: Colors.black),
                  ),
                  SizedBox(width: 100),
                  Text(
                    "Gender: ${widget.patient.gender}",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        color: Colors.black),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "CONDITIONS",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.black),
            SizedBox(height: 20),
            PatientCondition(
              editable: false,
              icon: Image(image: AssetImage('assets/body-temp.png')),
              content: widget.patient.bodyTemperature.toString(),
              title: 'Body Temperature',
            ),
            PatientCondition(
              editable: false,
              icon: Image(image: AssetImage('assets/weight.png')),
              content: widget.patient.weight.toString(),
              title: 'Weight',
            ),
            PatientCondition(
              editable: false,
              icon: Image(image: AssetImage('assets/height.png')),
              content: widget.patient.height.toString(),
              title: 'Height',
            ),
            PatientCondition(
                editable: false,
                icon: Image(image: AssetImage('assets/droplet.png')),
                content: widget.patient.bloodType,
                title: 'Blood Type'),
            PatientCondition(
                editable: false,
                icon: Image(image: AssetImage('assets/double-person.png')),
                content: '${widget.patient.age} y.o',
                title: 'Age'),
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    "Symptoms",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "ShipporiMincho",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: TextField(
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.red[50],
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12)),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text("Submit",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                        primary: Colors.red[600]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

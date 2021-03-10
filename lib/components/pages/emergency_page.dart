import 'package:flutter/material.dart';

class EmergencyPage extends StatefulWidget {
  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 25.0),
        child: ListView(
          children: <Widget>[
            Container(
              width: 100,
              height: 50,
              color: Colors.redAccent[700],
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Emergency",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: "ShipporiMincho",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Date: 3/10/2021",
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Patient Name: Jedro Abagat",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        color: Colors.black),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Age: 21",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        color: Colors.black),
                  ),
                  SizedBox(width: 50),
                  Text(
                    "Gender: Male",
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
            Container(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                      radius: 25,
                      child: Image(
                        image: AssetImage(
                            "assets/body-temp.png"),
                      )),
                  Text(
                    "Body\nTemperature: 36.3",
                    style:
                        TextStyle(fontSize: 15, fontFamily: "ShipporiMincho"),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Respiration Rate:",
                    style:
                        TextStyle(fontSize: 15, fontFamily: "ShipporiMincho"),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                      radius: 30,
                      child: Image(
                        image: AssetImage(
                            "assets/istockphoto-1133507993-612x612.jpg"),
                      )),
                  Text(
                    "Body\nPressure: 120/80",
                    style:
                        TextStyle(fontSize: 15, fontFamily: "ShipporiMincho"),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Pulse Rate:",
                    style:
                        TextStyle(fontSize: 15, fontFamily: "ShipporiMincho"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    "Diagnosis of Medical Condition",
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
              child: TextFormField(
                // keyboardType: TextInputType.emailAddress,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue[200],
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 25,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

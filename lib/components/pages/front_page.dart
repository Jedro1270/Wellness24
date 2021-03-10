import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/login.dart';
import 'package:wellness24/components/pages/registration.dart';

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 125.0, horizontal: 35.0),
          child: ListView(children: <Widget>[
            SizedBox(height: 50),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login as",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontFamily: "ShipporiMincho"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 25.0,
                    child: Image(image: AssetImage("assets/doctor.png"),),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    child: Text("Doctor",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 30,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.normal)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(radius: 20.0, child: Image(image: AssetImage("assets/patient.png"))),
                  SizedBox(width: 10),
                  InkWell(
                    child: (Text(
                      "Patient",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 30,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.normal),
                    )),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registration()),
                      );
                    },
                    child: Text(
                      "Sign up.",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/common_pages/register_credentials.dart';
import 'package:wellness24/models/new_account.dart';

class SignupOption extends StatefulWidget {
  @override
  _SignupOptionState createState() => _SignupOptionState();
}

class _SignupOptionState extends State<SignupOption> {
  NewAccount account;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                    "Sign up as",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold),
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
                    child: Image(
                      image: AssetImage("assets/doctor.png"),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                      child: Text("Doctor",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 30,
                              fontFamily: "ShipporiMincho",
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        this.account = NewAccount('Doctor');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegisterCredentials(account)));
                      }),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                      radius: 20.0,
                      child: Image(image: AssetImage("assets/patient.png"))),
                  SizedBox(width: 10),
                  InkWell(
                    child: (Text(
                      "Patient",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 30,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.bold),
                    )),
                    onTap: () {
                      this.account = NewAccount('Patient');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegisterCredentials(account)));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
          ]),
        ),
      ),
    );
  }
}

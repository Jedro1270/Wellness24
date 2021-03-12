import 'package:flutter/material.dart';
import 'package:wellness24/components/common/text_input.dart';
import 'package:wellness24/components/pages/doctor_home_page.dart';
import 'package:wellness24/components/pages/doctor_registration.dart';

class DoctorLogin extends StatefulWidget {
  @override
  _DoctorLoginState createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 35.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 120),
                child: Text(
                  "Doctor",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontFamily: "ShipporiMincho",
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 50.0),
              SizedBox(
                  height: 60.0,
                  child: TextInput(
                    hint: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                  )),
              SizedBox(height: 30.0),
              SizedBox(
                  height: 60.0,
                  child: TextInput(
                    hint: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  )),
              SizedBox(height: 20.0),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 150.0,
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(color: Colors.black12)),
                          color: Colors.grey.withOpacity(0.5),
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 15.0),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DoctorHomePage()));
                          },
                          child: Text("Login",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 25,
                                  fontFamily: "ShipporiMincho",
                                  fontWeight: FontWeight.normal))),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            MaterialPageRoute(
                                builder: (context) => DoctorRegistration()));
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
            ],
          ),
        ),
      ),
    );
  }
}

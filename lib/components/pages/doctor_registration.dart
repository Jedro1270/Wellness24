import 'package:flutter/material.dart';
import 'package:wellness24/components/common/text_input.dart';
import 'package:wellness24/components/pages/doctor_login.dart';
import 'package:wellness24/components/pages/doctor_personal_info.dart';

class DoctorRegistration extends StatefulWidget {
  @override
  _DoctorRegistrationState createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 35.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 100),
                  child: Text(
                    "Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 50.0),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (val) =>
                      val.isEmpty ? 'This field is required' : null,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                ),
                SizedBox(height: 30.0),
                TextFormField(
                    decoration: InputDecoration(hintText: 'Contact Number'),
                    validator: (val) =>
                        val.isEmpty ? 'This field is required' : null,
                    keyboardType: TextInputType.number,
                    obscureText: false),
                SizedBox(height: 30.0),
                TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (val) => val.isEmpty
                        ? 'This field is required'
                        : val.length < 6
                            ? 'Enter a password 6+ characters long'
                            : null,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true),
                SizedBox(height: 20.0),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 250.0,
                        child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: BorderSide(color: Colors.black12)),
                            color: Colors.grey.withOpacity(0.5),
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 15.0),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorPersonalInfo()));
                              }
                            },
                            child: Text("Create Account",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an account?",
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
                                  builder: (context) => DoctorLogin()));
                        },
                        child: Text(
                          "Login.",
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
      ),
    );
  }
}

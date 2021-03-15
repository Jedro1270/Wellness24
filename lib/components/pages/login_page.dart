import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/doctor_screen/doctor_home_page.dart';
// import 'package:wellness24/components/pages/doctor_registration.dart';
import 'package:wellness24/components/pages/sign_up_option.dart';
import 'package:wellness24/services/auth_service.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email, password;
  String error = '';

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
                  "Login",
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
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    validator: (val) =>
                        val.isEmpty ? 'This field is required' : null,
                    onChanged: (val) => setState(() => email = val),
                  )),
              SizedBox(height: 30.0),
              SizedBox(
                  height: 60.0,
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (val) =>
                        val.isEmpty ? 'This field is required' : null,
                    onChanged: (val) => setState(() => password = val),
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
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);

                              if (result == null) {
                                setState(() => error = 'Invalid credentials');
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorHomePage()));
                              }
                            }
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
              SizedBox(height: 10.0),
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              SizedBox(height: 10.0),
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
                                builder: (context) => SignupOption()));
                      },
                      child: Text(
                        "Sign up.",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.normal),
                      ),
                    ),
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

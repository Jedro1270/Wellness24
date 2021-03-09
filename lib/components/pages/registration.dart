import 'package:flutter/material.dart';
import 'package:wellness24/components/common/text_input.dart';

class Registration extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Registration> {
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
                    style: TextStyle(color: Colors.black, fontSize: 35),
                  ),
                ),
                SizedBox(height: 50.0),
                TextInput(hint: 'Email', keyboardType: TextInputType.emailAddress),
                SizedBox(height: 30.0),
                TextInput(hint: 'Contact Number', keyboardType: TextInputType.number),
                SizedBox(height: 30.0),
                TextInput(hint: 'Password', keyboardType: TextInputType.visiblePassword),
                SizedBox(height: 20.0),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.black12)),
                    color: Colors.grey.withOpacity(0.5),
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 15.0),
                    onPressed: () {},
                    child: Text("Login",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 25,
                        ))),
                SizedBox(height: 20.0),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.black87),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: null,
                        child: Text(
                          "Sign up.",
                          style: TextStyle(color: Colors.blueAccent),
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

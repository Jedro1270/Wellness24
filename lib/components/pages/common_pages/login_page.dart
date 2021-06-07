import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/common_pages/home_page.dart';
import 'package:wellness24/components/pages/common_pages/sign_up_option.dart';
import 'package:wellness24/services/auth_service.dart';
import 'package:wellness24/components/common/loading_animation.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService(auth: FirebaseAuth.instance);
  String email, password;
  bool hidePassword = true;

  String error = '';
  bool timeout = false;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 35.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 60.0),
                    Container(
                      padding: EdgeInsets.only(top: 120.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/wellness24logo.jpg'),
                          alignment: Alignment.center
                        )
                      ),
                      // child: Text(
                      //   "Login",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 40,
                      //       fontFamily: "ShipporiMincho",
                      //       fontWeight: FontWeight.bold),
                      // ),
                    ),
                    SizedBox(height: 50.0),
                    SizedBox(
                        height: 60.0,
                        child: TextFormField(
                          key: Key('emailField'),
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
                        child: Row(
                          children: [
                            Expanded(
                              flex: 9,
                              child: TextFormField(
                                key: Key('passwordField'),
                                decoration:
                                    InputDecoration(hintText: 'Password'),
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: hidePassword,
                                validator: (val) => val.isEmpty
                                    ? 'This field is required'
                                    : null,
                                onChanged: (val) =>
                                    setState(() => password = val),
                              ),
                            ),
                            Expanded(
                                child: IconButton(
                                    icon: Icon(hidePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    }))
                          ],
                        )),
                    SizedBox(height: 20.0),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 150.0,
                            child: MaterialButton(
                                key: Key('loginButton'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: Colors.black12)),
                                color: Colors.grey.withOpacity(0.5),
                                minWidth: MediaQuery.of(context).size.width,
                                padding:
                                    EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 15.0),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    dynamic result = await _auth
                                        .signInWithEmailAndPassword(
                                            email, password)
                                        .timeout(Duration(seconds: 120),
                                            onTimeout: () {
                                      timeout = true;
                                      return null;
                                    });

                                    if (result == null) {
                                      setState(() {
                                        if (timeout) {
                                          error =
                                              'The connection has timed out, please try again';
                                          timeout = false;
                                        } else {
                                          error = 'Invalid credentials';
                                        }
                                        loading = false;
                                      });
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
                            key: Key('signup'),
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

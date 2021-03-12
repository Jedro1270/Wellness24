import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/doctor_home_page.dart';
import 'package:wellness24/models/new_account.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';

class DoctorProfessionInfo extends StatefulWidget {
  final NewAccount account;
  DoctorProfessionInfo(this.account);

  @override
  _DoctorProfessionInfoState createState() =>
      _DoctorProfessionInfoState(account);
}

class _DoctorProfessionInfoState extends State<DoctorProfessionInfo> {
  final _formKey = GlobalKey<FormState>();
  String specialization = 'General Medicine';
  NewAccount account;
  String licenseNo, clinicLoc, clinicStart, clinicEnd;

  _DoctorProfessionInfoState(this.account);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 25.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Text(
                  "Doctor Information Form",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "ShipporiMincho",
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Specialization",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "ShipporiMincho",
                              fontWeight: FontWeight.normal),
                        ),
                      ]),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                        child: DropdownButton(
                          value: specialization,
                          items: [
                            DropdownMenuItem(
                              child: Text("General Medicine",
                                  style:
                                      TextStyle(fontFamily: "ShipporiMincho")),
                              value: "General Medicine",
                            ),
                            DropdownMenuItem(
                              child: Text("Neurologist",
                                  style:
                                      TextStyle(fontFamily: "ShipporiMincho")),
                              value: "Neurologist",
                            ),
                            DropdownMenuItem(
                              child: Text("Psychiatrist",
                                  style:
                                      TextStyle(fontFamily: "ShipporiMincho")),
                              value: "Psychiatrist",
                            ),
                            DropdownMenuItem(
                              child: Text("Pediatrician",
                                  style:
                                      TextStyle(fontFamily: "ShipporiMincho")),
                              value: "Pediatrician",
                            )
                          ],
                          onChanged: (val) =>
                              setState(() => specialization = val),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(children: <Widget>[
                    Text(
                      "License No.",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.normal),
                    ),
                  ]),
                ),
                SizedBox(
                    height: 50,
                    child: TextFormField(
                        obscureText: false,
                        onChanged: (val) => setState(() => licenseNo = val),
                        validator: (val) =>
                            val.isEmpty ? 'This field is required' : null)),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Clinic Location",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                      obscureText: false,
                      onChanged: (val) => setState(() => clinicLoc = val),
                      validator: (val) =>
                          val.isEmpty ? 'This field is required' : null),
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(children: <Widget>[
                    Text(
                      "Clinic Hours.",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.normal),
                    ),
                  ]),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                            obscureText: false,
                            onChanged: (val) =>
                                setState(() => clinicStart = val),
                            validator: (val) =>
                                val.isEmpty ? 'This field is required' : null),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "to",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "ShipporiMincho"),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                            obscureText: false,
                            onChanged: (val) => setState(() => clinicEnd = val),
                            validator: (val) =>
                                val.isEmpty ? 'This field is required' : null),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
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
                              User doctor = await account.registerDoctor(
                                  licenseNo: licenseNo,
                                  clinicLocation: clinicLoc,
                                  clinicStart: clinicStart,
                                  clinicEnd: clinicEnd,
                                  specialization: specialization);

                              final database = DatabaseService(uid: doctor.uid);

                              database.insertDoctor(account);

                              if (doctor != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorHomePage()));
                              }
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 25,
                                fontFamily: "ShipporiMincho",
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

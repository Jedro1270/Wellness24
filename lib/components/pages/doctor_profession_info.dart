import 'package:flutter/material.dart';
import 'package:wellness24/components/common/text_input.dart';
import 'package:wellness24/components/pages/doctor_home_page.dart';
import 'package:wellness24/models/new_account.dart';

class DoctorProfessionInfo extends StatefulWidget {
  final NewAccount account;
  DoctorProfessionInfo(this.account);

  @override
  _DoctorProfessionInfoState createState() =>
      _DoctorProfessionInfoState(account);
}

class _DoctorProfessionInfoState extends State<DoctorProfessionInfo> {
  int selectedValue = 1;
  NewAccount account;
  String licenseNo, clinicLoc, clinicStart, clinicEnd;

  _DoctorProfessionInfoState(this.account);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 25.0),
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
                      "Profession",
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
                      value: selectedValue,
                      items: [
                        DropdownMenuItem(
                          child: Text("Profession 1",
                              style: TextStyle(fontFamily: "ShipporiMincho")),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("Profession 2",
                              style: TextStyle(fontFamily: "ShipporiMincho")),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text("Profession 3",
                              style: TextStyle(fontFamily: "ShipporiMincho")),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text("Profession 4",
                              style: TextStyle(fontFamily: "ShipporiMincho")),
                          value: 4,
                        )
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
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
            SizedBox(height: 50, child: TextInput(obscureText: false)),
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
              child: TextInput(obscureText: false),
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
                    child: TextInput(
                      obscureText: false,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "to",
                    style:
                        TextStyle(fontSize: 20, fontFamily: "ShipporiMincho"),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 150,
                    child: TextInput(
                      obscureText: false,
                    ),
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
                      onPressed: () {
                        print(account);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => DoctorHomePage()));
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
        ),
      ),
    );
  }
}

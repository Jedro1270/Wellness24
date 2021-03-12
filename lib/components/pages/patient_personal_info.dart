import 'package:flutter/material.dart';
import 'package:wellness24/components/common/text_input.dart';
import 'package:wellness24/components/pages/patient_emergency_contact_info.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  dynamic selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 25.0),
        child: ListView(
          children: <Widget>[
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 80.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Personal Information Form",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(children: <Widget>[
                Text(
                  "Last Name",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "ShipporiMincho",
                      fontWeight: FontWeight.normal),
                ),
              ]),
            ),
            SizedBox(height: 10),
            SizedBox(height: 50, child: TextInput(obscureText: false)),
            SizedBox(height: 15),
            Container(
              child: Row(children: <Widget>[
                Text(
                  "First Name",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "ShipporiMincho",
                      fontWeight: FontWeight.normal),
                ),
              ]),
            ),
            SizedBox(height: 10),
            SizedBox(height: 50, child: TextInput(obscureText: false)),
            SizedBox(height: 15),
            Container(
              child: Row(children: <Widget>[
                Text(
                  "Middile Name",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "ShipporiMincho",
                      fontWeight: FontWeight.normal),
                ),
              ]),
            ),
            SizedBox(height: 10),
            SizedBox(height: 50, child: TextInput(obscureText: false)),
            Text(
              "Gender",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "ShipporiMincho",
                  fontWeight: FontWeight.normal),
            ),
            Container(
              child: Row(children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: selectedRadio,
                  activeColor: Colors.blueAccent,
                  onChanged: (val) {
                    print("Radio $val");
                    setSelectedRadio(val);
                  },
                ),
                Text(
                  "Male",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "ShipporiMincho",
                      fontWeight: FontWeight.normal),
                ),
                Radio(
                  value: 2,
                  groupValue: selectedRadio,
                  activeColor: Colors.blueAccent,
                  onChanged: (val) {
                    print("Radio $val");
                    setSelectedRadio(val);
                  },
                ),
                Text(
                  "Female",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "ShipporiMincho",
                      fontWeight: FontWeight.normal),
                )
              ]),
            ),
            SizedBox(height: 15),
            Container(
              child: Row(children: <Widget>[
                Text("Birth Date",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.normal)),
              ]),
            ),
            SizedBox(height: 5),
            SizedBox(height: 50, child: TextInput(hint: "mm-dd-yy",obscureText: false)),
            SizedBox(height: 15),
            Container(
              child: Row(children: <Widget>[
                Text("Address",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "ShipporiMincho",
                        fontWeight: FontWeight.normal)),
              ]),
            ),
            SizedBox(height: 5),
            SizedBox(height: 50, child: TextInput(obscureText: false)),
            SizedBox(height: 50),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_forward_sharp, size: 45),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmergencyContantInfo()),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

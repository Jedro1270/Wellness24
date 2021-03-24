import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wellness24/components/pages/patient_screen/medical_histories/medical_history.dart';
import 'package:wellness24/models/emergency_contact.dart';
import 'package:wellness24/models/new_account.dart';

class EmergencyContactInfo extends StatefulWidget {
  final NewAccount account;
  EmergencyContactInfo(this.account);
  @override
  _EmergencyContactInfoState createState() =>
      _EmergencyContactInfoState(account);
}

class _EmergencyContactInfoState extends State<EmergencyContactInfo> {
  final NewAccount account;
  final _formKey = GlobalKey<FormState>();
  String lastName,
      firstName,
      middleInitial,
      gender,
      birthDate,
      address,
      contactNo,
      relationship;

  _EmergencyContactInfoState(this.account);

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
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Emergency Contact Information",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.bold),
                      ),
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
                SizedBox(height: 5),
                TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
                    obscureText: false,
                    onChanged: (val) => setState(() => lastName = val),
                    validator: (val) =>
                        val.isEmpty ? 'This field is required' : null),
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
                SizedBox(height: 5),
                TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
                    obscureText: false,
                    onChanged: (val) => setState(() => firstName = val),
                    validator: (val) =>
                        val.isEmpty ? 'This field is required' : null),
                SizedBox(height: 15),
                Container(
                  child: Row(children: <Widget>[
                    Text(
                      "Middle Initial",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.normal),
                    ),
                  ]),
                ),
                SizedBox(height: 5),
                TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
                    obscureText: false,
                    onChanged: (val) => setState(() => middleInitial = val),
                    validator: (val) => val.isEmpty
                        ? 'This field is required'
                        : val.length > 1
                            ? 'Please enter 1 character only'
                            : null),
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
                TextFormField(
                    obscureText: false,
                    onChanged: (val) => setState(() => address = val),
                    validator: (val) =>
                        val.isEmpty ? 'This field is required' : null),
                SizedBox(height: 15),
                Container(
                  child: Row(children: <Widget>[
                    Text("Contact Number",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.normal)),
                  ]),
                ),
                SizedBox(height: 5),
                TextFormField(
                    obscureText: false,
                    onChanged: (val) => setState(() => contactNo = val),
                    validator: (val) =>
                        val.isEmpty ? 'This field is required' : null),
                SizedBox(height: 15),
                Container(
                  child: Row(children: <Widget>[
                    Text("Relationship",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.normal)),
                  ]),
                ),
                SizedBox(height: 5),
                TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
                    obscureText: false,
                    onChanged: (val) => setState(() => relationship = val),
                    validator: (val) =>
                        val.isEmpty ? 'This field is required' : null),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_forward_sharp, size: 45),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            account.addEmergencyContact(EmergencyContact(
                                lastName: lastName,
                                firstName: firstName,
                                middleInitial: middleInitial,
                                address: address,
                                contactNo: contactNo,
                                relationship: relationship));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MedicalHistory(account)),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

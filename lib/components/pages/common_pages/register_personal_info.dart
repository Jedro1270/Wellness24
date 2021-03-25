import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wellness24/components/pages/common_pages/register_next_step.dart';
import 'package:wellness24/models/new_account.dart';

class RegisterPersonalInfo extends StatefulWidget {
  final NewAccount account;
  RegisterPersonalInfo(this.account);

  @override
  _RegisterPersonalInfoState createState() =>
      _RegisterPersonalInfoState(this.account);
}

class _RegisterPersonalInfoState extends State<RegisterPersonalInfo> {
  final _formKey = GlobalKey<FormState>();
  String selectedRadio, lastName, firstName, middleInitial, address;
  DateTime _date = DateTime.now();
  DateFormat format = DateFormat.yMd();
  NewAccount account;

  _RegisterPersonalInfoState(this.account);

  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedRadio = '';
  }

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
                SizedBox(
                    height: 50,
                    child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp("[0-9]"))
                        ],
                        obscureText: false,
                        onChanged: (val) => setState(() => lastName = val),
                        validator: (val) =>
                            val.isEmpty ? 'This field is required' : null)),
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
                SizedBox(
                    height: 50,
                    child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp("[0-9]"))
                        ],
                        obscureText: false,
                        onChanged: (val) => setState(() => firstName = val),
                        validator: (val) =>
                            val.isEmpty ? 'This field is required' : null)),
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
                SizedBox(height: 10),
                SizedBox(
                    height: 50,
                    child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp("[0-9]"))
                        ],
                        obscureText: false,
                        onChanged: (val) => setState(() => middleInitial = val),
                        validator: (val) => val.isEmpty
                            ? 'This field is required'
                            : val.length > 1
                                ? 'Please enter 1 character only'
                                : null)),
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
                      value: 'Male',
                      groupValue: selectedRadio,
                      activeColor: Colors.blueAccent,
                      onChanged: (val) => setState(() => selectedRadio = val),
                    ),
                    Text(
                      "Male",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.normal),
                    ),
                    Radio(
                        value: 'Female',
                        groupValue: selectedRadio,
                        activeColor: Colors.blueAccent,
                        onChanged: (val) =>
                            setState(() => selectedRadio = val)),
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
                    SizedBox(width: 10),
                    Text("(mm/dd/yyyy)",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.normal)),
                  ]),
                ),
                SizedBox(height: 5),
                MaterialButton(
                    color: Colors.black12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("${format.format(_date)}",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "ShipporiMincho",
                                color: Colors.black)),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        _selectDate(context);
                      });
                    }),
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
                SizedBox(
                    height: 50,
                    child: TextFormField(
                        obscureText: false,
                        onChanged: (val) => setState(() => address = val),
                        validator: (val) =>
                            val.isEmpty ? 'This field is required' : null)),
                SizedBox(height: 50),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_forward_sharp, size: 45),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            account.supplyPersonalInfo(
                                lastName: lastName,
                                firstName: firstName,
                                middleInitial: middleInitial,
                                gender: selectedRadio,
                                birthDate: _date,
                                address: address);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegisterNextStep(account)));
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

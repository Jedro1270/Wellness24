import 'package:flutter/material.dart';
import 'package:wellness24/components/common/loading_animation.dart';
import 'package:wellness24/components/pages/common_pages/login_page.dart';
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
  String licenseNo,
      clinicLoc,
      clinicStart,
      clinicEnd,
      description,
      clinicDayStart,
      clinicDayEnd,
      education,
      about;
  bool loading = false;
  List _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List specializations = [
    'Family Physician',
    'Internal Medicine Physician',
    'Pediatrician',
    'Obstetrician/Gynecologist (OB/GYN)',
    'Surgeon',
    'Psychiatrist',
    'Cardiologist',
    'Dermatologist',
    'Endocrinologist',
    'Gastroenterologist',
    'Infectious Disease Physician',
    'Ophthalmologist',
    'Otolaryngologist',
    'Pulmonologist',
    'Nephrologist',
    'Oncologist',
    'General Medicine',
    'Neurologist',
  ];

  _DoctorProfessionInfoState(this.account);

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                                items: specializations.map((value) {
                                  return DropdownMenuItem(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(
                                              fontFamily: "ShipporiMincho")));
                                }).toList(),
                                onChanged: (value) =>
                                    setState(() => specialization = value),
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
                              onChanged: (val) =>
                                  setState(() => licenseNo = val),
                              validator: (val) => val.isEmpty
                                  ? 'This field is required'
                                  : null)),
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
                            "Clinic Days.",
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
                              // child: TextFormField(
                              //     obscureText: false,
                              //     onChanged: (val) =>
                              //         setState(() => clinicStart = val),
                              //     validator: (val) => val.isEmpty
                              //         ? 'This field is required'
                              //         : null),

                              child: DropdownButton(
                                hint: Text("Select Day"),
                                value: clinicDayStart,
                                icon: Icon(Icons.arrow_drop_down),
                                onChanged: (value) {
                                  setState(() {
                                    clinicDayStart = value;
                                  });
                                },
                                items: _days.map((value) {
                                  return DropdownMenuItem(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(
                                              fontFamily: "ShipporiMincho")));
                                }).toList(),
                              ),
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
                              child: DropdownButton(
                                hint: Text("Select Day"),
                                value: clinicDayEnd,
                                icon: Icon(Icons.arrow_drop_down),
                                onChanged: (value) {
                                  setState(() {
                                    clinicDayEnd = value;
                                  });
                                },
                                items: _days.map((value) {
                                  return DropdownMenuItem(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(
                                              fontFamily: "ShipporiMincho")));
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Clinic Hours.",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.normal),
                      ),
                      Container(
                        child: Row(children: <Widget>[
                          SizedBox(
                            width: 150,
                            child: TextFormField(
                                obscureText: false,
                                onChanged: (val) =>
                                    setState(() => clinicStart = val),
                                validator: (val) => val.isEmpty
                                    ? 'This field is required'
                                    : null),
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
                                onChanged: (val) =>
                                    setState(() => clinicEnd = val),
                                validator: (val) => val.isEmpty
                                    ? 'This field is required'
                                    : null),
                          ),
                        ]),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Row(children: <Widget>[
                          Text(
                            "Educational Attainment",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "ShipporiMincho",
                                fontWeight: FontWeight.normal),
                          ),
                        ]),
                      ),
                      SizedBox(
                          height: 60,
                          child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 50,
                              obscureText: false,
                              onChanged: (val) =>
                                  setState(() => education = val),
                              validator: (val) => val.isEmpty
                                  ? 'This field is required'
                                  : null)),
                      SizedBox(height: 20.0),
                      Container(
                        child: Row(children: <Widget>[
                          Text(
                            "About",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "ShipporiMincho",
                                fontWeight: FontWeight.normal),
                          ),
                        ]),
                      ),
                      SizedBox(
                          height: 100,
                          child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              minLines: 5,
                              maxLines: 50,
                              obscureText: false,
                              onChanged: (val) =>
                                  setState(() => about = val),
                              validator: (val) => val.isEmpty
                                  ? 'This field is required'
                                  : null)),
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
                                padding:
                                    EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 15.0),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });

                                    User doctor = await account.registerDoctor(
                                        licenseNo: licenseNo,
                                        clinicLocation: clinicLoc,
                                        clinicStart: clinicStart,
                                        clinicEnd: clinicEnd,
                                        specialization: specialization,
                                        workingDays: '$clinicDayStart to $clinicDayEnd',
                                        education: education,
                                        about: about);

                                    final database =
                                        DatabaseService(uid: doctor.uid);

                                    await database.insertDoctor(account);

                                    if (doctor == null) {
                                      setState(() {
                                        // TO DO: add error message
                                        loading = false;
                                      });
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Login()));
                                    }
                                  }
                                },
                                child: Text(
                                  "Register",
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

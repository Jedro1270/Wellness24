import 'package:flutter/material.dart';

class DoctorInfo extends StatelessWidget {
  final String firstName;
  final String middleInitial;
  final String lastName;

  DoctorInfo({this.firstName, this.middleInitial, this.lastName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(10.0),
      height: 200,
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10,
        child: Container(
          child: Row(
            children: <Widget>[
              SizedBox(width: 15),
              CircleAvatar(
                radius: 25.0,
                child: Icon(Icons.person),
              ),
              SizedBox(width: 15),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Doctor $firstName $middleInitial. $lastName",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center),
                    Text("Profession",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center),
                    Text("Clinic Hours",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center),
                    Text("Contact Number",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center),
                    Text("Location",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "ShipporiMincho",
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

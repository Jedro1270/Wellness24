import 'package:flutter/material.dart';

class DoctorSearchPage extends StatefulWidget {
  @override
  _DoctorSearchPageState createState() => _DoctorSearchPageState();
}

class _DoctorSearchPageState extends State<DoctorSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.home_outlined),
            iconSize: 30.0,
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 30),
            Container(
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
                            Text("Doctor Abagat",
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
            ),
            SizedBox(height: 20),
            Container(
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
                            Text("Doctor Capacio",
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
            ),
            SizedBox(height: 20),
            Container(
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
                            Text("Doctor Pagayonan",
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
            ),
          ],
        ),
      ),
    );
  }
}

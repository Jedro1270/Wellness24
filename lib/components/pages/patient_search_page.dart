import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/doctor_info_page.dart';

class PatientSearchPage extends StatefulWidget {
  @override
  _PatientSearchPageState createState() => _PatientSearchPageState();
}

class _PatientSearchPageState extends State<PatientSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Patients',
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
                            Text("Darla Abagat",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "ShipporiMincho",
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            Text("Contact Number",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "ShipporiMincho",
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center),
                            Container(
                              child: Row(
                                //  mainAxisAlignment: MainAxisAlignment.center,
                                //  crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.medical_services_outlined),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Icon(Icons.receipt_rounded),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Icon(Icons.message)
                                ],
                              ),
                            )
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
                            Text("Veto Rhyss",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "ShipporiMincho",
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            Text("Contact Number",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "ShipporiMincho",
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center),
                            Container(
                              child: Row(
                                //  mainAxisAlignment: MainAxisAlignment.center,
                                //  crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.medical_services_outlined),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Icon(Icons.receipt_rounded),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Icon(Icons.message)
                                ],
                              ),
                            )
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
                            Text("Vienne Capacio",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "ShipporiMincho",
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            Text("Contact Number",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "ShipporiMincho",
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center),
                            Container(
                              child: Row(
                                //  mainAxisAlignment: MainAxisAlignment.center,
                                //  crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.medical_services_outlined),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Icon(Icons.receipt_rounded),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Icon(Icons.message)
                                ],
                              ),
                            )
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

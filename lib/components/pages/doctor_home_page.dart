import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/patient_search_page.dart';
import 'package:wellness24/components/common/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/components/pages/login_page.dart';

class DoctorHomePage extends StatefulWidget {
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Login();
    }

    return Scaffold(
      drawer: NavBar(),
      appBar: CustomAppBar(
        title: 'Home Page',
        actions: [
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                print("Clicked Notif icon");
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          print("Message Icon click");
        },
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 320,
                    child: TextField(
                      decoration: InputDecoration(
                        // labelText: 'Search Doctor',
                        hintText: 'Search Patient',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PatientSearchPage()));
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(child: Icon(Icons.filter_list)),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              padding: EdgeInsets.only(left: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Image(image: AssetImage("assets/mypatient.png")),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "My patients",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Image(image: AssetImage("assets/schedule.png")),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "My Appointments",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

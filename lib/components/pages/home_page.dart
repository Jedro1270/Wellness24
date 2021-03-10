import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';
import 'package:wellness24/components/pages/emergency_page.dart';

import 'doctor_search_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home Page',
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              print('menu button pressed');
            }),
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
      body: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search Doctor',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorSearchPage()));
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Icon(Icons.filter_list),
              ),
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text("EMERGENCY",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () {
                    print("EMERGENCY");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EmergencyPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                    primary: Colors.redAccent[700],
                  ),
                )
              ],
            ),
          ),
          Divider(height: 50, color: Colors.transparent),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text("Doctor's Info",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  onPressed: () {
                    print("Doctor's info");
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 150, vertical: 20),
                      primary: Colors.lightBlueAccent[100]),
                )
              ],
            ),
          ),
          Divider(height: 1, thickness: 2, color: Colors.lightBlueAccent[200]),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text("Schedule Appointment",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  onPressed: () {
                    print("Schedule Appointment");
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 102, vertical: 20),
                      primary: Colors.lightBlueAccent[100]),
                )
              ],
            ),
          ),
          Divider(height: 1, thickness: 2, color: Colors.lightBlueAccent[200]),
           Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text("My Medical Records",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "ShipporiMincho",
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  onPressed: () {
                    print("My Medical Records");
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 115, vertical: 20),
                      primary: Colors.lightBlueAccent[100]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

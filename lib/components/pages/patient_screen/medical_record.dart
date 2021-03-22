import 'package:flutter/material.dart';
import 'package:wellness24/components/common/app_bar.dart';

class MedicalRecords extends StatefulWidget {
  @override
  _MedicalRecordsState createState() => _MedicalRecordsState();
}

class _MedicalRecordsState extends State<MedicalRecords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Patient name here',
        actions: [
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                print('Notif button clicked');
              })
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: Text(
                'Medical Records',
                style: TextStyle(
                    fontFamily: 'ShipporiMincho',
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 10,
              child: Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Anemia',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'ShipporiMincho',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 150),
                    IconButton(
                      icon: Icon(Icons.edit),
                      iconSize: 30,
                      onPressed: () {
                        print('Edit');
                      },
                    ),
                    SizedBox(width: 5),
                    IconButton(
                      icon: Icon(Icons.delete),
                      iconSize: 30,
                      onPressed: () {
                        print('Delete');
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 5,
              child: Container(
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        print('Add');
                      },
                      icon: Icon(Icons.add,),
                      iconSize: 35,
                    )
                  ],)
              ),
            )
          ],
        ),
      ),
    );
  }
}

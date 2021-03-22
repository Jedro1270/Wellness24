import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {
  final String title;

  RecordCard({this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
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
              title,
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
    );
  }
}

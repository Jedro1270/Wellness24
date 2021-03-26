import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordCard extends StatelessWidget {
  final String title;
  final DateTime date;

  RecordCard({this.title, this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 80,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'ShipporiMincho',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              date == null ? '' : DateFormat.yMd().format(date),
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'ShipporiMincho',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final Function onTap;

  RecordCard({@required this.title, this.date, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
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
                  fontSize: 20,
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
      ),
    );
  }
}

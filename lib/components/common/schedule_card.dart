import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  String _date, _month, _title, _description;

  ScheduleCard(this._date, this._month, this._title, this._description);
  
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xff4B7FFB).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: Color(0xff4B7FFB).withOpacity(0.3),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: <Widget>[
                Text(
                  _date,
                  style: TextStyle(
                    color: Color(0xff4B7FFB),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "ShipporiMincho"
                  ),
                ),
                Text(
                  _month,
                  style: TextStyle(
                    color: Color(0xff4B7FFB),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "ShipporiMincho"
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            _title,
            style: TextStyle(
              fontFamily: "ShipporiMincho",
              fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Text(
            _description,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7)
            ),
          ),
        ),
      ),
    );
  }
}
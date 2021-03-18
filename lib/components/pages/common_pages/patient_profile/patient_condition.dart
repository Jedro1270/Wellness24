import 'package:flutter/material.dart';

class PatientCondition extends StatelessWidget {
  final bool editable;
  final Widget icon;
  final String content;
  final String title;

  PatientCondition({this.editable, this.icon, this.content, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Row(
          children: <Widget>[
            SizedBox(width: 10.0),
            SizedBox(
              height: 50,
              width: 50,
              child: icon
            ),
            SizedBox(width: 10.0),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    content,
                    style: TextStyle(
                        fontFamily: 'ShipporiMincho',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'ShipporiMincho',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

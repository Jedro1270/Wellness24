import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  String _firstName, _middleInitial, _lastName, _imageUrl;

  PatientCard(this._firstName, this._middleInitial, this._lastName, this._imageUrl);

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
          leading: ClipOval(
            child: Image(
              image: AssetImage('$_imageUrl'), // _imageUrl
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            '$_firstName $_middleInitial. $_lastName',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "ShipporiMincho",
              fontSize: 20
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Wellness24'),
        ),
        //icon: new Icon(Icons.home_filled)
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'components/pages/front_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellness24',
      home: FrontPage(),
    );
  }
}

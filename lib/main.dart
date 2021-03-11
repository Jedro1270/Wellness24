import 'package:flutter/material.dart';
import 'package:wellness24/components/auth/auth_wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellness24',
      home: AuthWrapper(),
    );
  }
}

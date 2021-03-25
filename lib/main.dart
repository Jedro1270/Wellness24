import 'package:flutter/material.dart';
import 'package:wellness24/components/auth/auth_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/services/auth_service.dart';
import 'package:wellness24/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Wellness24',
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(),
      ),
    );
  }
}

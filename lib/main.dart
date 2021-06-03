import 'package:catcher/catcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/auth/auth_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:wellness24/services/auth_service.dart';
import 'package:wellness24/models/user.dart';

void main() {
  CatcherOptions catcherOptions = CatcherOptions(
    DialogReportMode(),
    [
      EmailManualHandler(
        ['jedro1270@gmail.com'],
        emailHeader: 'Unexpected Error',
        emailTitle: 'Error Report Wellness24',
      )
    ],
  );

  Catcher(
    MyApp(),
    debugConfig: catcherOptions,
    releaseConfig: catcherOptions,
    profileConfig: catcherOptions,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: null,
      value: AuthService(auth: FirebaseAuth.instance).user,
      child: MaterialApp(
        navigatorKey: Catcher.navigatorKey,
        title: 'Wellness24',
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(),
      ),
    );
  }
}

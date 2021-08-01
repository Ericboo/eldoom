import 'package:eldoom/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color? primaryColor = Colors.lightBlue[500];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eldoom',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.grey[900],
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: primaryColor,
          ),
        ),
      ),
      home: Login(),
    );
  }
}

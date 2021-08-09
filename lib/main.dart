import 'package:eldoom/pages/login.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Color? primaryColor = Colors.black;
  final Color? backgroundColor = Colors.grey[200];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eldoom',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: Colors.grey,
        backgroundColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: primaryColor,
          ),
          hintStyle: TextStyle(
            color: primaryColor,
          ),
        ),
      ),
      home: Login(),
    );
  }
}

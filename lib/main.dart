import 'package:eldoom/pages/login.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color? primaryColor = Colors.lightBlue[500];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eldoom',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
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

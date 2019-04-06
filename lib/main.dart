import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          buttonColor: Colors.blue,
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(
                fontSize: 15,
                fontFamily: "TTCommons",
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          textTheme: TextTheme(
            body1: TextStyle(fontSize: 18, fontFamily: "TTCommons"),
            title: TextStyle(
                fontSize: 20,
                fontFamily: "TTCommons",
                fontWeight: FontWeight.bold),
            button: TextStyle(
                fontSize: 15,
                fontFamily: "TTCommons",
                fontWeight: FontWeight.bold,
                color: Colors.white70),
          )),
      home: HomeScreen(),
      routes: routes,
    );
  }
}

import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			theme: ThemeData(
				primarySwatch: Colors.lightBlue,
				textTheme: TextTheme(
					body1: TextStyle(fontSize: 18, fontFamily: "TTCommons"),
					title: TextStyle(fontSize: 20, fontFamily: "TTCommons", fontWeight: FontWeight.bold),
				)
			),
			home: HomeScreen(),
		);
	}
}

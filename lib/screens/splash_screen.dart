import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				color: Colors.redAccent.withOpacity(0.7).withAlpha(200),
				child: Center(
					child: Image.asset(
						"assets/images/splashart.png",
						scale: 1.25,
					),
				)
			),
			floatingActionButton: RaisedButton(
				child: Padding(
					padding: const EdgeInsets.all(10.0),
					child: Text(
						"Let's start focusing!",
						style: TextStyle(
								fontSize: 20,
								color: Colors.white.withAlpha(200),
								fontFamily: "TTCommons"),
					),
				),
				onPressed: () {
					Navigator.pop(context);
					Navigator.pushNamed(context, "/hs");
				},
				shape:
						RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
				elevation: 1,
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
		);
	}
}

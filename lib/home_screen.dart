import 'package:flutter/material.dart';
import 'radial_progress.dart';

class HomeScreen extends StatefulWidget {
	@override
	HomeScreenState createState() {
		return HomeScreenState();
	}
}

class HomeScreenState extends State<HomeScreen> {
	int curr, _work, _relax;
	int _tC;
	@override
	void initState() {
		_work = 10;
		_relax = 1;
		_tC = 0;
		curr = 0;
		super.initState();
	}

	void onTabTapped(int i) {
		setState(() {
			curr = i;
			_tC = 0;
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				decoration: BoxDecoration(
					image: DecorationImage(
						image: AssetImage("assets/images/backdrop.png"),
						fit: BoxFit.cover,
					)
				),
				child: Center(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						children: <Widget>[
							curr == 0 ? Text('Time Duration: $_work min.') : Text('Time Duration: $_relax min.'),
							RadialProgress(
								tT: curr == 0 ? _work * 60 : _relax * 60,
								mode: curr,
								tC: _tC,
								par: this,
							),
						],
					)),
			),
			bottomNavigationBar: BottomNavigationBar(
				onTap: (i) => onTabTapped(i),
				currentIndex: curr,
				items: [
					BottomNavigationBarItem(
						icon: Icon(Icons.work),
						title: Text('Work'),
					),
					BottomNavigationBarItem(
						icon: Icon(Icons.sentiment_very_satisfied),
						title: Text('Relax'),
					),
				],
			));
	}
}

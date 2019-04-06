import 'package:flutter/material.dart';
import '../widgets/radial_progress.dart';

class HomeScreen extends StatefulWidget {
	@override
	_HomeScreenState createState() {
		return _HomeScreenState();
	}
}

class _HomeScreenState extends State<HomeScreen>{
	Map<String, int> _tasks = {
		"15 minutes": 15*60,
		"30 minutes": 30*60,
		"45 minutes": 45*60,
		"60 minutes": 60*60
	};
	int _selectedTask;
	@override
  void initState() {
    _selectedTask = 15*60;
    super.initState();
  }
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: <Widget>[
						DropdownButton(
							hint: Text("Please select a Time Period"),
							value: _selectedTask,
							onChanged: (newValue) {
								setState(() {
									_selectedTask = newValue;
								});
							},
							items: (){
								List<DropdownMenuItem> itemsList = List<DropdownMenuItem>();
								_tasks.forEach((key, val){
									itemsList.add(
										DropdownMenuItem(
											child: Text(
												key,
												style: TextStyle(fontSize: 20, fontFamily: "TTCommons"),
											),
											value: val,
										)
									);
								});
								return itemsList;
							}()
						),
						RadialProgress(totalTime: _selectedTask),
						Column()
					],
				)
			),
		);
	}
}

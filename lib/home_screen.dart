import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'radial_progress.dart';
import 'settings_form.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  int currentIndex, _work, _relax;
  int _timeCompleted;
  @override
  void initState() {
    // setting default
    _work = 0;
    _relax = 0;
    _timeCompleted = 0;
    update();
    currentIndex = 0;
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      _timeCompleted = 0;
    });
  }

  void update() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _work = prefs.getInt("work");
      _relax = prefs.getInt("relax");

      // for opening the app 1st time
      if(_work == null || _relax == null)
      {
        _work = 10;
        _relax = 5;
        prefs.setInt("work", 10);
        prefs.setInt("relax", 5);
      }
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
          ),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            currentIndex == 0
                ? Text('Time Duration: $_work min.')
                : Text('Time Duration: $_relax min.'),
            RadialProgress(
              totalTime: currentIndex == 0 ? _work * 60 : _relax * 60,
              mode: currentIndex,
              timeCompleted: _timeCompleted,
              parent: this,
            ),
            Column()
          ],
        )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => onTabTapped(index),
        currentIndex: currentIndex,
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
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: SettingsForm(
                      parent: this,
                    ),
                  );
                });
          }),
    );
  }
}

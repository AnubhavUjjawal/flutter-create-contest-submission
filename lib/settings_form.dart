import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class SettingsForm extends StatefulWidget {
  HomeScreenState parent;
  SettingsForm({this.parent});
  @override
  _SettingsFormState createState() {
    return _SettingsFormState();
  }
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  int _work, _relax;
  bool _loadingData;

  @override
  void initState() {
    _loadingData = true;
    () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _work = prefs.getInt("work");
        _relax = prefs.getInt("relax");
        _loadingData = false;
      });
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingData) return Center(child: CircularProgressIndicator());
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: TextFormField(
                  initialValue:
                      _work.toString() == null ? "0" : _work.toString(),
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  decoration: InputDecoration(
                    labelText: 'Work Duration (in minutes)',
                    border: Theme.of(context).inputDecorationTheme.border,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter work  duration';
                    }
                  },
                  onSaved: (data) async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setInt("work", int.parse(data));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  initialValue:
                      _relax.toString() == null ? "0" : _relax.toString(),
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  decoration: InputDecoration(
                    labelText: 'Relax Duration (in minutes)',
                    border: Theme.of(context).inputDecorationTheme.border,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter relax duration';
                    }
                  },
                  onSaved: (data) async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setInt("relax", int.parse(data));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, we want to save data
                      _formKey.currentState.save();
                      widget.parent.update();
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save'),
                  textColor: Theme.of(context).textTheme.button.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

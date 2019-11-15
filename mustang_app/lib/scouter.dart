import 'package:flutter/material.dart';

import './header.dart';
import './mainscouter.dart';
import './bottomnavbar.dart';

class Scouter extends StatefulWidget {
  static const String route = '/Scouter';

  @override
  State<StatefulWidget> createState() {
    return new _ScouterState();
  }
}

class _ScouterState extends State<Scouter> {
  TextEditingController _teamNumberController = TextEditingController();
  TextEditingController _matchNumberController = TextEditingController();
  bool _submissionEnabled = false;
  bool _showError = false;
  String _startingHabLevel;

  void _checkReqs() {
    if (_matchNumberController.text != '' &&
        _teamNumberController.text != '' &&
        _startingHabLevel != null) {
      _submissionEnabled = true;
    } else {
      _submissionEnabled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(
          context,
          'Pre Scouting Info',
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 15),
              child: TextField(
                onChanged: (String s) => _checkReqs(),
                controller: _teamNumberController,
                decoration: InputDecoration(
                  labelText: 'Team Number',
                  errorText: _showError ? 'Team number is required' : null,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
              child: TextField(
                onChanged: (String s) => _checkReqs(),
                controller: _matchNumberController,
                decoration: InputDecoration(
                  labelText: 'Match Number',
                  errorText: _showError ? 'Match number is required' : null,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
              child: DropdownButton<String>(
                value: _startingHabLevel,
                hint: Text('Choose Starting HAB Level'),
                items: <String>['Base', 'Level 1', 'Level 2']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _startingHabLevel = value;
                    _checkReqs();
                  });
                },
              ),
            ),
            RaisedButton(
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _submissionEnabled
                        ? Navigator.pushNamed(context, MainScouter.route)
                        : _showError = true;
                  });
                },
                padding: EdgeInsets.all(15),
                child: Text(
                  'Start',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ))
          ],
        ),
        bottomNavigationBar: BottomNavBar(context),
      );
  }
}

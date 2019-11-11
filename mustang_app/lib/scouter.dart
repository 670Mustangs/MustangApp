import 'package:flutter/material.dart';

import './header.dart';
import './mainscouter.dart';

class Scouter extends StatefulWidget {
  static const String route = '/Scouter';

  @override
  State<StatefulWidget> createState() {
    return new _ScouterState();
  }
}

class _ScouterState extends State<Scouter> {
  TextEditingController _teamNumber = TextEditingController();
  TextEditingController _matchNumber = TextEditingController();
  bool _enabled = false;
  bool _error = false;
  String _selectedVal;

  void _checkReqs() {
    if (_matchNumber.text != '' &&
        _teamNumber.text != '' &&
        _selectedVal != null) {
      _enabled = true;
    } else {
      _enabled = false;
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
                controller: _teamNumber,
                decoration: InputDecoration(
                  labelText: 'Team Number',
                  errorText: _error ? 'Team number is required' : null,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
              child: TextField(
                onChanged: (String s) => _checkReqs(),
                controller: _matchNumber,
                decoration: InputDecoration(
                  labelText: 'Match Number',
                  errorText: _error ? 'Match number is required' : null,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
              child: DropdownButton<String>(
                value: _selectedVal,
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
                    _selectedVal = value;
                    _checkReqs();
                  });
                },
              ),
            ),
            RaisedButton(
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _enabled
                        ? Navigator.pushNamed(context, MainScouter.route)
                        : _error = true;
                  });
                },
                padding: EdgeInsets.all(15),
                child: Text(
                  'Start',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ))
          ],
        ));
  }
}

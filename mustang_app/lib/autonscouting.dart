import 'package:flutter/material.dart';

import './header.dart';
import './teleopscouting.dart';
import './databaseoperations.dart';

class AutonScouter extends StatefulWidget {
  static const String route = '/AutonScouter';
  String _teamNumber, _matchNumber;

  AutonScouter(String teamNumber, String matchNumber) {
    _teamNumber = teamNumber;
    _matchNumber = matchNumber;
  }
  @override
  State<StatefulWidget> createState() {
    return new _AutonScouterState(_teamNumber, _matchNumber);
  }
}

class _AutonScouterState extends State<AutonScouter> {
  String _teamNumber, _matchNumber;
  TextEditingController _bottomPortController = TextEditingController();
  TextEditingController _outerPortController = TextEditingController();
  TextEditingController _innerPortController = TextEditingController();
  bool _crossedInitiationLine = false;
  DatabaseOperations db = new DatabaseOperations();

  _AutonScouterState(teamNumber, matchNumber) {
    _teamNumber = teamNumber;
    _matchNumber = matchNumber;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(context, 'Auton'),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                child: SwitchListTile(
                  title: Text(
                    'Crossed initiation line?',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  value: _crossedInitiationLine,
                  onChanged: (bool value) {
                    setState(() {
                      _crossedInitiationLine = value;
                    });
                  },
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
                child: TextField(
                  controller: _bottomPortController,
                  decoration: InputDecoration(
                    labelText: 'Bottom Port',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
                child: TextField(
                  controller: _outerPortController,
                  decoration: InputDecoration(
                    labelText: 'Outer Port',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
                child: TextField(
                  controller: _innerPortController,
                  decoration: InputDecoration(
                    labelText: 'Inner Port',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  db.updateMatchDataAuton(_teamNumber, _matchNumber,
                      innerPort: int.parse(_innerPortController.text),
                      outerPort: int.parse(_outerPortController.text),
                      bottomPort: int.parse(_bottomPortController.text),
                      crossedLine: _crossedInitiationLine);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TeleopScouter(_teamNumber, _matchNumber)));
                  // Navigator.pushNamed(context, TeleopScouter.route);
                },
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                color: Colors.green,
                padding: EdgeInsets.all(15),
              ),
            ],
          ),
        ));
  }
}

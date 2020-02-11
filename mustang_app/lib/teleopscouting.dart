import 'package:flutter/material.dart';
import 'package:mustang_app/counter.dart';

import './endgamescouting.dart';
import './header.dart';
import './databaseoperations.dart';

class TeleopScouter extends StatefulWidget {
  static const String route = '/TeleopScouter';
  String _teamNumber, _matchNumber;

  TeleopScouter(teamNumber, matchNumber) {
    _teamNumber = teamNumber;
    _matchNumber = matchNumber;
  }

  @override
  State<StatefulWidget> createState() {
    return new _TeleopScouterState(_teamNumber, _matchNumber);
  }
}

class _TeleopScouterState extends State<TeleopScouter> {
  String _teamNumber;
  String _matchNumber;
  DatabaseOperations db = new DatabaseOperations();
  Counter _bottomPortController = Counter('Bottom Port');
  Counter _outerPortController = Counter('Outer Port');
  Counter _innerPortController = Counter('Inner Port');

  bool _rotationControl = false;
  bool _positionControl = false;

  _TeleopScouterState(teamNumber, matchNumber) {
    _teamNumber = teamNumber;
    _matchNumber = matchNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(
          context,
          'Teleop',
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
              child: _bottomPortController,
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
              child: _outerPortController,
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
              child: _innerPortController,
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: SwitchListTile(
                title: Text(
                  'Completed rotation control?',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                value: _rotationControl,
                onChanged: (bool value) {
                  setState(() {
                    _rotationControl = value;
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: SwitchListTile(
                title: Text(
                  'Completed position control?',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                value: _positionControl,
                onChanged: (bool value) {
                  setState(() {
                    _positionControl = value;
                    if (_positionControl) _rotationControl = true;
                  });
                },
              ),
            ),
            RaisedButton(
              color: Colors.green,
              onPressed: () {
                db.updateMatchDataTeleop(_teamNumber, _matchNumber,
                    bottomPort: _bottomPortController.count,
                    outerPort: _outerPortController.count,
                    innerPort: _innerPortController.count,
                    positionControl: _positionControl,
                    rotationControl: _rotationControl);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EndgameScouter(_teamNumber, _matchNumber)));
                // Navigator.pushNamed(context, EndgameScouter.route);
              },
              padding: EdgeInsets.all(15),
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}

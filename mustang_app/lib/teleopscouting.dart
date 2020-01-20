import 'package:flutter/material.dart';

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
  TextEditingController _bottomPortController = TextEditingController();
  TextEditingController _outerPortController = TextEditingController();
  TextEditingController _innerPortController = TextEditingController();

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
                  });
                },
              ),
            ),
            RaisedButton(
              color: Colors.green,
              onPressed: () {
                db.updateMatchDataTeleop(_teamNumber, _matchNumber,
                    bottomPort: int.parse(_bottomPortController.text),
                    outerPort: int.parse(_outerPortController.text),
                    innerPort: int.parse(_innerPortController.text),
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

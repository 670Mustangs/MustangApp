import 'package:flutter/material.dart';
import 'package:mustang_app/postscouter.dart';

import './header.dart';
import './databaseoperations.dart';
import './counter.dart';

class PitScouter extends StatefulWidget {
  static const String route = '/PitScouter';
  static String _teamNumber;

  PitScouter(teamNumber) {
    _teamNumber = teamNumber;
  }

  @override
  _PitScouterState createState() => _PitScouterState(_teamNumber);
}

class _PitScouterState extends State<PitScouter> {
  TextEditingController _exampleFieldController = new TextEditingController();
  DatabaseOperations db = new DatabaseOperations();
  String _teamNumber;
  var _drivebaseType;

  _PitScouterState(teamNumber) {
    _teamNumber = teamNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, 'Pit Scouting'),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
              child: Counter(),
            ),
            RaisedButton(
              onPressed: () {
                db.updatePitScouting(_teamNumber,
                    text: _exampleFieldController.text);
                Navigator.pushNamed(context, PostScouter.route);
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
      ),
    );
  }
}

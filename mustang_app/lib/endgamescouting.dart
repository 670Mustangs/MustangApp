import 'package:flutter/material.dart';

import './matchendscouting.dart';
import './databaseoperations.dart';
import './header.dart';

class EndgameScouter extends StatefulWidget {
  static const String route = '/EndgameScouter';
  String _teamNumber, _matchNumber;

  EndgameScouter(teamNumber, matchNumber) {
    _teamNumber = teamNumber;
    _matchNumber = matchNumber;
  }
  @override
  _EndgameScouterState createState() =>
      _EndgameScouterState(_teamNumber, _matchNumber);
}

class _EndgameScouterState extends State<EndgameScouter> {
  String _teamNumber;
  String _matchNumber;
  TextEditingController _bottomPortController = TextEditingController();
  TextEditingController _outerPortController = TextEditingController();
  TextEditingController _innerPortController = TextEditingController();
  TextEditingController _stagesCompletedController =
      new TextEditingController();
  String _endingState;
  DatabaseOperations db = new DatabaseOperations();

  _EndgameScouterState(teamNumber, matchNumber) {
    _teamNumber = teamNumber;
    _matchNumber = matchNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(
          context,
          'Endgame',
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
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
              child: TextField(
                controller: _stagesCompletedController,
                decoration: InputDecoration(
                  labelText: 'Stages Completed',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
              child: DropdownButton<String>(
                value: _endingState,
                hint: Text('Choose Ending State',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                items: <String>['None', 'Parked', 'Hanging']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _endingState = value;
                  });
                },
              ),
            ),
            RaisedButton(
                color: Colors.green,
                onPressed: () {
                  db.updateMatchDataEndgame(_teamNumber, _matchNumber,
                      bottomPort: int.parse(_bottomPortController.text),
                      outerPort: int.parse(_outerPortController.text),
                      innerPort: int.parse(_innerPortController.text),
                      stagesCompleted:
                          int.parse(_stagesCompletedController.text),
                      endState: _endingState);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MatchEndScouter(_teamNumber, _matchNumber)));
                  // Navigator.pushNamed(context, MatchEndScouter.route);
                },
                padding: EdgeInsets.all(15),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ))
          ],
        ));
  }
}

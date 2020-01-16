import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import './header.dart';
import './postscouter.dart';

class EndScouter extends StatefulWidget {
  static const String route = '/EndScouter';

  @override
  State<StatefulWidget> createState() {
    return new _EndScouterState();
  }
}

class _EndScouterState extends State<EndScouter> {
  final DBRef = FirebaseDatabase.instance.reference();
  TextEditingController _rocketsCompletedController = TextEditingController();
  TextEditingController _finalCommentsController = TextEditingController();
  TextEditingController _namesController = TextEditingController();
  bool _submissionEnabled = false;
  bool _showError = false;
  String _endingHabLevel;
  String _matchResult;
  bool _climbAssist = false;

  void _checkReqs() {
    if (_namesController.text != '' &&
        _finalCommentsController.text != '' &&
        _endingHabLevel != null) {
      _submissionEnabled = true;
    } else {
      _submissionEnabled = false;
    }
  }

  void writeData(num teamNumber) {
    DBRef.child("Match Scouting").child(teamNumber.toString()).set({
      //TODO json pairs
    });
  }

  void updateData(num teamNumber) {
    DBRef.child("Match Scouting").child(teamNumber.toString()).update({
      //TODO json pairs
    });
  }

  void readData() {
    DBRef.once().then((DataSnapshot data) {
      print(data.value);
    });
  }

  void deleteData(num teamNumber) {
    DBRef.child("Match Scouting").child(teamNumber.toString()).remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(
          context,
          'Match End Info',
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
              child: DropdownButton<String>(
                value: _endingHabLevel,
                hint: Text('Choose Ending HAB Level', style: TextStyle(color: Colors.black, fontSize: 20)),
                items: <String>['None', 'Base', 'Level 1', 'Level 2']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _endingHabLevel = value;
                    _checkReqs();
                  });
                },
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
              child: DropdownButton<String>(
                value: _matchResult,
                hint: Text('Choose Match Result', style: TextStyle(color: Colors.black, fontSize: 20)),
                items: <String>['Win', 'Lose', 'Tie']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _endingHabLevel = value;
                    _checkReqs();
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: SwitchListTile(
                title: Text(
                  'Provided climb assist?',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                value: _climbAssist,
                onChanged: (bool value) {
                  setState(() {
                    _climbAssist = value;
                  });
                },
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
              child: TextField(
                onChanged: (String s) => _checkReqs(),
                controller: _rocketsCompletedController,
                decoration: InputDecoration(
                  labelText: 'Rockets Completed',
                  errorText: _showError ? 'Field is required' : null,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
              child: TextField(
                onChanged: (String s) => _checkReqs(),
                controller: _finalCommentsController,
                decoration: InputDecoration(
                  labelText: 'Final Comments',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
              child: TextField(
                onChanged: (String s) => _checkReqs(),
                controller: _namesController,
                decoration: InputDecoration(
                  labelText: 'Name(s)',
                  errorText: _showError ? 'Field is required' : null,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            RaisedButton(
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _submissionEnabled
                        ? Navigator.pushNamed(context, PostScouter.route)
                        : _showError = true;
                  });
                },
                padding: EdgeInsets.all(15),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 20, color:Colors.white,),
                ))
          ],
        ));
  }
}

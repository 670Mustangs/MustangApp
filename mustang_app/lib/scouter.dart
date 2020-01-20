import 'package:flutter/material.dart';

import './header.dart';
import './autonscouting.dart';
import './bottomnavbar.dart';
import './databaseoperations.dart';

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
  bool _showError = false;
  DatabaseOperations db = new DatabaseOperations();

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
            padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 15),
            child: TextField(
              controller: _teamNumberController,
              decoration: InputDecoration(
                labelText: 'Team Number',
                errorText: _showError ? 'Team number is required' : null,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            child: TextField(
              controller: _matchNumberController,
              decoration: InputDecoration(
                labelText: 'Match Number',
                errorText: _showError ? 'Match number is required' : null,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          RaisedButton(
              color: Colors.green,
              onPressed: () {
                setState(() {
                  db.startNewMatch(
                      _teamNumberController.text, _matchNumberController.text);
                  print(_teamNumberController.text + "   " + _matchNumberController.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AutonScouter(
                              _teamNumberController.text,
                              _matchNumberController.text)));
                  // Navigator.pushNamed(context, AutonScouter.route);
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

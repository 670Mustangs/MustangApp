import 'package:flutter/material.dart';
import 'package:mustang_app/endscouter.dart';

import './header.dart';
import './endscouter.dart';

class MainScouter extends StatefulWidget {
  static const String route = '/MainScouter';

  @override
  State<StatefulWidget> createState() {
    return new _MainScouterState();
  }
}

class _MainScouterState extends State<MainScouter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(context, 'Main Scouting'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, EndScouter.route);
              },
              child: Text(
                'Next',
                style: TextStyle(fontSize: 30),
              ),
              color: Colors.greenAccent,
              padding: EdgeInsets.all(30),
            ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(context, 'Main Scouting'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PostScouter.route);
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 30),
              ),
              color: Colors.greenAccent,
              padding: EdgeInsets.all(30),
            ),
          ],
        ));
  }
}

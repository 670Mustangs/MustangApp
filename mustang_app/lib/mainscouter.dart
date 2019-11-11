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
        body: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text('Hatch', style: TextStyle(fontSize: 25))),
                      Container(
                        width: 200,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Ship',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Rocket L1',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Rocket L2',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Rocket L3',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text('Cargo', style: TextStyle(fontSize: 25))),
                      Container(
                        width: 200,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Ship',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Rocket L1',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Rocket L2',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Rocket L3',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 30),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Fouls',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, EndScouter.route);
                },
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 30),
                ),
                color: Colors.greenAccent,
                padding: EdgeInsets.all(15),
              ),
            ],
          ),
        ));
  }
}

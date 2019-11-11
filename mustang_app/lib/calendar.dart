import 'package:flutter/material.dart';

import './header.dart';

class Calendar extends StatefulWidget {
  static const String route = '/Calendar';
  @override
  State<StatefulWidget> createState() {
    return new _CalendarState();
  }
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        context,
        'Calendar'
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text('TO BE IMPLEMENTED', style: TextStyle(color: Colors.white)),
              padding: EdgeInsets.all(10),
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}

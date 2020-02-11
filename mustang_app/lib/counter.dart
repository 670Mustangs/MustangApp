import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;
  
  int get count {
    return _count;
  }

  void add() {
    setState(() {
      _count++;
    });
  }

  void minus() {
    setState(() {
      if (_count != 0) _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 50),
              child: new Text(
                'Example',
                style: new TextStyle(fontSize: 30.0),
              ),
            ),
            new IconButton(
              onPressed: add,
              color: Colors.green,
              icon: new Icon(
                Icons.add_circle,
                size: 35,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: new Text(
                '$_count',
                style: new TextStyle(fontSize: 30.0),
              ),
            ),
            new IconButton(
              color: Colors.green,
              onPressed: minus,
              icon: new Icon(
                Icons.remove_circle,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

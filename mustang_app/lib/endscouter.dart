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
  TextEditingController _finalComments = TextEditingController();
  TextEditingController _names = TextEditingController();
  bool _enabled = false;
  bool _error = false;
  String _selectedVal;
  bool _val = false;

  void _checkReqs() {
    if (_names.text != '' &&
        _finalComments.text != '' &&
        _selectedVal != null) {
      _enabled = true;
    } else {
      _enabled = false;
    }
  }

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
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
              child: DropdownButton<String>(
                value: _selectedVal,
                hint: Text('Choose Starting HAB Level', style: TextStyle(color: Colors.black, fontSize: 20)),
                items: <String>['None', 'Base', 'Level 1', 'Level 2']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedVal = value;
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
                value: _val,
                onChanged: (bool value) {
                  setState(() {
                    _val = value;
                  });
                },
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 30),
              child: TextField(
                onChanged: (String s) => _checkReqs(),
                controller: _finalComments,
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
                controller: _names,
                decoration: InputDecoration(
                  labelText: 'Name(s)',
                  errorText: _error ? 'Name is required' : null,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            RaisedButton(
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _enabled
                        ? Navigator.pushNamed(context, PostScouter.route)
                        : _error = true;
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

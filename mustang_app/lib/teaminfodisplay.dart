import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mustang_app/header.dart';

class TeamInfoDisplay extends StatelessWidget {

  String _team;

  TeamInfoDisplay(String team) {
    _team = team;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        context,
        'Info',
      ),
      body: Text(_team),
    );
  }
}

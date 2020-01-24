import 'package:flutter/material.dart';
import 'package:mustang_app/header.dart';

class TeamInfoDisplay extends StatelessWidget {

  static const String route = './TeamInfoDisplay';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        context,
        'Info',
      ),
      body: Text('Info'),
    );
  }
}

import 'package:flutter/material.dart';

import './bottomnavbar.dart';

class HomePage extends StatefulWidget {

  static const String route = '/';

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
      BottomNavBar nav = new BottomNavBar(context);
      nav.setSelected(HomePage.route);
      return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Text('Welcome!', style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold,)),
      ),
      bottomNavigationBar: nav,
    );
  }
}
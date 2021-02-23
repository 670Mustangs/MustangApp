import 'package:flutter/material.dart';
import 'package:mustang_app/screens/endgamescouting.dart';
import 'package:mustang_app/screens/teaminfodisplay.dart';


import 'screens/calendar.dart';
import 'screens/scouter.dart';
import 'screens/autonscouting.dart';
import 'screens/teleopscouting.dart';
import 'screens/postscouter.dart';
import 'screens/search.dart';
import 'screens/homepage.dart';
import 'screens/loginpage.dart';
import 'screens/root_page.dart';
import 'screens/matchendscouting.dart';
import 'screens/sketcher.dart';
import 'screens/profile.dart';
import 'screens/root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final Map<String, WidgetBuilder> routes = {
    Calendar.route: (BuildContext context) => new Calendar(),
    Scouter.route: (BuildContext context) => new Scouter(),
    Profile.route: (BuildContext context) =>  new Profile(),
    RootPage.route: (BuildContext context) => new RootPage(),
    HomePage.route: (BuildContext context) => new HomePage(),
    // AutonScouter.route: (BuildContext context) => new AutonScouter(),
    // TeleopScouter.route: (BuildContext context) => new TeleopScouter(),
    // EndgameScouter.route: (BuildContext context) => new EndgameScouter(),
    // MatchEndScouter.route: (BuildContext context) => new MatchEndScouter(),
    PostScouter.route: (BuildContext context) => new PostScouter(),
    SearchPage.route: (BuildContext context) => new SearchPage(),
    SketchPage.route: (BuildContext context) => new SketchPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mustang App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RootPage(),
      routes: routes,
    );
  }
}


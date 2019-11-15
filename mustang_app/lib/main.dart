import 'package:flutter/material.dart';

import './calendar.dart';
import './scouter.dart';
import './mainscouter.dart';
import './endscouter.dart';
import './postscouter.dart';
import './search.dart';
import './homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final Map<String, WidgetBuilder> routes = {
    Calendar.route: (BuildContext context) => new Calendar(),
    Scouter.route: (BuildContext context) => new Scouter(),
    MainScouter.route: (BuildContext context) => new MainScouter(),
    EndScouter.route: (BuildContext context) => new EndScouter(),
    PostScouter.route: (BuildContext context) => new PostScouter(),
    // Searcher.route: (BuildContext context) => new Searcher(),

  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomePage(),
        routes: routes);
  }
}

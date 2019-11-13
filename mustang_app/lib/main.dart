import 'package:flutter/material.dart';

import './calendar.dart';
import './scouter.dart';
import './mainscouter.dart';
import './endscouter.dart';
import './postscouter.dart';
import './search.dart';
import './bottomnavbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final Map<String, WidgetBuilder> routes = {
    Calendar.route: (BuildContext context) => new Calendar(),
    Scouter.route: (BuildContext context) => new Scouter(),
    MainScouter.route: (BuildContext context) => new MainScouter(),
    EndScouter.route: (BuildContext context) => new EndScouter(),
    PostScouter.route: (BuildContext context) => new PostScouter(),
    Searcher.route: (BuildContext context) => new Searcher(),

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

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Calendar.route);
                },
                child: Text(
                  'Calendar',
                  style: TextStyle(fontSize: 30),
                ),
                color: Colors.greenAccent,
                padding: EdgeInsets.all(30),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Scouter.route);
                },
                child: Text(
                  ' Scouter ',
                  style: TextStyle(fontSize: 30),
                ),
                color: Colors.greenAccent,
                padding: EdgeInsets.all(30),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(context),
    );
  }
}

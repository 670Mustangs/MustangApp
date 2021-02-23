import 'package:flutter/material.dart';

import './bottomnavbar.dart';
import './profile.dart';
import './loginpage.dart';
import './root_page.dart';

import 'package:mustang_app/auth/database.dart';

class HomePage extends StatefulWidget {
  // const HomePage({this.onSignedOut});
  // final VoidCallback onSignedOut;

    static String route = "/HomePage";

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Home'),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, Profile.route);
              },
            ),
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Report a Bug', 'Logout'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ]),
      body: Center(
          // child: Text('Welcome!', style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold,)),
          ),
      bottomNavigationBar: BottomNavBar(context),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Report a Bug':
        print("Logout");
        break;
      case 'Logout':
        print("Logout clicked");
        try {
          LoginPageState.googleSignIn.signOut();
          Navigator.pushNamed(context, RootPage.route);
        } catch (err) {
          print(err);
        }
        break;
    }
  }
}

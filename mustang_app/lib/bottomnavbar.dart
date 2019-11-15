import 'package:flutter/material.dart';

import './calendar.dart';
import './scouter.dart';
import './search.dart';

class BottomNavBar extends BottomNavigationBar {
  static int _selectedIndex = 0;

  static final routes = [
    '/',
    Calendar.route,
    Scouter.route,
    Calendar.route,
  ];

  BottomNavBar(BuildContext context)
      : super(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text('Calendar'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Scouter'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          onTap: (int index) {
            _selectedIndex = index;
            Navigator.of(context).pushNamed('/');
            Navigator.of(context).pushNamed(routes[index]);
          },
        );
}

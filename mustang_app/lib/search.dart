import 'package:flutter/material.dart';

import './header.dart';
import './bottomnavbar.dart';

class Searcher extends StatefulWidget {
  static const String route = '/Searcher';

  @override
  State<StatefulWidget> createState() {
    return SearcherState();
  }
}

class SearcherState extends State<Searcher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, 'Search'), 
      body: Center(),
      bottomNavigationBar: BottomNavBar(context),
    );
  }
}

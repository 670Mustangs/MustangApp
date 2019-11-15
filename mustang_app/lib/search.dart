import 'package:flutter/material.dart';
import 'package:mustang_app/calendar.dart';

import './header.dart';
import './bottomnavbar.dart';
import './calendar.dart';

class Searcher extends SearchDelegate<String> {

  var events = Calendar.events;

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return null;
  }

}

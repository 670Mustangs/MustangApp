import 'package:flutter/material.dart';
import 'package:mustang_app/databaseoperations.dart';

class SearchPage extends StatelessWidget {
  static const String route = '/Search';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Searcher());
            },
          ),
        ],
      ),
      drawer: Drawer(),
    );
  }
}

class Searcher extends SearchDelegate<String> {
  DatabaseOperations db = new DatabaseOperations();

  Searcher() {}

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    db.getTeams().then((List<String> teams) {
      var suggestionList = query.isEmpty
          ? teams
          : teams.where((p) => p.startsWith(query)).toList();
      print("lol");
      print(suggestionList);
      return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            showResults(context);
          },
          leading: Icon(Icons.people),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        itemCount: suggestionList.length,
      );
    });
  }
}

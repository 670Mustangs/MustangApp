import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mustang_app/databaseoperations.dart';
import 'package:mustang_app/header.dart';
import 'package:mustang_app/teaminfodisplay.dart';

class SearchPage extends StatefulWidget {
  static const String route = './Search';

  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var queryResultSet = [];
  var tempSearchStore = [];
  var allTeams = [];
  TextEditingController _queryController = new TextEditingController();

  _SearchPageState() {
    // Firestore.instance.collection('teams').getDocuments().then((onValue) {
    //   onValue.documents.forEach((element) {
    //     allTeams.add('Team ' + element['Team Number']);
    //   });
    // });
    initAllTeams();
  }

  void initAllTeams() async {
        var docs = await Firestore.instance.collection('teams').getDocuments();
    docs.documents.forEach((f) {
      allTeams.add('Team ' + f['Team Number']);
    });
  }

  searchByName(String searchField) {
    if (searchField.isEmpty) return;

    return Firestore.instance
        .collection('teams')
        .where('Team Number', isEqualTo: searchField)
        .getDocuments();
  }

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    // var capitalizedValue =
    //     value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0) {
      searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['Team Number'].startsWith(value)) {
          setState(() {
            tempSearchStore.add('Team ' + element['Team Number']);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new Header(
        context,
        'Search Data',
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _queryController,
              onChanged: (val) {
                initiateSearch(val);
                print(tempSearchStore);
              },
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.arrow_back),
                    iconSize: 20.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search by name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
          // SizedBox(height: 10.0),
          Container(
            height: 40,
            child: (_queryController.text.isNotEmpty &&
                    tempSearchStore.isNotEmpty)
                ? (ListView.builder(
                    itemCount: tempSearchStore.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, TeamInfoDisplay.route);
                      },
                      leading: Icon(Icons.people),
                      title: RichText(
                        text: TextSpan(
                          text: tempSearchStore[index]
                              .substring(0, 5 + _queryController.text.length),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: tempSearchStore[index]
                                  .substring(5 + _queryController.text.length),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
                : (ListView.builder(
                    itemCount: allTeams.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, TeamInfoDisplay.route);
                      },
                      leading: Icon(Icons.people),
                      title: Text(
                        allTeams[index],
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )),
          ),
          // GridView.count(
          //     padding: EdgeInsets.only(left: 10.0, right: 10.0),
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 4.0,
          //     mainAxisSpacing: 4.0,
          //     primary: false,
          //     shrinkWrap: true,
          //     children: tempSearchStore.map((element) {
          //       return buildResultCard(element);
          //     }).toList())
        ],
      ),
    );
  }
}

Widget buildResultCard(data) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Container(
          child: Center(
              child: Text(
        data['businessName'],
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ))));
}

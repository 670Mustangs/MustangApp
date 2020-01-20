import 'package:firebase_database/firebase_database.dart';

class DatabaseOperations {
  DatabaseReference DBRef;
  List<String> teamNames = new List<String>();

  DatabaseOperations() {
    DBRef = FirebaseDatabase.instance.reference();
  }

  void startPitScouting(String teamNumber) {
    var parent = DBRef.child('teams')
        .child('Team Number: ' + teamNumber)
        .child('Pit Scouting');

    parent.set({
      'Example Text': '',
    });
  }

  void updatePitScouting(String teamNumber, {String text}) {
    var parent = DBRef.child('teams')
        .child('Team Number: ' + teamNumber)
        .child('Pit Scouting');

    parent.update({
      'Example Text': text,
    });
  }

  void startNewMatch(String teamNumber, String matchNumber) {
    var parent = DBRef.child('teams')
        .child('Team Number: ' + teamNumber)
        .child('Match Scouting')
        .child('Match Number: ' + matchNumber);

    parent.set({
      'Auton': [],
      'Teleop': [],
      'Endgame': [],
      'Summary': [],
    });
    parent.set({
      'Bottom Port': 0,
      'Outer Port': 0,
      'Inner Port': 0,
      'Crossed Initiation Line': false,
      'Total Points': 0,
    });
    parent.set({
      'Bottom Port': 0,
      'Outer Port': 0,
      'Inner Port': 0,
      'Rotation Control': false,
      'Position Control': false,
      'Total Points': 0,
    });
    parent.set({
      'Bottom Port': 0,
      'Outer Port': 0,
      'Inner Port': 0,
      'Stages Completed': 0,
      'Ending State': '',
      'Total Points': 0,
    });
    parent.set({
      'Crossed Initiation Line': false,
      'Bottom Port': 0,
      'Outer Port': 0,
      'Inner Port': 0,
      'Rotation Control': false,
      'Position Control': false,
      'Ending State': '',
      'Match Result': '',
      'Total Points': 0,
      'Ranking Points': 0,
      'Fouls': 0,
      'Final Comments': '',
      'Scouters': '',
      'Stages Completed': 0,
    });
  }

  void updateMatchDataAuton(String teamNumber, String matchNumber,
      {int bottomPort = 0, int innerPort, int outerPort, bool crossedLine}) {
    int totalPoints = bottomPort * 2 + outerPort * 4 + innerPort * 6;
    totalPoints += crossedLine ? 5 : 0;
    DBRef.child('teams')
        .child('Team Number: ' + teamNumber)
        .child('Match Number: ' + matchNumber)
        .child('Auton')
        .update({
      'Bottom Port': bottomPort * 2,
      'Outer Port': outerPort * 4,
      'Inner Port': innerPort * 6,
      'Crossed Initiation Line': crossedLine,
      'Total Points': totalPoints,
    });
    this.updateMatchDataSummary(teamNumber, matchNumber);
  }

  void updateMatchDataTeleop(String teamNumber, String matchNumber,
      {int bottomPort = 0,
      int innerPort,
      int outerPort,
      bool rotationControl,
      bool positionControl}) {
    int totalPoints = bottomPort * 1 + outerPort * 2 + innerPort * 3;
    totalPoints += rotationControl ? 10 : 0;
    totalPoints += rotationControl ? 20 : 0;

    DBRef.child('teams')
        .child('Team Number: ' + teamNumber)
        .child('Match Number: ' + matchNumber)
        .child('Teleop')
        .update({
      'Bottom Port': bottomPort * 1,
      'Outer Port': outerPort * 2,
      'Inner Port': innerPort * 3,
      'Rotation Control': rotationControl,
      'Position Control': positionControl,
      'Total Points': totalPoints,
    });
    this.updateMatchDataSummary(teamNumber, matchNumber);
  }

  void updateMatchDataEndgame(String teamNumber, String matchNumber,
      {int bottomPort = 0,
      int innerPort,
      int outerPort,
      int stagesCompleted,
      String endState}) {
    int totalPoints = bottomPort * 1 + outerPort * 2 + innerPort * 3;
    if (endState == 'Parked')
      totalPoints += 5;
    else if (endState == 'Hanging') totalPoints += 25;

    DBRef.child('teams')
        .child('Team Number: ' + teamNumber)
        .child('Match Number: ' + matchNumber)
        .child('Endgame')
        .update({
      'Bottom Port': bottomPort * 1,
      'Outer Port': outerPort * 2,
      'Inner Port': innerPort * 3,
      'Ending State': endState,
      'Total Points': totalPoints,
      'Stages Completed': stagesCompleted,
    });
    this.updateMatchDataSummary(teamNumber, matchNumber);
  }

  void updateMatchDataEnd(String teamNumber, String matchNumber,
      {String matchResult, int fouls, String finalComments, String names}) {
    DBRef.child('teams')
        .child('Team Number: ' + teamNumber)
        .child('Match Number: ' + matchNumber)
        .child('Summary')
        .update({
      'Match Result': matchResult,
      'Fouls': fouls,
      'Final Comments': finalComments,
      'Scouters': names,
    });

    this.updateMatchDataSummary(teamNumber, matchNumber);
  }

  void updateMatchDataSummary(String teamNumber, String matchNumber) {
    DBRef.once().then((DataSnapshot dataSnapshot) {
      var parent = dataSnapshot.value['teams']['Team Number: ' + teamNumber]
          ['Match Number: ' + matchNumber];
      var rp = 0;
      if (parent['Summary']['Match Result'] == 'Win')
        rp += 2;
      else if (parent['Summary']['Match Result'] == 'Draw') rp += 1;
      if (parent['Endgame']['Total Points'] >= 65) rp += 1;
      if (parent['Summary']['Stages Completed'] == 3) rp += 1;
      DBRef.child('teams')
          .child('Team Number: ' + teamNumber)
          .child('Match Number: ' + matchNumber)
          .child('Summary')
          .update({
        'Crossed Initiation Line': parent['Auton']['Crossed Initiation Line'],
        'Bottom Port': parent['Auton']['Bottom Port'] +
            parent['Teleop']['Bottom Port'] +
            parent['Endgame']['Bottom Port'],
        'Outer Port': parent['Auton']['Outer Port'] +
            parent['Teleop']['Outer Port'] +
            parent['Endgame']['Outer Port'],
        'Inner Port': parent['Auton']['Inner Port'] +
            parent['Teleop']['Inner Port'] +
            parent['Endgame']['Inner Port'],
        'Rotation Control': parent['Teleop']['Rotation Control'],
        'Position Control': parent['Teleop']['Position Control'],
        'Ending State': parent['Endgame']['Ending State'],
        'Match Result': parent['Summary']['Match Result'],
        'Total Points': parent['Auton']['Total Points'] +
            parent['Teleop']['Total Points'] +
            parent['Endgame']['Total Points'],
        'Ranking Points': rp,
        'Fouls': parent['Summary']['Fouls'],
        'Final Comments': parent['Summary']['Final Comments'],
        'Scouters': parent['Summary']['Scouters'],
        'Stages Completed': parent['Endgame']['Stages Completed'],
      });
    });
  }

  Future<List<String>> getTeams() async {
    DataSnapshot data = await DBRef.child('teams').once();
    Map<dynamic, dynamic> values = data.value;
    values.forEach((key, values) {
      teamNames.add(key);
    });
    print(teamNames);
    return teamNames;
  }
}

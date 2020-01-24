import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseOperations {
  Firestore db;
  List<String> teamNames = new List<String>();

  DatabaseOperations() {
    // DBRef = FirebaseDatabase.instance.reference();
    db = Firestore.instance;
  }

  void startPitScouting(String teamNumber) {
    db.collection('teams').document('Team Number: ' + teamNumber).setData({
      'Pit Scouting': {
        'Example Text': '',
      }
    }, merge: true);
    db
        .collection('teams')
        .document('Team Number: ' + teamNumber)
        .updateData({'Team Number': teamNumber});
  }

  void updatePitScouting(String teamNumber, {String text}) {
    db.collection('teams').document('Team Number: ' + teamNumber).updateData({
      'Pit Scouting': {
        'Example Text': text,
      }
    });
  }

  void startNewMatch(String teamNumber, String matchNumber) {
    var parent = db
        .collection('teams')
        .document('Team Number: ' + teamNumber)
        .collection('Match Scouting')
        .document('Match Number: ' + matchNumber);

    parent.setData({
      'Auton': {},
      'Teleop': {},
      'Endgame': {},
      'Summary': {},
    }, merge: true);
    parent.setData({
      'Auton': {
        'Bottom Port': 0,
        'Outer Port': 0,
        'Inner Port': 0,
        'Crossed Initiation Line': false,
        'Total Points': 0,
      }
    }, merge: true);
    parent.setData({
      'Teleop': {
        'Bottom Port': 0,
        'Outer Port': 0,
        'Inner Port': 0,
        'Rotation Control': false,
        'Position Control': false,
        'Total Points': 0,
      }
    }, merge: true);
    parent.setData({
      'Endgame': {
        'Bottom Port': 0,
        'Outer Port': 0,
        'Inner Port': 0,
        'Stages Completed': 0,
        'Ending State': '',
        'Total Points': 0,
      }
    }, merge: true);
    parent.setData({
      'Summary': {
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
      }
    }, merge: true);

    // db
    //     .collection('teams')
    //     .document('Team Number: ' + teamNumber)
    //     .updateData({'Team Number': teamNumber});
  }

  void updateMatchDataAuton(String teamNumber, String matchNumber,
      {int bottomPort = 0, int innerPort, int outerPort, bool crossedLine}) {
    int totalPoints = bottomPort * 2 + outerPort * 4 + innerPort * 6;
    totalPoints += crossedLine ? 5 : 0;

    db
        .collection('teams')
        .document('Team Number: ' + teamNumber)
        .collection('Match Scouting')
        .document('Match Number: ' + matchNumber)
        .updateData({
      'Auton': {
        'Bottom Port': bottomPort * 2,
        'Outer Port': outerPort * 4,
        'Inner Port': innerPort * 6,
        'Crossed Initiation Line': crossedLine,
        'Total Points': totalPoints,
      }
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

    db
        .collection('teams')
        .document('Team Number: ' + teamNumber)
        .collection('Match Scouting')
        .document('Match Number: ' + matchNumber)
        .updateData({
      'Teleop': {
        'Bottom Port': bottomPort * 1,
        'Outer Port': outerPort * 2,
        'Inner Port': innerPort * 3,
        'Rotation Control': rotationControl,
        'Position Control': positionControl,
        'Total Points': totalPoints,
      }
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

    db
        .collection('teams')
        .document('Team Number: ' + teamNumber)
        .collection('Match Scouting')
        .document('Match Number: ' + matchNumber)
        .updateData({
      'Endgame': {
        'Bottom Port': bottomPort * 1,
        'Outer Port': outerPort * 2,
        'Inner Port': innerPort * 3,
        'Ending State': endState,
        'Total Points': totalPoints,
        'Stages Completed': stagesCompleted,
      }
    });
    this.updateMatchDataSummary(teamNumber, matchNumber);
  }

  void updateMatchDataEnd(String teamNumber, String matchNumber,
      {String matchResult, int fouls, String finalComments, String names}) {
    db
        .collection('teams')
        .document('Team Number: ' + teamNumber)
        .collection('Match Scouting')
        .document('Match Number: ' + matchNumber)
        .updateData({
      'Summary': {
        'Match Result': matchResult,
        'Fouls': fouls,
        'Final Comments': finalComments,
        'Scouters': names,
      }
    });

    this.updateMatchDataSummary(teamNumber, matchNumber);
  }

  void updateMatchDataSummary(String teamNumber, String matchNumber) {
    db
        .collection('teams')
        .document('Team Number: ' + teamNumber)
        .collection('Match Scouting')
        .document('Match Number: ' + matchNumber)
        .get()
        .then((DocumentSnapshot dataSnapshot) {
      var map = dataSnapshot.data.map((String key, Object value) {
        return MapEntry(key, value);
      });
      Map<dynamic, dynamic> summary = map['Summary'];
      Map<dynamic, dynamic> endgame = map['Endgame'];
      Map<dynamic, dynamic> auton = map['Auton'];
      Map<dynamic, dynamic> teleop = map['Teleop'];
      var rp = 0;
      if (summary['Match Result'] == 'Win')
        rp += 2;
      else if (summary['Match Result'] == 'Draw') 
        rp += 1;
      if (int.parse(endgame['Total Points'].toString()) >= 65) {
        rp += 1;
      }
      if(int.parse(endgame['Stages Completed'].toString()) == 3) {
        rp += 1;
      }
      // if (int.parse(summary['Stages Completed'].toString()) == 3)
      //   rp += 1;
      db
          .collection('teams')
          .document('Team Number: ' + teamNumber)
          .collection('Match Scouting')
          .document('Match Number: ' + matchNumber)
          .updateData({
        'Summary': {
          'Crossed Initiation Line': auton['Crossed Initiation Line'],
          'Bottom Port': int.parse(auton['Bottom Port'].toString()) +
              teleop['Bottom Port'] +
              endgame['Bottom Port'],
          'Outer Port': int.parse(auton['Outer Port'].toString()) +
              teleop['Outer Port'] +
              endgame['Outer Port'],
          'Inner Port': int.parse(auton['Inner Port'].toString()) +
              teleop['Inner Port'] +
              endgame['Inner Port'],
          'Rotation Control': teleop['Rotation Control'],
          'Position Control': teleop['Position Control'],
          'Ending State': endgame['Ending State'],
          'Match Result': summary['Match Result'],
          'Total Points': int.parse(auton['Total Points'].toString()) +
              teleop['Total Points'] +
              endgame['Total Points'],
          'Ranking Points': rp,
          'Fouls': summary['Fouls'],
          'Final Comments': summary['Final Comments'],
          'Scouters': summary['Scouters'],
          'Stages Completed': summary['Stages Completed'],
        }
      });
    });
  }
}

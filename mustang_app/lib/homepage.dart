import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './bottomnavbar.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  void signUpWithEmail() async {
    FirebaseUser user;
    try {
    user = (await auth.createUserWithEmailAndPassword(email: "sas@lol.com", password: "sasa")) as FirebaseUser;
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Text('Welcome!', style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold,)),
      ),
      bottomNavigationBar: BottomNavBar(context),
    );
  }
}
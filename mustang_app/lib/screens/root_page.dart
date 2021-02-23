import 'package:flutter/material.dart';
import 'package:mustang_app/screens/homepage.dart';
import 'package:mustang_app/screens/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RootPageState();
  
  static String route = "/RootPage";
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class RootPageState extends State<RootPage> {
  static AuthStatus authStatus = AuthStatus.notSignedIn;
  final FirebaseMessaging _messaging = new FirebaseMessaging();

  RootPageState() {
    if (LoginPageState.googleSignIn.currentUser != null) {
      LoginPageState.googleSignIn.signInSilently();
      print("Current User Email: " +
          LoginPageState.googleSignIn.currentUser.email);
      authStatus = AuthStatus.signedIn;
    }
    build(super.context);
  }

  @override
  void initState() {
    super.initState();
    _messaging.getToken().then((token) {
      print(token);
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final BaseAuth auth = AuthProvider.of(context).auth;
  //   auth.currentUser().then((String userId) {
  //     setState(() {
  //       authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
  //     });
  //   });
  // }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(LoginPageState.googleSignIn.isSignedIn() == true){
      return HomePage();
    }
    else{
      return LoginPage();
    }
    return null;
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

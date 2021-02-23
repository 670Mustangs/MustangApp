import 'package:flutter/material.dart';
import 'package:mustang_app/screens/homepage.dart';
import 'package:mustang_app/screens/root_page.dart';
import 'package:mustang_app/models/user.dart';
import 'package:mustang_app/auth/database.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginPage extends StatefulWidget {
  // const LoginPage({this.onSignedIn});
  // final VoidCallback onSignedIn;

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // AuthService auth = new AuthService();

  static GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  static User user;

  _login() async {
    try {
      await googleSignIn.signIn();
      RootPageState.authStatus = googleSignIn.isSignedIn() == true ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      // if(RootPageState.authStatus == AuthStatus.signedIn){
        user = new User(email: googleSignIn.currentUser.email, name: googleSignIn.currentUser.displayName, number: "", skillLevel: "PONY", grade: "0");
        DatabaseService.initUserData(user);
      // }
      // print("hi");
    } catch (err) {
      print(err);
    }
  }

  _register() async {
    try {
      await googleSignIn.signIn();
      RootPageState.authStatus = googleSignIn.isSignedIn() == true ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      // if(RootPageState.authStatus == AuthStatus.signedIn){
        user = new User(email: googleSignIn.currentUser.email, name: googleSignIn.currentUser.displayName, number: "", skillLevel: "PONY", grade: "9");
        DatabaseService.registerUserData(user);
      // }
      // print("hi");
    } catch (err) {
      print(err);
    }
  }

  _logout() async {
    try {
      await googleSignIn.signOut();
      RootPageState.authStatus = AuthStatus.notSignedIn;
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Row(children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                      child: Text('Hey',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold)),
                    ),
                    Transform.translate(
                      offset: Offset(30, 20),
                      child: Container(
                        height: 60.0,
                        width: 80.0,
                        padding: EdgeInsets.fromLTRB(0.0, 70.0, 50.0, 0.0),
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/hrt_icon.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ]),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 125.0, 0.0, 0.0),
                    child: Text('Buddies',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(310.0, 125.0, 15.0, 0.0),
                    child: Text('!',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 210.0, 15.0, 0.0),
                    child: Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 230.0, 0.0, 0.0),
                    child: Text('Login to Homestead Robotics',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 300.0, 0.0, 0.0),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _signInButton(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 370.0, 0.0, 0.0),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _registerButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        _login().whenComplete(() {
          print("Current User Email: " + googleSignIn.currentUser.email);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

Widget _registerButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        _register().whenComplete(() {
          print("Current User Email: " + googleSignIn.currentUser.email);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Register with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// return Scaffold(
//       body: Container(
//         color: Colors.white,
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               FlutterLogo(size: 150),
//               SizedBox(height: 50),
//               _signInButton(),
//             ],
//           ),
//         ),
//       ),
//     );

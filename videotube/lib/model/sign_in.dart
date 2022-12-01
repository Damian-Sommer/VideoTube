import 'package:flutter/material.dart';
import 'package:videotube/model/google_sign_in_service.dart';

/// by https://pub.dev/packages/extension_google_sign_in_as_googleapis_auth/example

class SignIn extends StatefulWidget {
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GoogleSignInProvider googleSignInProvider = new GoogleSignInProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              minimumSize: Size(double.infinity, 50),
            ),
            label: Text("Sign Up with Google"),
            onPressed: () {
              googleSignInProvider.signInWithGoogle();
            },
            icon: Icon(Icons.person),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              minimumSize: Size(double.infinity, 50),
            ),
            label: Text("Sign out"),
            onPressed: () {
              googleSignInProvider.signOutGoogle();
            },
            icon: Icon(Icons.lock_person),
          ),
        ],
      )
    );
  }
}

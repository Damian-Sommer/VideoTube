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
        SizedBox(
          height: 20,
        ),
        Image.asset(
          'assets/icons/vitu.png',
          height: 150,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Log in to Vitu to access all features',
          style: const TextStyle(
            color: Color(0xffDFDDDD),
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(220, 61, 63, 1),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 60),
                ),
                label: Text("Sign In with Google"),
                onPressed: () {
                  googleSignInProvider.signInWithGoogle();
                },
                icon: Icon(Icons.person),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(220, 61, 63, 1),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 60),
                ),
                label: Text("Sign out"),
                onPressed: () {
                  googleSignInProvider.signOutGoogle();
                },
                icon: Icon(Icons.lock_person),
              ),
            ],
          ),
        )),
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:videotube/model/google_sign_in_service.dart';

/// by https://pub.dev/packages/extension_google_sign_in_as_googleapis_auth/example

class SignIn extends StatefulWidget {
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GoogleSignInProvider googleSignInProvider = GoogleSignInProvider();

  bool loggedIn = false;

  @override
  void initState() {
    isLoggedIn();
    super.initState();
  }

  void isLoggedIn(){
    googleSignInProvider.isLoggedIn().then((value) => loggedIn = value);
  }

  Widget isUserLoggedIn() {
    if(loggedIn == false){
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(220, 61, 63, 1),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 60),
        ),
        label: const Text("Sign In with Google"),
        onPressed: () {
          googleSignInProvider.signInWithGoogle();
          setState(() {
            isLoggedIn();
          });
        },
        icon: const Icon(Icons.person),
      );
    }else{
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(220, 61, 63, 1),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 60),
        ),
        label: const Text("Sign out"),
        onPressed: () {
          googleSignInProvider.signOutGoogle();
          setState(() {
            isLoggedIn();
          });
        },
        icon: const Icon(Icons.lock_person),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/icons/vitu.png',
              height: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Log in to Vitu to access all features',
              style: TextStyle(
                color: Color(0xffDFDDDD),
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    isUserLoggedIn(),
                    /**
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(220, 61, 63, 1),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 60),
                      ),
                      label: const Text("Sign In with Google"),
                      onPressed: () {
                        googleSignInProvider.signInWithGoogle();
                      },
                      icon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(220, 61, 63, 1),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 60),
                      ),
                      label: const Text("Sign out"),
                      onPressed: () {
                        googleSignInProvider.signOutGoogle();
                      },
                      icon: const Icon(Icons.lock_person),
                    ),**/
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}

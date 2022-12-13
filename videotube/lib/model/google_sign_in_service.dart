import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class GoogleSignInProvider{
  ///By https://www.codegrepper.com/profile/bharath flutter firebase google auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  User? getUser() {
    return _auth.currentUser;
  }

  Future<String?> getUserId() async {
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    return uid;
  }

  Future<User?> signInWithGoogle() async {

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
    await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    final UserCredential authResult =
    await _auth.signInWithCredential(credential);
    final User? user = authResult.user;


    final User? currentUser = _auth.currentUser;

    print('signInWithGoogle succeeded: $user');

    return currentUser;
  }

  Future<bool> isLoggedIn() async {
    return await googleSignIn.isSignedIn() ? true : false;
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Sign Out");
  }
/**
  late GoogleSignInAccount _user;

  GoogleSignInAccount get user => _user;

  Future googleLogin() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: <String>["email"]).signIn();
    if(googleUser == null) return;
    _user = googleUser;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    
    await FirebaseAuth.instance.signInWithCredential(credential);
  }**/

}
/**
class Auth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  })async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }
}**/
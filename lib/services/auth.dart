
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:testpro/widgets/alerts.dart';

import 'database.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _userFromFirebase(User? user){
    return user;
  }

  Stream<User?> get user{
    return _auth.authStateChanges().map(_userFromFirebase);
  }
  Future signUpWithMailAndPassword(String mail, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: mail, password: password);
      User user = result.user!;
      Database().initiateUser(user.uid);

      return _userFromFirebase(user);
    }catch(e){
      return null;
    }
  }
  Future signInWithMailAndPassword(String mail, String pass, BuildContext context) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;
      return _userFromFirebase(user);
    }
    catch(e)
    {
      showAlertScreen(context, "Wrong password or lost connection", "Try again");
      return null;
    }

  }
  Future signInWithGoogle() async {
    // Trigger the authentication flow

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential result =  await FirebaseAuth.instance.signInWithCredential(credential);
    User? user =  result.user;
    if(user != null) {
      Database db = Database();
      bool doesExist = await db.doesUserExist(user.uid);
      if(!doesExist)
        {
          db.initiateUser(user.uid);
        }
    }

    return _userFromFirebase(user);
  }

  Future signInWithFacebook() async{
    final fb = FacebookLogin();
    final res = await fb.logIn(
        permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email,
        ]
    );
    if(res.status == FacebookLoginStatus.success)
    {
      final FacebookAccessToken fbToken =  res.accessToken!;
      final AuthCredential credential = FacebookAuthProvider.credential(fbToken.token);

      final result = await _auth.signInWithCredential(credential);
      User? user =  result.user;
      if(user != null) {
        Database db = Database();
        bool doesExist = await db.doesUserExist(user.uid);
        if(!doesExist)
        {
          db.initiateUser(user.uid);
        }
      }

      return _userFromFirebase(user);

    }
    return null;
  }
  Future anonSignIn() async{
    try{
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user!;
      return _userFromFirebase(user);
    }
    catch(e){
      return null;
    }
  }

  Future signOut() async
  {
    try{
      return await _auth.signOut();
    }catch (e){
      return null;
    }
  }

}
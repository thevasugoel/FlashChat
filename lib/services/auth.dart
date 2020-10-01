import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat/models/helperFunction.dart';
import 'package:we_chat/models/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserAuth _userFromFirebaseUser(User user) {
    return user != null ? UserAuth(userId: user.uid) : null;
  }

  Future signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result.user);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
    }
  }

  Future signUpWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedIn(false);
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:wellness24/models/user.dart';

class AuthService {
  FirebaseAuth auth;

  AuthService({this.auth});

  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  Stream<User> get user {
    return auth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String?> signIn(String email, String password);

  Future<String?> signUp(String email, String password);

  Future<User?> getCurrentUser();

  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User? _user;
  late UserCredential? _userCredential;

  Future<String?> signIn(String email, String password) async {
    _userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _user?.uid;
  }

  Future<String?> signUp(String email, String password) async {
    _userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _user?.uid;
  }

  Future<User?> getCurrentUser() async {
    _user = await _firebaseAuth.currentUser;
    return _user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}

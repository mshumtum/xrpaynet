import 'dart:async';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<dynamic> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();

  Future<void> resetPassword(String email);

  Future<void> sendPasswordResetEmail(String email);
}

class AuthFunctions implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions.instance;

  @override
  Future<String> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      var errorMsg = "";
      if (e.code == 'user-not-found') {
        errorMsg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMsg = 'Wrong password provided for that user.';
      }
      return errorMsg;
    }
  }

  @override
  Future<dynamic> getCurrentUser() async {
    HttpsCallable callable = _firebaseFunctions.httpsCallable('getUserDetails');
    final results = await callable.call();
    return results.data;
  }

  @override
  Future<String> signUp(String email, String password) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user!.uid;
    } catch (e) {
      return "error";
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      return await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("exaption");
    }
  }

  @override
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  @override
  Future<void> sendEmailVerification() async {
    dynamic user = _firebaseAuth.currentUser!;
    return user.sendEmailVerification();
  }

  @override
  Future<bool> isEmailVerified() async {
    dynamic user = _firebaseAuth.currentUser!;
    return user.isEmailVerified;
  }
}

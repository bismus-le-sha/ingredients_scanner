import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:ingredients_scanner/global/widgets/message_snack_bar.dart';
import 'package:talker_flutter/talker_flutter.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final MessageSnackBar _snackBar = MessageSnackBar();

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, GlobalKey scaffoldKey) async {
    final scaffoldMessenger = ScaffoldMessenger.of(scaffoldKey.currentContext!);
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e, st) {
      if (e.code == 'email-already-in-use') {
        scaffoldMessenger.showSnackBar(
            _snackBar.popUpSnackBar('The email addre is already in use.'));
      } else if (e.code == 'weak-password') {
        scaffoldMessenger.showSnackBar(
            _snackBar.popUpSnackBar('The password provided is too weak.'));
      } else {
        scaffoldMessenger.showSnackBar(
            _snackBar.popUpSnackBar('An error occurred: ${e.code}'));
      }
      GetIt.I<Talker>().handle(e, st);
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password, GlobalKey scaffoldKey) async {
    final scaffoldMessenger = ScaffoldMessenger.of(scaffoldKey.currentContext!);
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e, st) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        scaffoldMessenger.showSnackBar(_snackBar.popUpSnackBar(
            _snackBar.popUpSnackBar('Invalid email or password.')));
      } else {
        scaffoldMessenger.showSnackBar(
            _snackBar.popUpSnackBar('An error occurred: ${e.code}'));
      }
      GetIt.I<Talker>().handle(e, st);
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }
}

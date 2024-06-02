import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/error/exceptions.dart';
import '../models/sign_in_model.dart';
import '../models/sign_up_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signUp(SignUpModel signUp);
  Future<UserCredential> signIn(SignInModel signIn);
  Future<UserCredential> googleAuthentication();
  Future<Unit> verifyEmail();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl(
      {required this.firebaseAuth, required this.googleSignIn});

  @override
  Future<UserCredential> signUp(SignUpModel signUp) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(
        email: signUp.email,
        password: signUp.password,
      );
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
      rethrow;
    }
  }

  @override
  Future<UserCredential> signIn(SignInModel signIn) async {
    try {
      await firebaseAuth.currentUser?.reload();
      return await firebaseAuth.signInWithEmailAndPassword(
        email: signIn.email,
        password: signIn.password,
      );
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
      rethrow;
    }
  }

  @override
  Future<Unit> verifyEmail() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      try {
        await user.reload();
        await user.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        _handleAuthException(e);
        rethrow;
      }
      return unit;
    } else {
      throw NoUserException();
    }
  }

  @override
  Future<UserCredential> googleAuthentication() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw ServerException();
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await firebaseAuth.signInWithCredential(credential);
    } catch (_) {
      throw ServerException();
    }
  }

  void _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        throw ExistedAccountException();
      case 'wrong-password':
        throw WrongPasswordException();
      case 'weak-password':
        throw WeekPassException();
      case 'email-already-in-use':
        throw ExistedAccountException();
      case 'too-many-requests':
        throw TooManyRequestsException();
      default:
        throw ServerException();
    }
  }
}

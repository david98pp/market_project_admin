// ignore_for_file: lines_longer_than_80_chars,
import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

///Class with Firebase services as a login, logout.
class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// method for sign-in with Google
  Future<bool> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(credential);
      }

      return await _googleSignIn.isSignedIn();
    } on FirebaseAuthException catch (e) {
      developer.log(e.message!, name: 'Google SignIn Error');
      rethrow;
    }
  }

  ///sign out google
  Future<void> signOutFromGoogle() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } on Exception catch (e) {
      developer.log(e.toString());
    }
  }

  ///getUser
  User? getUser() => _auth.currentUser;

  ///listen user changes
  Stream<User?> get firebaseUserChanges => _auth.authStateChanges();

  ///signIn with Facebook
  Future<bool> signInWithFacebook() async {
    final result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, get the UserCredential
      final r = await _auth.signInWithCredential(credential);

      return r.user != null ? true : false;
    }

    return false;
  }
}

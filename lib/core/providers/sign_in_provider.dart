import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:market_project_admin/core/services/firebase_services.dart';

/// Provider function of Sign-In
class SignInProvider extends ChangeNotifier {
  ///is loading var
  bool isLoading = false;

  /// get all methods of Firebase Services
  final firebaseServices = FirebaseServices();

  /// google signInProvider
  Future<bool> googleSignIn() async {
    isLoading = true;
    notifyListeners();
    try {
      return await firebaseServices.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      developer.log(e.message!, name: 'SignIn Provider');
    }
    isLoading = false;
    notifyListeners();

    return false;
  }

  /// google signOutProvider
  Future<void> googleSignOut() async {
    isLoading = true;
    notifyListeners();
    try {
      await firebaseServices.signOutFromGoogle();
    } on Exception catch (e) {
      developer.log(e.toString(), name: 'SignOut Provider');
    }
    isLoading = false;
    notifyListeners();
  }

}

import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:market_project_admin/core/services/firebase_services.dart';

/// Provider function for Home Page
class HomeProvider extends ChangeNotifier {
  ///is loading var
  bool isLoading = false;

  /// get all methods of Firebase Services
  final service = FirebaseServices();

  /// get user logged firebase
  User? getLoggedUser() {
    User? user;
    isLoading = true;
    notifyListeners();
    try {
      user = service.getUser();
    } on FirebaseAuthException catch (e) {
      developer.log(e.message!, name: 'SignIn Provider');
    }
    isLoading = false;
    notifyListeners();

    return user;
  }
}

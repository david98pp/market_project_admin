import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///verify login
class VerifyLoginPage extends StatelessWidget {
  ///constructor
  const VerifyLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userLogin = context.watch<User?>();
    if (userLogin == null) {
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/sign-in'));
    } else {
      Future.microtask(() => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false));
    }

    return Container();
  }
}

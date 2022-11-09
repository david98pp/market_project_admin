import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:market_project_admin/core/providers/sign_in_provider.dart';
import 'package:provider/provider.dart';

///Sign-in class
class SignInPage extends StatelessWidget {
  /// constructor
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    final providerSignIn = context.watch<SignInProvider>();
    void showMessage(String message) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: !providerSignIn.isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () async {
                              try {
                                final isSignedIn =
                                    await providerSignIn.googleSignIn();
                        /*        if (mounted && isSignedIn) {
                                  await Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/home',
                                    (route) => false,
                                  );
                                }*/
                              } on FirebaseAuthException catch (e) {
                                developer.log(
                                  e.message!,
                                  name: 'SignIn Provider',
                                );
                                showMessage(e.message!);
                              }
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.google,
                            ),
                            label: const Text('Google'),
                          ),
                          OutlinedButton.icon(
                            onPressed: () async {
                              try {
                                final isSignedIn =
                                    await SignInProvider().facebookSignIn();
                                if (mounted && isSignedIn) {
                                  await Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/home',
                                    (route) => false,
                                  );
                                }
                              } on FirebaseAuthException catch (e) {
                                developer.log(
                                  e.message!,
                                  name: 'SignIn Provider',
                                );
                                showMessage(e.message!);
                              }
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.google,
                            ),
                            label: const Text('Google'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          SizedBox(
                            height: 20,
                            width: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

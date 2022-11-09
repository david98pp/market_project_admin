import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:market_project_admin/core/providers/home_provider.dart';
import 'package:market_project_admin/core/providers/sign_in_provider.dart';

///home page after login
class HomePage extends StatelessWidget {
  ///constructor
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    final user = HomeProvider().getLoggedUser();
    final providerHomeLoading = context.select(
      (HomeProvider h) => h.isLoading,
    );

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              await SignInProvider().googleSignOut();
            },
          )
        ],
        title: const Text('Home'),
      ),
      body: Center(
        child: !providerHomeLoading
            ? user != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(user.email!),
                      Text(user.displayName!),
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL!),
                        radius: 20,
                      )
                    ],
                  )
                : const SizedBox.shrink()
            : const CircularProgressIndicator(),
      ),
    );
  }
}

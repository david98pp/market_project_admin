import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/providers/home_provider.dart';
import '../core/providers/sign_in_provider.dart';
import '../ui/home_page.dart';
import '../ui/sign_in_page.dart';
import '../ui/verify_login_page.dart';

///get routes
Map<String, Widget Function(BuildContext)> routes = {
  '/sign-in': (context) => ChangeNotifierProvider(
        create: (_) => SignInProvider(),
        child: const SignInPage(),
      ),
  '/home': (context) => ChangeNotifierProvider(
        create: (_) => HomeProvider(),
        child: const HomePage(),
      )
};

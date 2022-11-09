import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:market_project_admin/routes/navigate.dart';
import 'package:provider/provider.dart';

import 'core/providers/sign_in_provider.dart';
import 'core/services/firebase_services.dart';
import 'firebase_options.dart';
import 'ui/verify_login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

/// This class is the root of your application.
class MyApp extends StatelessWidget {
  /// My App constructor
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamProvider<User?>.value(
        value: SignInProvider().firebaseUserChanges,//FirebaseServices
        initialData: null,
        builder: (context, snapshot) => MaterialApp(
          title: 'Administración de mi tienda',
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          routes: routes,
          home: const VerifyLoginPage(),
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(context);
            final scale = mediaQueryData.textScaleFactor.clamp(0.85, 1.15);

            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
              child: child!,
            );
          },
        ),
      );
}

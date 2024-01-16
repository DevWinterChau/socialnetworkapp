import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialnetworkapp/modules/authentication/login/HomePage.dart';
import 'package:socialnetworkapp/modules/authentication/login/UserController.dart';
import 'package:socialnetworkapp/modules/authentication/login/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: UserController.user != null ?  HomePage() : LoginPage(),
    );
  }
}

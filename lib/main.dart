import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:socialnetworkapp/modules/authentication/login/HomePage.dart';
import 'package:socialnetworkapp/modules/authentication/login/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialnetworkapp/modules/post/pages/CreatePostPage.dart';
import 'package:socialnetworkapp/routes/app.dart';

import 'firebase_options.dart';
import 'modules/authentication/login/UserController.dart';

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
    return
      OverlaySupport.global(
        child: MaterialApp(
          title: 'Firebase demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: CreatePostPage(),
        ),
      );
  }
}

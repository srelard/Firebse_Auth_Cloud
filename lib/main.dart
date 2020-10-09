import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_backend/screens/feed_screen.dart';
import 'package:firebase_backend/screens/login_screen.dart';
import 'package:firebase_backend/screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget _getScreenId() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return FeedScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Places nearby Backend',
      debugShowCheckedModeBanner: false,
      home: _getScreenId(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
      },
    );
  }
}

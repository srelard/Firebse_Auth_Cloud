import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_backend/screens/feed_screen.dart';
import 'package:firebase_backend/screens/login_screen.dart';
import 'package:firebase_backend/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/feed_screen.dart';
import 'screens/login_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget _getScreenId() {
    return StreamBuilder<User>(
      //changed
      stream: FirebaseAuth.instance.authStateChanges(), //changed
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
      home: AnimatedSplashScreen(
        splash: Image.asset(
          "assets/images/splash.png",
        ),
        nextScreen: _getScreenId(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.grey[200],
        duration: 3000,
        pageTransitionType: PageTransitionType.bottomToTop,
      ),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        FeedScreen.id: (context) => FeedScreen(),
      },
    );
  }
}

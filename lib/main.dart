import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_backend/models/user_data.dart';
import 'package:firebase_backend/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

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
          Provider.of<UserData>(context, listen: false).currentUserId =
              snapshot.data.uid;
          return HomeScreen(
              // userID: snapshot.data.uid,
              );
        } else {
          return LoginScreen();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        title: 'Places nearby Backend New',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryIconTheme: Theme.of(context)
                .primaryIconTheme
                .copyWith(color: Colors.black)),
        home: AnimatedSplashScreen(
          splash: Image.asset(
            "assets/images/splash.png",
          ),
          nextScreen: _getScreenId(),
          splashTransition: SplashTransition.scaleTransition,
          backgroundColor: Colors.black,
          duration: 3000,
          pageTransitionType: PageTransitionType.bottomToTop,
        ),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          FeedScreen.id: (context) => FeedScreen(),
        },
      ),
    );
  }
}

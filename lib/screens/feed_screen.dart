import 'package:firebase_backend/services/auth_service.dart';
import 'package:firebase_backend/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  static final String id = "feed_screen";
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Colors.blue,
      body: Center(
        child: FlatButton(
          onPressed: () => AuthService.logout(),
          child: Text("Logout"),
        ),
      ),
    );
  }
}

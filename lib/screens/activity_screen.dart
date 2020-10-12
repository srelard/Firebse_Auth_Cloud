import 'package:firebase_backend/config/config.dart';
import 'package:firebase_backend/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: Center(
          child: Text("ActivityScreen"),
        ));
  }
}

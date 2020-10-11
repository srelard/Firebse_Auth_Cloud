import 'package:firebase_backend/config/config.dart';
import 'package:firebase_backend/models/user_model.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  EditProfileScreen({this.user});
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Palette.appBar,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage("https://i.redd.it/dmdqlcdpjlwz.jpg"),
                ),
                FlatButton(
                  onPressed: () => print("Pressed"),
                  child: Text(
                    "Change Image",
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

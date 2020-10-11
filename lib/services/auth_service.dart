import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/feed_screen.dart';
import '../screens/login_screen.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  static void signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User signedInUser = authResult.user;
      if (signedInUser != null) {
        _firestore.collection("/users").doc(signedInUser.uid).set({
          "name": name,
          "email": email,
          "profileImageUrl": "",
          "bio": "Please describe yourself here.",
        });
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  static void logout() {
    _auth.signOut();
  }

  static void login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }
}

import 'package:flutter/material.dart';

class Palette {
  static const Color buttons = Colors.black54;
  static const Color buttonText = Colors.white;
  static const Color facebookBlue = Color(0xFF1777F2);
  static const Color appBar = Colors.white;
  static const Color activeColor = Colors.black;
  static const Color appBackground = Colors.white;

  static const LinearGradient createRoomGradient = LinearGradient(
    colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
  );

  static const Color online = Color(0xFF4BCB1F);

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26],
  );
}

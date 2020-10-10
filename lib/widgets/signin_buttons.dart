import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginButtonSvg extends StatelessWidget {
  final String assetName;

  const LoginButtonSvg({Key key, @required this.assetName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        onPressed: () => "Pressed",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SvgPicture.asset(
                assetName,
                semanticsLabel: 'Google',
                height: 36,
                //color: Colors.red,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text("RaisedButton SVG",
                style: TextStyle(color: Colors.black54, fontSize: 14)),
          ],
        ),
        color: Colors.white);
  }
}

class LoginButtonIcon extends StatelessWidget {
  final IconData iconName;

  const LoginButtonIcon({Key key, @required this.iconName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: () => "Test",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              iconName,
              color: Colors.white,
            ),
            SizedBox(
              width: 15,
            ),
            Text("RaisedButton",
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
        color: Colors.black54);
  }
}

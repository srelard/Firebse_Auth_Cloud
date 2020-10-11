import 'package:firebase_backend/screens/signup_screen.dart';
import 'package:firebase_backend/services/auth_service.dart';
import 'package:firebase_backend/widgets/signin_buttons.dart';
import 'package:firebase_backend/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginScreen extends StatefulWidget {
  static final String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String assetName = 'assets/images/google.svg';
  final _formKey = GlobalKey<FormState>();
  String _email, _password;

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AuthService.login(_email, _password);
      // Logging in the user w/ Firebase
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Places Nearby",
                style: TextStyle(
                  fontFamily: "Billabong",
                  fontSize: 50,
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "E-Mail",
                            //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))
                          ),
                          validator: (input) => !input.contains("@")
                              ? "Please enter a valid E-Mail"
                              : null,
                          onSaved: (input) => _email = input,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.disabled,
                          decoration: InputDecoration(
                            labelText: "Password",
                            //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                          ),
                          validator: (input) => input.length < 6
                              ? "Must be at least 6 characters"
                              : null,
                          onSaved: (input) => _password = input,
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 250,
                child: RaisedButton(
                  onPressed: _submit,
                  color: Palette.buttons,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    //side: BorderSide(color: Colors.red),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Log in",
                          style: TextStyle(
                              color: Palette.buttonText, fontSize: 14)),
                    ],
                  ),
                ),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                width: 250,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Need an account? ",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        height: 40,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Already have an account?"),
                    ),
                    Expanded(
                      child: Divider(
                        height: 40,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 250,
                child: SignInButton(
                  Buttons.Google,
                  text: 'Sign in with Google',
                  onPressed: () => "Google",
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
              Container(
                width: 250,
                child: GoogleSignInButton(
                  borderRadius: 10,
                  splashColor: Colors.white,
                  onPressed: () {},
                  textStyle: TextStyle(
                    fontSize: 14,
                    //fontWeight: FontWeight.w700,
                    //fontFamily: "Roboto",
                  ),
                ),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
              Container(
                width: 250,
                child: SignInButton(
                  Buttons.Apple,
                  text: 'Sign in with Apple',
                  onPressed: () => "Google",
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

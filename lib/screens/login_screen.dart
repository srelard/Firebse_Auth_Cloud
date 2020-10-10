import 'package:firebase_backend/screens/signup_screen.dart';
import 'package:firebase_backend/services/auth_service.dart';
import 'package:firebase_backend/widgets/signin_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
                          decoration: InputDecoration(labelText: "E-Mail"),
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
                          decoration: InputDecoration(labelText: "Password"),
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
                      Container(
                        width: 250,
                        child: SignInButtonBuilder(
                          text: 'Sign in with Email',
                          icon: Icons.email,
                          onPressed: _submit,
                          backgroundColor: Colors.black54,
                        ),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      ),
                      Container(
                        width: 250,
                        child: SignInButtonBuilder(
                          text: 'Register with Email',
                          icon: Icons.app_registration,
                          onPressed: () =>
                              Navigator.pushNamed(context, SignupScreen.id),
                          backgroundColor: Colors.black54,
                        ),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text("Already have account?"),
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
                        ),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      ),
                      Container(
                        width: 250,
                        child: SignInButton(
                          Buttons.AppleDark,
                          text: 'Sign in with Apple ID',
                          onPressed: () => "Google",
                        ),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

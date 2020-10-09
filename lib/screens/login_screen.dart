import 'package:firebase_backend/screens/signup_screen.dart';
import 'package:firebase_backend/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static final String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        child: FlatButton(
                            onPressed: _submit,
                            child: Text("Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            color: Colors.blue),
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        width: 250,
                        child: FlatButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, SignupScreen.id),
                            child: Text("Go to Signup",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            color: Colors.blue),
                        padding: EdgeInsets.all(10),
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

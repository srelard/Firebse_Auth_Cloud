import 'package:firebase_backend/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static final String id = "signup_screen";
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name, _email, _password;

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AuthService.signUpUser(context, _name, _email, _password);
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
                          decoration: InputDecoration(labelText: "Name"),
                          validator: (input) => input.trim().isEmpty
                              ? "Please enter a valid name"
                              : null,
                          onSaved: (input) => _name = input,
                        ),
                      ),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.add_to_photos_outlined),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("Sign up",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ],
                            ),
                            color: Colors.blue),
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        width: 250,
                        child: FlatButton(
                            onPressed: () => Navigator.pop(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.login),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("Go to login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ],
                            ),
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

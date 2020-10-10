import 'package:firebase_backend/config/config.dart';
import 'package:firebase_backend/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "At least 6 characters"),
                          validator: (input) => input.length < 6
                              ? "Must be at least 6 characters"
                              : null,
                          onSaved: (input) => _password = input,
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  )),
              Container(
                width: 250,
                child: RaisedButton(
                  elevation: 2,
                  onPressed: _submit,
                  color: Palette.buttons,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    //side: BorderSide(color: Colors.blue),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Sign up",
                          style: TextStyle(
                              color: Palette.buttonText, fontSize: 14)),
                    ],
                  ),
                ),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                width: 250,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Back to Login",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_test/page/user.dart';

class LoginPage  extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState  extends State<LoginPage>{

  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    log('Current page : LoginPage');
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: style,
      onChanged: (value) => {email = value},
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      onChanged: (value) => {password = value},
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: onLoginButton,
        child: Text("Login",
          textAlign: TextAlign.center,
          style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
      body: Center(
        child: Container(
          //color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(height: 35.0),
                loginButon,
                SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onLoginButton(){
    print('Login button pressed');
    print('Credentials : $email - $password');
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => User()));
  }
} 
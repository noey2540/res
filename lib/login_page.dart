import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './admin_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key key,
  }) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController ctrlUsername = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _onLogin() async {
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      String username = ctrlUsername.text;
      String password = ctrlPassword.text;

      print(username);
      print(password);

      if (username.toLowerCase() == 'admin' &&
          password.toLowerCase() == 'admin') {
        Navigator.of(context).pop();
                navigateToAdminPage(context);
      } else {
        print('Invalid username/password');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[300],
          title: Text('เข้าสู่ระบบ'),
        ),
        body: Container(
            color: Colors.pink[50],
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          colors: [Colors.purple[100], Colors.pink[100]])),
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(24),
                  child: Form(
              key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildTextFieldUser(),
                      buildTextFieldPass(),
                      buildButtonSignIn(),
                    ],
                  ))),
            )));
  }

  Container buildTextFieldUser() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.purple[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: ctrlUsername,
            decoration: InputDecoration.collapsed(hintText: "USERNAME"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldPass() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.purple[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: ctrlPassword,
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "PASSWORD"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildButtonSignIn() {
    return Container(
        constraints: BoxConstraints.expand(height: 50),
        child: FlatButton(
            child: Text("Sign in",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            onPressed: () {
              _onLogin() ;
            }),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.pink[200]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }
}

navigateToAdminPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return AdminPage();
  }));
}

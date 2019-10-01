import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poppop/submitorderpage.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key,
  
  }) : super(key: key);

  
  
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text('เข้าสู่ระบบ'),
        ),
        body:Container(
            color: Colors.green[50],
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          colors: [Colors.yellow[100], Colors.green[100]])),
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      buildTextFieldUser(),
                      buildTextFieldPass(),
                      buildButtonSignIn(),
                    ],
                  )),
            ))
            );
}

Container buildTextFieldUser() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "USERNAME"),
            style: TextStyle(fontSize: 18)));
  }
Container buildTextFieldPass() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "PASSWORD"),
            style: TextStyle(fontSize: 18)));
  }
Container buildButtonSignIn() {
    return Container(
        constraints: BoxConstraints.expand(height: 50),
        child: FlatButton(
            child: Text("Sign in",textAlign: TextAlign.center,style: TextStyle(fontSize: 18, color: Colors.white)),
            onPressed: () {navigateToSubmitOrderPage(context);}
            ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.green[200]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

}

navigateToSubmitOrderPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return SubmitOrderPage();
  }));
}
import 'package:flutter/material.dart';
import '../navigate.dart';

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

      if (username.toLowerCase() == 'sirilak' &&
          password.toLowerCase() == 'admin2324') {
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
          backgroundColor: Colors.orange[300],
          title: Text('เข้าสู่ระบบ'),
        ),
        body: Container(
            color: Colors.orange[50],
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          colors: [Colors.yellow[100], Colors.orange[100]])),
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
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: ctrlUsername,
            decoration: InputDecoration.collapsed(hintText: "USERNAME"),
            style: TextStyle(fontSize: 26, fontFamily: 'maaja')));
  }

  Container buildTextFieldPass() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: ctrlPassword,
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "PASSWORD"),
            style: TextStyle(fontSize: 26, fontFamily: 'maaja')));
  }

  Container buildButtonSignIn() {
    return Container(
        constraints: BoxConstraints.expand(height: 70),
        child: FlatButton(
            child: Text("Sign in",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30, color: Colors.white, fontFamily: 'maaja')),
            onPressed: () {
              _onLogin();
            }),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.orange[200]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }
}

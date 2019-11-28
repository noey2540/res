import 'package:flutter/material.dart';
import 'navigate.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LALLABUY',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Homepage'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LALLABUY'),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildButton('ADMIN'),
                    buildButton('ค้นหาร้านอาหาร'),
                  ],
                )),
          )),
    );
  }

  Widget buildButton(String text) {
    return Container(
        constraints: BoxConstraints.expand(height: 50),
        child: FlatButton(
            child: Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            onPressed: () {
              navigateToLoginPage(context);
            }),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.pink[200]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }
}

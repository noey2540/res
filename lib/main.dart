import 'package:flutter/material.dart';
import './login_page.dart';
import './search_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LALLABUY',
      theme: ThemeData(
        primarySwatch: Colors.orange,
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
            color: Colors.orange[50],
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          colors: [Colors.yellow[100], Colors.orange[100]])),
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildButtonAdmin(),
                      buildButtonSearch(),
                    ],
                  )),
            )),
    );
  }
  Container buildButtonAdmin() {
    return Container(
        constraints: BoxConstraints.expand(height: 70),
        child: FlatButton(
            child: Text("ADMIN",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.white,fontFamily: 'maaja')),
            onPressed: () {
              navigateToLoginPage(context);
            }),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.orange[200]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }
  Container buildButtonSearch() {
    return Container(
        constraints: BoxConstraints.expand(height: 70),
        child: FlatButton(
            child: Text("ค้นหาร้านอาหาร",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.white,fontFamily: 'maaja')),
            onPressed: () {
              navigateToSearchPage(context);
            }),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.orange[200]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }
}
navigateToSearchPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SearchPage();
    }));
  }

  navigateToLoginPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

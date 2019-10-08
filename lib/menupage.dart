import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poppop/orderpage.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key, this.docID}) : super(key: key);

  final String docID;

  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text('เมนูอาหาร'),
        ),
        body: Container(
            color: Colors.green[50],
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('menus')
                  .where('store_id', isEqualTo: widget.docID)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                      // if (document['store_id'] == widget.docID) {
                      return Center(
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(colors: [
                                  Colors.yellow[100],
                                  Colors.green[100]
                                ])),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text(document['name']),
                                  subtitle: Text(document['price'].toString()),
                                  leading: Image.network(document["image"][0]),
                                  trailing: Text(
                                    '$_counter',
                                  ),
                                ),
                                FlatButton(
                                    onPressed: _incrementCounter,
                                    child: Icon(Icons.add))
                              ],
                            ),
                          ),
                        ),
                      );
                      // }
                    }).toList());
                }
              },
            )),
        floatingActionButton: FloatingActionButton(
            child: Text("Next", style: TextStyle(color: Colors.white)),
            onPressed: () => navigateToOrderPage(context)));
  }
}

navigateToOrderPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return OrderPage();
  }));
}

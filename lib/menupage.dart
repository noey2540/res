import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MenuPage extends StatefulWidget {
  MenuPage({Key key,
  this.docID
  }) : super(key: key);

  final String docID;
  
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          title: Text(widget.docID),
        ),
        body: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('menus').where('store_id', isEqualTo: widget.docID ).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                // if (document['store_id'] == widget.docID) {
                  return Center(
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text(document['name']),
                            subtitle: Text(document['price'].toString()),
                            leading: Image.network(document["image"][0]),
                          ),
                        ],
                      ),
                    ),
                  );
                // }
              }).toList()
            );
        }
      },
    )
    );
}
}
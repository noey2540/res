import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreMenuPage extends StatefulWidget {
  StoreMenuPage({Key key, this.docID, this.store_name}) : super(key: key);

  final String docID;
  final String store_name;

  StoreMenuPageState createState() => StoreMenuPageState();
}

class StoreMenuPageState extends State<StoreMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: Text(widget.store_name),
      ),
      body: Container(
          color: Colors.pink[50],
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('menus')
                .where('store_id', isEqualTo: widget.docID)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading...');
                default:
                  return ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                    // if (document['store_id'] == widget.docID) {
                    return Center(
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(colors: [
                                Colors.purple[100],
                                Colors.pink[100]
                              ])),
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
                      ),
                    );
                    // }
                  }).toList());
              }
            },
          )),
    );
  }
}

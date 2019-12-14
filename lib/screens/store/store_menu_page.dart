import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

class StoreMenuPage extends StatefulWidget {
  StoreMenuPage({Key key, this.docID, this.storeName}) : super(key: key);

  final String docID;
  final String storeName;

  StoreMenuPageState createState() => StoreMenuPageState();
}

class StoreMenuPageState extends State<StoreMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          title: Text(widget.storeName),
        ),
        body: Container(
            color: Colors.orange[50],
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('menus')
                    .where('store_id', isEqualTo: widget.docID)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('Loading...');
                    default:
                      return ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                        return Center(
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(colors: [
                                    Colors.yellow[100],
                                    Colors.orange[100]
                                  ])),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ListTile(
                                    title: Text(document['name'],
                                        style: TextStyle(
                                            fontSize: 28,
                                            color: Colors.black,
                                            fontFamily: 'maaja')),
                                    subtitle: Text(document['price'].toString(),
                                        style: TextStyle(
                                            fontSize: 28, fontFamily: 'maaja')),
                                    trailing: Image.network(
                                        document["image"][0],
                                        width: 150,
                                        height: 100),
                                  ),
                                  ListTile(
                                    title: Text(document['name']),
                                    subtitle:
                                        Text(document['price'].toString()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList());
                  }
                })));
  }
}

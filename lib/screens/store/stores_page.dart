import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../navigate.dart';
import '../map/map.dart';

class StoresPage extends StatefulWidget {
  StoresPage({Key key, this.category}) : super(key: key);
  final String category;
  StoresPageState createState() => StoresPageState();
}

class StoresPageState extends State<StoresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          title: Text(widget.category),
        ),
        body: Container(
            color: Colors.orange[50],
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('store')
                  .where("store_category", isEqualTo: widget.category)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
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
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text(document['store_name'],
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                          fontFamily: 'maaja')),
                                  subtitle: Image.network(
                                    document["image"][0],
                                    width: 300,
                                    height: 200,
                                  ),
                                ),
                                ButtonTheme.bar(
                                  child: ButtonBar(
                                    children: <Widget>[
                                      FlatButton(
                                        child: Icon(Icons.location_on),
                                        onPressed: () {
                                          print(document['location'][0]);
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Map(
                                                storeName:
                                                    document['store_name'],
                                                storeCate:
                                                    document['store_category'],
                                                storeLat: document['location']
                                                    [0],
                                                storeLng: document['location']
                                                    [1]);
                                          }));
                                        },
                                      ),
                                      FlatButton(
                                        child: const Text('MENU',
                                            style: TextStyle(
                                                fontSize: 28,
                                                fontFamily: 'maaja')),
                                        onPressed: () {
                                          navigateToMenuPage(
                                              context,
                                              document.documentID,
                                              document['store_name']);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        );
                      }).toList(),
                    );
                }
              },
            )));
  }
}

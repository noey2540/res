import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../navigate.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key key, this.docID, this.storeName}) : super(key: key);
  final String docID;
  final String storeName;
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Future _onDelete(String docID) async {
    Firestore.instance.collection('store').document(docID).delete();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.orange[300],
            title: Text('Restaurants'),
            actions: <Widget>[
              FlatButton(
                child: const Text('Input Restaurant',
                    style: TextStyle(fontSize: 28, fontFamily: 'maaja')),
                onPressed: () {
                  navigateToNewStorePage(context);
                },
              )
            ]),
        body: Container(
          color: Colors.orange[50],
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('store').snapshots(),
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
                                        fontSize: 28,
                                        color: Colors.black,
                                        fontFamily: 'maaja')),
                                subtitle: Text(document['store_category'],
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Colors.black,
                                        fontFamily: 'maaja')),
                                onTap: () {
                                  navigateToAdminMenuPage(
                                      context,
                                      document.documentID,
                                      document['store_name']);
                                },
                              ),
                              ButtonTheme.bar(
                                child: ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                      child: const Text('Update',
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontFamily: 'maaja')),
                                      onPressed: () {
                                        navigateToUpdateStorePage(
                                            context,
                                            document.documentID,
                                            document['store_name']);
                                      },
                                    ),
                                    FlatButton(
                                        child: const Text('Delete',
                                            style: TextStyle(
                                                fontSize: 28,
                                                fontFamily: 'maaja')),
                                        onPressed: () {
                                          _onDelete(document.documentID);
                                        }),
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
          ),
        ));
  }
}

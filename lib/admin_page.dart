import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './screens/store/update_store.dart';
import './screens/store/new_store.dart';

class AdminPage extends StatefulWidget {
  AdminPage({
    Key key,
  }) : super(key: key);

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
          backgroundColor: Colors.green[300],
          title: Text('Admin'),
          actions: <Widget>[
            FlatButton(
                       child: const Text('Input'),
                       onPressed: () {navigateToNewStorePage(context);},
                                    )]
        ),
        body: Container(
          color: Colors.green[50],
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('store')

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
                                title: Text(document['store_name'],
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black)),
                                // subtitle: Image.network(document["image"][0]),
                              ),
                              ButtonTheme.bar(
                                // make buttons use the appropriate styles for cards
                                child: ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                      child: const Text('Update'),
                                      onPressed: () {
                                        navigateToUpdateStorePage(
                                            context, document.documentID);
                                      },
                                    ),
                                    FlatButton(
                                      child: const Text('Delete'),
                                      onPressed: () {
                                           _onDelete(document.documentID);
                                      }
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
          ),
        ));
  }
}

navigateToUpdateStorePage(BuildContext context, String docID) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return UpdateStore(docID: docID);
  }));
}
navigateToNewStorePage(BuildContext context,) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return NewStore();
  }));
}

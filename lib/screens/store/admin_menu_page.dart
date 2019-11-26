import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './new_menu.dart';
import './update_menu.dart';

class AdminMenuPage extends StatefulWidget {
  AdminMenuPage({
    Key key, this.docID,this.store_name
  }) : super(key: key);

  final String docID;
  final String store_name;
  _AdminMenuPageState createState() => _AdminMenuPageState();
}

class _AdminMenuPageState extends State<AdminMenuPage> {
  Future _onDelete(String docID) async {
    Firestore.instance.collection('menus').document(docID).delete();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.orange[300],
            title: Text(widget.store_name),
            actions: <Widget>[
              // FlatButton(
              //   child: const Text('Input Menu'),
              //   onPressed: () {
              //     navigateToNewMenuPage(context, widget.docID);
              //   },
              // )
            ]),
        body: Container(
          color: Colors.orange[50],
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('menus')
                  .where('store_id', isEqualTo: widget.docID)
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
                      // if (document['store_id'] == widget.docID) {
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
                                  title: Text(document['name']),
                                  subtitle: Text(document['price'].toString()),
                                  leading: Image.network(document["image"][0]),
                                  
                                ),
                              ButtonTheme.bar(
                                
                                child: ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                child: const Text('Input'),
                onPressed: () {
                  navigateToNewMenuPage(context, widget.docID);
                },
              ),
                                    FlatButton(
                                      child: const Text('Update'),
                                      onPressed: () {
                                        navigateToUpdateMenuPage(
                                            context, document.documentID,document['name']);
                                      },
                                    ),
                                    FlatButton(
                                        child: const Text('Delete'),
                                        onPressed: () {
                                          _onDelete(document.documentID);
                                        }),
                                  ],
                                ),
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
            ),
        ));
  }
}



navigateToNewMenuPage(
  BuildContext context,String docID) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return NewMenu(docID: docID);
  }));
}

navigateToUpdateMenuPage(BuildContext context, String docID,String name) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return UpdateMenu(docID: docID,name: name);
  }));
}

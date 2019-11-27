import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './screens/store/update_store.dart';
import './screens/store/admin_menu_page.dart';
import './screens/store/new_store.dart';

class AdminPage extends StatefulWidget {
  AdminPage({
    Key key, this.docID,this.store_name
  }) : super(key: key);
   final String docID;
  final String store_name;
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
                child: const Text('Input Restaurant'),
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
                                        fontSize: 20, color: Colors.black,fontFamily: 'maaja')),
                                subtitle: Text(document['store_category'],
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black,fontFamily: 'maaja')),
                                //  subtitle: Image.network(document["image"][0],width: 150,
                                // height: 100),
                                onTap: () {
                                  navigateToAdminMenuPage(
                                      context, document.documentID,document['store_name']);
                                },
                              ),
                              ButtonTheme.bar(
                                // make buttons use the appropriate styles for cards
                                child: ButtonBar(
                                  children: <Widget>[
                                    
                                    FlatButton(
                                      child: const Text('Update'),
                                      onPressed: () {
                                        navigateToUpdateStorePage(
                                            context, document.documentID,document['store_name']);
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

navigateToUpdateStorePage(BuildContext context, String docID, String store_name) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return UpdateStore(docID: docID,store_name: store_name);
  }));
}

navigateToNewStorePage(
  BuildContext context,
) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return NewStore();
  }));
}

navigateToAdminMenuPage(BuildContext context, String docID,String store_name) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return AdminMenuPage(docID: docID,store_name: store_name);
  }));
}

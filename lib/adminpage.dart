import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poppop/updatestorepage.dart';
import 'package:poppop/inputstorepage.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key key,}) : super(key: key);
 
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text('Admin'),
          actions: <Widget>[
          FlatButton(
                                          child: const Text('Input'),
                                          onPressed: () => navigateToInputStorePage(context),
                                        )],
        ),
        
        body: Container(
            color: Colors.green[50],
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('store')
                  .where("store_category")
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                          ),
                          
                          
                        );
                      }).toList(),
                    );
                    
                }
              },
            ),
            
            )
            
            );
  }
}

navigateToUpdateStorePage(BuildContext context, String docID) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return UpdateStorePage(docID: docID);
  }));
}
navigateToInputStorePage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return InputStorePage();
  }));
}

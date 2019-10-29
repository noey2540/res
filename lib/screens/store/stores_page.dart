import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './store_menu_page.dart';
import '../../map.dart';

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
          backgroundColor: Colors.green[300],
          title: Text(widget.category),
        ),
        body: Container(
            color: Colors.green[50],
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
                                  Colors.green[100]
                                ])),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.location_on),
                                  title: Text(document['store_name'],
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                  subtitle: Image.network(document["image"][0]),
                                  onTap: () {
                                    print(document['location'][0]);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Map(
                                          storeName: document['store_name'],
                                          storeLat: document['location'][0],
                                          storeLng: document['location'][1]);
                                    }));
                                  },
                                ),
                                ButtonTheme.bar(
                                  // make buttons use the appropriate styles for cards
                                  child: ButtonBar(
                                    children: <Widget>[
                                      FlatButton(
                                        child: const Text('MENU'),
                                        onPressed: () {
                                          navigateToMenuPage(
                                              context, document.documentID);
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

navigateToMenuPage(BuildContext context, String docID) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return StoreMenuPage(docID: docID);
  }));
}

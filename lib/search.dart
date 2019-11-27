import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'map.dart';
import 'package:poppop/screens/store/store_menu_page.dart';


class Search extends StatefulWidget {
  Search(
      {Key key,
      this.storeName,
      this.storeCate,
      this.storeLat,
      this.storeLng,
      this.hereLat,
      this.hereLng,
      })
      : super(key: key);
  final String storeName;
  final String storeCate;
  final double storeLat;
  final double storeLng;
  final double hereLat;
  final double hereLng;
  


  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  static double lat ;
  static double lng ;
  static double lat2 ;
  static double lng2 ;
  // _search() async{
  //   if (widget.hereLat - 0.000010 == lat &&
  //       widget.hereLng - 0.000010 == lng);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          title: Text('Restuarants'),
          
        ),
        body: Container(
            color: Colors.orange[50],
            
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('store')
                  .where('location[0]', isLessThanOrEqualTo: [widget.hereLng]).limit(5)
                  // .where("location", isLessThanOrEqualTo: [widget.hereLng])
                  .snapshots(),
                  
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                                        //        print(widget.hereLat);
                                        // print(widget.hereLng);
                                        print(lat);
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
                                          fontSize: 20, color: Colors.black)),
                                  subtitle: Image.network(document["image"][0],width: 300,
                                height: 200,),
                                  
                                ),
                                ButtonTheme.bar(
                                  
                                  child: ButtonBar(
                                    children: <Widget>[
                                      FlatButton(
                                        child: Icon(Icons.location_on),
                                        
                                        onPressed: () {
                                    print(document['location'][0]);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Map(
                                          storeName: document['store_name'],
                                          storeCate: document['store_category'],
                                          storeLat: document['location'][0],
                                          storeLng: document['location'][1]);
                                    }));
                                  },
                                      ),
                                      FlatButton(
                                        child: const Text('MENU'),
                                        onPressed: () {
                                          navigateToMenuPage(
                                              context, document.documentID, document['store_name']);
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
            )
            )
            );
  }
    
navigateToMenuPage(BuildContext context, String docID,String store_name) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return StoreMenuPage(docID: docID,store_name: store_name);
  }));
}
}
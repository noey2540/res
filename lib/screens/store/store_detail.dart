import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreDetail extends StatefulWidget {
  StoreDetail({Key key, this.docID}) : super(key: key);

  final String docID;

  StoreDetailState createState() => StoreDetailState();
}

class StoreDetailState extends State<StoreDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text('เมนูอาหาร'),
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('store')
                .document(widget.docID)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading");
              }
              var document = snapshot.data;
              return Container(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: SingleChildScrollView(
                      child: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Text(document['store_name'])]),
                  )));
            }));
  }
}

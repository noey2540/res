import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateStorePage extends StatefulWidget {
  UpdateStorePage({
    Key key,this.docID
  }) : super(key: key);
final String docID;
  _UpdateStorePageState createState() => _UpdateStorePageState();
}

class _UpdateStorePageState extends State<UpdateStorePage> {
  String dropdownValue ='';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text('UpdateStore'),
        ),
        body: Container(
            color: Colors.green[50],
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('store')
                  .document(widget.docID)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot snapshot) {
                    print(snapshot.data);
                    var document = snapshot.data;
                    return ListView(
          children: <Widget>[
                  TextFormField(
                    initialValue: document['store_name'],
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_balance),
                      hintText: 'กรุณากรอกชื่อร้าน',
                      labelText: 'ชื่อร้าน',
                    ),
                    // onSaved: (val) => newStore.storename = val,
                  ),
                  Row(
                  children: <Widget>[
                  Icon(Icons.beenhere),
                  Text('    ประเภทร้านอาหาร                  '),
                  DropdownButton<String>(
                        value: document['store_category'],
                        onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                        // 
                        },
                        items: <String>[
                          'ปิ้งย่าง',
                          'ร้านอาหาร',
                          'ร้านส้มตำ',
                          'ร้านกาแฟ',
                          'ร้านน้ำชา'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        
                      ),
                  ]
                  ),
                  Row(
                  children: <Widget>[
                  RaisedButton(
                    // onPressed: getImage,
                    child: Icon(Icons.add_a_photo),
                  ),
                  // Center(
                  //         child: _image == null
                  //             ? Text('No image selected.')
                  //             : Image.file(_image,width: 250,height: 150,),
                          
                  //       ),
                  
                  ]
                  ),
                  Row(
                  children: <Widget>[
                  RaisedButton(
                        child: Text('เรียกตำแหน่งที่ตั้ง'),
                        onPressed: () {
                         
                        }
                  ),
                  ],),
                  Text('latitude:'),
                  Text( ''
                  ),
                  Text('longitude:'),
                  Text(
                    ''
                  ),
                  
                  Container(
                      padding: EdgeInsets.only(),
                      child: RaisedButton(
                        child: Text('Submit'),
                        // onPressed: _onSubmit,
                      )),
                ],
        );
              },
            ),
            
            ));
  }
}

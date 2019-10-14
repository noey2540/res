import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InputStorePage extends StatefulWidget {
  InputStorePage({
    Key key,
  }) : super(key: key);

  _InputStorePageState createState() => _InputStorePageState();
}

class _InputStorePageState extends State<InputStorePage> {
  String dropdownValue = "ปิ้งย่าง";
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text('Input Data'),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_balance),
                    hintText: 'กรุณากรอกชื่อร้าน',
                    labelText: 'ชื่อร้าน',
                  ),
                ),
                Row(children: <Widget>[
                  Icon(Icons.beenhere),
                  Text('    ประเภทร้านอาหาร                  '),
                  DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
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
                ]),
                Row(children: <Widget>[
                  Icon(Icons.image),
                  Text(
                    '    รูปร้าน',
                  ),
                ]),
                Row(children: <Widget>[
                  Icon(Icons.location_searching),
                  Text(
                    '    ตำแหน่งที่ตั้ง',
                  ),
                ]),
                Container(
                    padding: EdgeInsets.only(),
                    child: RaisedButton(
                      child: Text('Submit'),
                      onPressed: null,
                    )),
              ],
            ),
          ),
        ));
  }
}

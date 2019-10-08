import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubmitOrderPage extends StatefulWidget {
  SubmitOrderPage({
    Key key,
  }) : super(key: key);

  _SubmitOrderPageState createState() => _SubmitOrderPageState();
}

class _SubmitOrderPageState extends State<SubmitOrderPage> {
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
                Text(
                  "ชื่อร้าน",
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: ''),
                ),
                Text(
                  "ประเภทร้านอาหาร",
                  style: TextStyle(fontSize: 18),
                ),
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
                Text(
                  "รูปร้าน",
                  style: TextStyle(fontSize: 18),
                ),
                FlatButton(child: Icon(Icons.image)),
                Text(
                  "ละติจูด",
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: ''),
                ),
                Text(
                  "ลองจิจูด",
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: ''),
                ),
                FlatButton(
                    color: Colors.red[300],
                    child: Text("Next", style: TextStyle(color: Colors.black)))

                //onPressed: () => navigateToSecondPage(context))
              ],
            ),
          ),
        ));
  }
}

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text(''),
        ),
        body: Container());
  }
}

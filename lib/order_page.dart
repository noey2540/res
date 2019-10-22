import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderPage extends StatefulWidget {
  OrderPage({
    Key key,
  }) : super(key: key);

  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text('รายการสั่งซื้อ'),
        ),
        body: Container(
          color: Colors.green[50],
        ));
  }
}

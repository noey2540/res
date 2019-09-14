import 'package:flutter/material.dart';

class MySecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          title: Text("Second Page"),
        ),
        body: ListView(
          children: <Widget>[
            Text(
              'Input Data',
              style: TextStyle(fontSize: 22),
            ),
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'รหัสร้าน'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'กรุณากรอกรหัสร้าน'),
            ),
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'ชื่อร้าน'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'กรุณากรอกชื่อร้าน'),
            ),
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'ประเภท'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'กรุณากรอกประเภท'),
            ),
            FlatButton(
                color: Colors.red[300],
                child: Text("Next", style: TextStyle(color: Colors.black)))

                //onPressed: () => navigateToSecondPage(context))
          ],
        ));
  }
}

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/menu.dart';
import '../../../services/image_service.dart';
import 'package:flutter/services.dart';
import '../../navigate.dart';

class UpdateMenu extends StatefulWidget {
  UpdateMenu({Key key, this.docID, this.name}) : super(key: key);
  final String docID;
  final String name;
  UpdateMenuState createState() => UpdateMenuState();
}

class UpdateMenuState extends State<UpdateMenu> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Menu newMenu = Menu();

  void _onUpdate() async {
    final FormState form = _formKey.currentState;
    form.save();

    print('Form save called, newContact is now up to date...');
    print('Name: ${newMenu.name}');
    print('price: ${newMenu.price}');
    print(_image);
    String imgUrl = await onImageUploading(_image);
    print(imgUrl);

    if (imgUrl.isNotEmpty) {
      Firestore.instance.collection('menus').document(widget.docID).updateData({
        'name': newMenu.name,
        'price': newMenu.price,
        'image': [imgUrl],
      });
    }
    _alertupdate();
  }

  Future<void> _alertupdate() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.orange[50],
          title: Text('Update Menu Success',
              style: TextStyle(fontSize: 28, fontFamily: 'maaja')),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok',
                  style: TextStyle(fontSize: 26, fontFamily: 'maaja')),
              onPressed: () {
                Navigator.of(context).pop();
                navigateToAdminPage(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          title: Text(widget.name),
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('menus')
                .document(widget.docID)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading");
              }
              var document = snapshot.data;
              return SafeArea(
                  top: false,
                  bottom: false,
                  child: Container(
                      color: Colors.orange[50],
                      child: Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(colors: [
                                    Colors.yellow[100],
                                    Colors.orange[100]
                                  ])),
                              margin: EdgeInsets.all(32),
                              padding: EdgeInsets.all(24),
                              child: Form(
                                  key: _formKey,
                                  child: ListView(
                                    children: <Widget>[
                                      TextFormField(
                                        initialValue: document['name'],
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.fastfood),
                                          hintText: 'กรุณากรอกชื่ออาหาร',
                                          labelText: 'ชื่ออาหาร',
                                        ),
                                        style: TextStyle(
                                            fontSize: 28, fontFamily: 'maaja'),
                                        onSaved: (val) => newMenu.name = val,
                                      ),
                                      TextFormField(
                                        initialValue:
                                            document['price'].toString(),
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.attach_money),
                                          hintText: 'กรุณากรอกราคา',
                                          labelText: 'ราคา',
                                        ),
                                        style: TextStyle(
                                            fontSize: 28, fontFamily: 'maaja'),
                                        keyboardType: TextInputType.number,
                                        onSaved: (val) =>
                                            newMenu.price = double.parse(val),
                                      ),
                                      Row(children: <Widget>[
                                        RaisedButton(
                                          onPressed: getImage,
                                          child: Icon(Icons.add_a_photo),
                                          color: Colors.orange[200],
                                        ),
                                      ]),
                                      Row(children: <Widget>[
                                        _image == null
                                            ? Image.network(
                                                document["image"][0],
                                                width: 250,
                                                height: 150,
                                              )
                                            : Image.file(
                                                _image,
                                                alignment: Alignment.center,
                                                width: 250,
                                                height: 150,
                                              )
                                      ]),
                                      Container(
                                          padding: EdgeInsets.only(),
                                          child: RaisedButton(
                                            child: Text('Update',
                                                style: TextStyle(
                                                    fontSize: 28,
                                                    color: Colors.white,
                                                    fontFamily: 'maaja')),
                                            color: Colors.orange[200],
                                            onPressed: _onUpdate,
                                          )),
                                    ],
                                  ))))));
            }));
  }
}
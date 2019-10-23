import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/menu.dart';
import '../../services/image_service.dart';
import 'package:flutter/services.dart';
import './admin_menu_page.dart';

class UpdateMenu extends StatefulWidget {
  UpdateMenu({Key key, this.docID}) : super(key: key);
  final String docID;
  UpdateMenuState createState() => UpdateMenuState();
}

class UpdateMenuState extends State<UpdateMenu> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }
   Menu newMenu = new Menu();

 
  void _onUpdate() async {
    final FormState form = _formKey.currentState;
    form.save(); //This invokes each onSaved event

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
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Success'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                navigateToAdminMenuPage(context);
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
          backgroundColor: Colors.green[300],
          title: Text('UpdateMenu'),
        ),
        body: SafeArea(
            top: false,
            bottom: false,
            child: Form(
              key: _formKey,
              // color: Colors.green[50],
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('menus')
                    .document(widget.docID)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  var document = snapshot.data;
                  return ListView(
                    children: <Widget>[
                      TextFormField(
                        initialValue: document['name'],
                        decoration: InputDecoration(
                    icon: Icon(Icons.account_balance),
                    hintText: 'กรุณากรอกชื่ออาหาร',
                    labelText: 'ชื่ออาหาร',
                  ),
                  onSaved: (val) => newMenu.name = val,
                      ),
                      Row(children: <Widget>[
                  TextFormField(
                    initialValue: document['price'].toString(),
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_balance),
                    hintText: 'กรุณากรอกราคา',
                    labelText: 'ราคา',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => newMenu.price =double.parse(val) ,
                )
                ],),
                      Row(children: <Widget>[
                        RaisedButton(
                            onPressed: getImage,
                            child: Icon(Icons.add_a_photo)),
                        _image == null
                            ? Image.network(
                                document["image"][0],
                                width: 250,
                                height: 150,
                              )
                            : Image.file(
                                _image,
                                width: 250,
                                height: 150,
                              )
                      ]),
                    
                      Container(
                          padding: EdgeInsets.only(),
                          child: RaisedButton(
                            child: Text('Update'),
                            onPressed: _onUpdate,
                          )),
                    ],
                  );
                },
              ),
            )));
  }
}

navigateToAdminMenuPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return AdminMenuPage();
  }));
}

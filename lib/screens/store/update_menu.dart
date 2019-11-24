import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/menu.dart';
import '../../services/image_service.dart';
import 'package:flutter/services.dart';
import './admin_menu_page.dart';
import '../../admin_page.dart';

class UpdateMenu extends StatefulWidget {
  UpdateMenu({Key key, this.docID,this.name}) : super(key: key);
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
          backgroundColor:Colors.pink[50],
          title: Text('Update Menu Success'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
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
          backgroundColor: Colors.pink[300],
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
            color: Colors.pink[50],
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          colors: [Colors.purple[100], Colors.pink[100]])),
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(24),
                  child: Form(
                      key: _formKey,
                      // color: Colors.green[50],
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                            initialValue: document['name'],
                            decoration: InputDecoration(
                              icon: Icon(Icons.fastfood),
                              hintText: 'กรุณากรอกชื่ออาหาร',
                              labelText: 'ชื่ออาหาร',
                            ),
                            onSaved: (val) => newMenu.name = val,
                          ),
                          TextFormField(
                            initialValue: document['price'].toString(),
                            decoration: InputDecoration(
                              icon: Icon(Icons.attach_money),
                              hintText: 'กรุณากรอกราคา',
                              labelText: 'ราคา',
                            ),
                            keyboardType: TextInputType.number,
                            onSaved: (val) => newMenu.price = double.parse(val),
                          ),
                          Row(children: <Widget>[
                            RaisedButton(
                                onPressed: getImage,
                                child: Icon(Icons.add_a_photo),
                                color: Colors.pink[200],),
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
                                child: Text('Update',style: TextStyle(fontSize: 18, color: Colors.white)),
                                 color: Colors.pink[200],
                                onPressed: _onUpdate,
                              )),
                        ],
                      ))))));
            }));
  }
}

navigateToAdminMenuPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return AdminMenuPage();
  }));
}
navigateToAdminPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return AdminPage();
  }));
}

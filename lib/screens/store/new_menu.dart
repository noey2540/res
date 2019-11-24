import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import '../../models/menu.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/image_service.dart';
import '../../admin_page.dart';

class NewMenu extends StatefulWidget {
  NewMenu({Key key, this.docID}) : super(key: key);
  final String docID;
  NewMenuState createState() => NewMenuState();
}

class NewMenuState extends State<NewMenu> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Menu newMenu = Menu();

  void _onSubmit(documentId) async {
    final FormState form = _formKey.currentState;
    form.save(); //This invokes each onSaved event

    print('Form save called, newContact is now up to date...');
    print('Name: ${newMenu.name}');
    print('price: ${newMenu.price}');
    print('store: ' + documentId);
    print(_image);
    String imgUrl = await onImageUploading(_image);
    print(imgUrl);

    if (imgUrl.isNotEmpty) {
      Firestore.instance.collection('menus').document().setData({
        'name': newMenu.name,
        'price': newMenu.price,
        'image': [imgUrl],
        'store_id': documentId
      });
    }
    _alertinput();
  }

  Future<void> _alertinput() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:Colors.pink[50],
          title: Text('Input Success'),
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
          title: Text('Input Data'),
        ),
        body: SafeArea(
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
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_balance),
                    hintText: 'กรุณากรอกชื่ออาหาร',
                    labelText: 'ชื่ออาหาร',
                  ),
                  onSaved: (val) => newMenu.name = val,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_balance),
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
                    color: Colors.pink[200],
                  ),
                  
                ]),
                Row(children: <Widget>[
                   _image == null
                        ? Text('No image selected.')
                        : Image.file(
                            _image,
                            width: 250,
                            height: 150,
                          ),
                  
                ]),
                Container(
                    padding: EdgeInsets.only(),
                    child: RaisedButton(
                      child: Text('Submit',style: TextStyle(fontSize: 18, color: Colors.white)),
                                 color: Colors.pink[200],
                      onPressed: () {
                        _onSubmit(widget.docID);
                      },
                    )),
              ],
            ),
          ),))
        )));
  }
}

navigateToAdminPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return AdminPage();
  }));
}

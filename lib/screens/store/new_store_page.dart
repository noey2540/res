import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import '../../models/store.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/image_service.dart';
import '../navigate.dart';

class NewStore extends StatefulWidget {
  NewStore({
    Key key,
  }) : super(key: key);

  NewStoreState createState() => NewStoreState();
}

class NewStoreState extends State<NewStore> {
  String dropdownValue = "ปิ้งย่าง";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  LocationData _startLocation;
  LocationData _currentLocation;

  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService = Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  Store newStore = Store();

  @override
  void initState() {
    super.initState();

    _initPlatformState();
  }

  _initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();

          _locationSubscription = _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            setState(() {
              _currentLocation = result;
            });
          });
          print(_currentLocation.latitude);
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          _initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _startLocation = location;
    });
  }

  void _onSubmit() async {
    final FormState form = _formKey.currentState;
    form.save();

    print('Form save called, newContact is now up to date...');
    print('Name: ${newStore.storeName}');
    print('Name: ${newStore.storeCategory}');
    print(_image);
    String imgUrl = await onImageUploading(_image);
    print(imgUrl);
    print(_startLocation.latitude);
    print(_startLocation.longitude);

    if (imgUrl.isNotEmpty) {
      Firestore.instance.collection('store').document().setData({
        'store_name': newStore.storeName,
        'store_category': newStore.storeCategory,
        'image': [imgUrl],
        'location': [_startLocation.latitude, _startLocation.longitude]
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
          backgroundColor: Colors.orange[50],
          title: Text('Input Success',
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
          title: Text('Input Restaurant'),
        ),
        body: SafeArea(
            top: false,
            bottom: false,
            child: Container(
              color: Colors.orange[50],
              child: Center(
                  child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                        colors: [Colors.yellow[100], Colors.orange[100]])),
                margin: EdgeInsets.all(32),
                padding: EdgeInsets.all(24),
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
                        style: TextStyle(fontSize: 28, fontFamily: 'maaja'),
                        onSaved: (val) => newStore.storeName = val,
                      ),
                      Row(children: <Widget>[
                        Icon(Icons.beenhere),
                        Text('ประเภทร้านอาหาร  ',
                            style:
                                TextStyle(fontSize: 28, fontFamily: 'maaja')),
                        DropdownButton<String>(
                          value: dropdownValue,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                            newStore.storeCategory = newValue;
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
                              child: Text(value,
                                  style: TextStyle(
                                      fontSize: 28, fontFamily: 'maaja')),
                            );
                          }).toList(),
                        ),
                      ]),
                      Row(children: <Widget>[
                        RaisedButton(
                          onPressed: getImage,
                          child: Icon(Icons.add_a_photo),
                          color: Colors.orange[200],
                        ),
                      ]),
                      Row(children: <Widget>[
                        _image == null
                            ? Text('No image selected.',
                                style: TextStyle(
                                    fontSize: 26, fontFamily: 'maaja'))
                            : Image.file(
                                _image,
                                width: 250,
                                height: 150,
                              ),
                      ]),
                      Row(children: <Widget>[
                        RaisedButton(
                            child: Text('เรียกตำแหน่งที่ตั้ง',
                                style: TextStyle(
                                    fontSize: 28, fontFamily: 'maaja')),
                            color: Colors.orange[200],
                            onPressed: () {
                              _initPlatformState();
                            }),
                      ]),
                      Text('latitude:',
                          style: TextStyle(fontSize: 28, fontFamily: 'maaja')),
                      Text(_startLocation == null
                          ? '-'
                          : _startLocation.latitude.toString()),
                      Text('longitude:',
                          style: TextStyle(fontSize: 28, fontFamily: 'maaja')),
                      Text(
                        _startLocation == null
                            ? '-'
                            : _startLocation.longitude.toString(),
                      ),
                      Container(
                          padding: EdgeInsets.only(),
                          child: RaisedButton(
                            child: Text('Submit',
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontFamily: 'maaja')),
                            color: Colors.orange[200],
                            onPressed: _onSubmit,
                          )),
                    ],
                  ),
                ),
              )),
            )));
  }
}

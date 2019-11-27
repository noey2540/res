import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../../models/store.dart';
import '../../services/image_service.dart';
import 'package:flutter/services.dart';
import '../../admin_page.dart';

class UpdateStore extends StatefulWidget {
  UpdateStore({Key key, this.docID,this.store_name}) : super(key: key);
  final String docID;
  final String store_name;
  UpdateStoreState createState() => UpdateStoreState();
}

class UpdateStoreState extends State<UpdateStore> {
  String dropdownValue = 'ปิ้งย่าง';
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

  void _onUpdate() async {
    final FormState form = _formKey.currentState;
    form.save();

    print('Form save called, newContact is now up to date...');
    print('Name: ${newStore.store_name}');
    print('Name: ${newStore.store_category}');
    print(_image);
    String imgUrl = await onImageUploading(_image);
    print(imgUrl);
    print(_startLocation.latitude);
    print(_startLocation.longitude);

    if (imgUrl.isNotEmpty) {
      Firestore.instance.collection('store').document(widget.docID).updateData({
        'store_name': newStore.store_name,
        // 'store_category': newStore.store_category,
        'image': [imgUrl],
        'location': [_startLocation.latitude, _startLocation.longitude]
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
          backgroundColor:Colors.orange[50],
          title: Text('Update Store Success'),
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
          backgroundColor: Colors.orange[300],
          title: Text(widget.store_name),
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
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('store')
                    .document(widget.docID)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading");
                  }
                  var document = snapshot.data;
                  return ListView(
                    children: <Widget>[
                      TextFormField(
                        initialValue: document['store_name'],
                        decoration: InputDecoration(
                          icon: Icon(Icons.account_balance),
                          hintText: 'กรุณากรอกชื่อร้าน',
                          labelText: 'ชื่อร้าน',
                        ),
                        onSaved: (val) => newStore.store_name = val,
                      ),
                      Row(children: <Widget>[
                        Icon(Icons.playlist_add_check),
                        Text('    ประเภทร้านอาหาร'),
                        DropdownButton<String>(
                          
                          value: document['store_category'],
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                            newStore.store_category = newValue;
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
                        RaisedButton(
                            onPressed: getImage,
                            child: Icon(Icons.add_a_photo),
                            color: Colors.orange[200],),
                        
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
                                width: 250,
                                height: 150,
                              )
                      ]),
                      Row(
                        children: <Widget>[
                          RaisedButton(
                              child: Text('เปลี่ยนตำแหน่งที่ตั้ง'),
                              color: Colors.orange[200],
                              onPressed: () {
                                _initPlatformState();
                              }),
                        ],
                      ),
                      Text('latitude:'),
                      Text(_startLocation == null
                          ? document["location"][0].toString()
                          : _startLocation.latitude.toString()),
                      Text('longitude:'),
                      Text(
                        _startLocation == null
                            ? document["location"][1].toString()
                            : _startLocation.longitude.toString(),
                      ),
                      Container(
                          padding: EdgeInsets.only(),
                          child: RaisedButton(
                            child: Text('Update',style: TextStyle(fontSize: 18, color: Colors.white,fontFamily: 'maaja')),
                            color: Colors.orange[200],
                            onPressed: _onUpdate,
                          )),
                    ],
                  );
                },
              ),
            ))))));
  }
}

navigateToAdminPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return AdminPage();
  }));
}

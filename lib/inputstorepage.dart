import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:poppop/store.dart';
import 'package:image_picker/image_picker.dart';
import 'image_service.dart';

class InputStorePage extends StatefulWidget {
  InputStorePage({
    Key key,
  }) : super(key: key);

  _InputStorePageState createState() => _InputStorePageState();
}

class _InputStorePageState extends State<InputStorePage> {
  String dropdownValue = "ปิ้งย่าง";
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

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

  Location _locationService  = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  Store newStore = new Store();

  @override
  void initState() {
    super.initState();

    _initPlatformState();
  }
  _initPlatformState() async { 
 await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);
    
    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();

          _locationSubscription = _locationService.onLocationChanged().listen((LocationData result) async {
              setState(() {
                _currentLocation = result;
              });
          });
          print(_currentLocation.latitude);
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if(serviceStatusResult){
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
      form.save(); //This invokes each onSaved event

      print('Form save called, newContact is now up to date...');
      print('Name: ${newStore.storename}');
      print('Name: ${newStore.storecategory}');
      print(_image);
      String imgUrl = await onImageUploading(_image);
      print(imgUrl);
      print(_startLocation.latitude);
      print(_startLocation.longitude);
      
      Firestore.instance.collection('store').document()
  .setData({ 'storename': newStore.storename, 'storecategory': newStore.storecategory, 'image' : [imgUrl],'location':[_startLocation.latitude,_startLocation.longitude]});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text('Input Data'),
        ),
        body: SafeArea(top: false,
        bottom: false,
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
                    onSaved: (val) => newStore.storename = val,
                  ),
                  Row(
                  children: <Widget>[
                  Icon(Icons.beenhere),
                  Text('    ประเภทร้านอาหาร                  '),
                  DropdownButton<String>(
                        value: dropdownValue,
                        onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                        newStore.storecategory = newValue;
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
                  ]
                  ),
                  Row(
                  children: <Widget>[
                  RaisedButton(
                    onPressed: getImage,
                    child: Icon(Icons.add_a_photo),
                  ),
                  Center(
                          child: _image == null
                              ? Text('No image selected.')
                              : Image.file(_image,width: 250,height: 150,),
                          
                        ),
                  
                  ]
                  ),
                  Row(
                  children: <Widget>[
                  RaisedButton(
                        child: Text('เรียกตำแหน่งที่ตั้ง'),
                        onPressed: () {
                          _initPlatformState();
                        }
                  ),
                  ],),
                  Text('latitude:'),
                  Text( _startLocation == null ?
                  '-' : _startLocation.latitude.toString()
                  ),
                  Text('longitude:'),
                  Text(
                    _startLocation == null ?
                  '-' : _startLocation.longitude.toString(),
                  ),
                  
                  Container(
                      padding: EdgeInsets.only(),
                      child: RaisedButton(
                        child: Text('Submit'),
                        onPressed: _onSubmit,
                      )),
                ],
        ),
        ),
        )
    );
  }
}

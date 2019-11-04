import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  Map({Key key, this.storeName,this.storeCate, this.storeLat, this.storeLng})
      : super(key: key);
  final String storeName;
  final String storeCate;
  final double storeLat;
  final double storeLng;

  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(
                widget.storeLat, widget.storeLng),
            zoom: 16,
          ),
          markers: {
            Marker(
                markerId: MarkerId("1"),
                position: LatLng(widget.storeLat,
                    widget.storeLng),
                infoWindow: InfoWindow(
                    title: widget.storeName,
                    snippet: widget.storeCate)),
          },
        ),
      ),
    );
  }
}

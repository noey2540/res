import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  Map({Key key, this.storeName, this.storeLat, this.storeLng})
      : super(key: key);
  final String storeName;
  final String storeLat;
  final String storeLng;

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
                double.parse(widget.storeLat), double.parse(widget.storeLng)),
            zoom: 16,
          ),
          markers: {
            Marker(
                markerId: MarkerId("1"),
                position: LatLng(double.parse(widget.storeLat),
                    double.parse(widget.storeLng)),
                infoWindow: InfoWindow(
                    title: widget.storeName,
                    snippet: "สนามบินนานาชาติของประเทศไทย")),
          },
        ),
      ),
    );
  }
}

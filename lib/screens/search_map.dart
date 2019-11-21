import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'dart:io';



class SearchMap extends StatefulWidget {
  SearchMap({Key key, this.storeName,this.storeCate, this.storeLat, this.storeLng, this.hereLat, this.hereLng,this.docId})
      : super(key: key);
  final String storeName;
  final String storeCate;
  final double storeLat;
  final double storeLng;
  final double hereLat;
  final double hereLng;
  final String docId;
  
  

  @override
  SearchMapState createState() => SearchMapState();
}

class SearchMapState extends State<SearchMap> {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  // List<Marker> allMarkers = [];
  // Widget loadMap() {
  //   return StreamBuilder(
  //     stream: Firestore.instance.collection('store').snapshots(),
  //     builder: (BuildContext context,
  //                 AsyncSnapshot<QuerySnapshot> snapshot) {
  //               if (snapshot.hasData) 
              
  //                   return Text('Loading...');
                    
  //                   for (int i = 0; i < snapshot.data.documents.length; i++){
  //                     allMarkers.add(new Marker(
  //                  position: LatLng(snapshot.data.documents[i]['location'][0].latitude,
  //                 snapshot.data.documents[i]['location'][1].longitude),
                  
                  
                  
  //             // Container(
  //             //       child: IconButton(
  //             //         icon: Icon(Icons.location_on),
  //             //         color: Colors.red,
  //             //         iconSize: 45.0,
  //             //         onPressed: () {
  //             //           print(snapshot.data.documents[i]['store_name']);
  //             //       }
  //             //       )
  //             // )
  //                     )
  //                     );
  //                   }
  //                   return SearchMap(
                      
  //           );
                  
  //                 }
  //                 );
  // }

  // List<Marker> markers = <Marker>[];
  // _searchNearby() async {
  //   await
  //     Marker(
  //               markerId: MarkerId("2"),
  //               position: LatLng(widget.storeLat,
  //                   widget.storeLng),
  //               infoWindow: InfoWindow(
  //                   title: widget.storeName,
  //                   snippet: widget.storeCate)
  //                   );

  // }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: 
        // loadMap()
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(
                widget.hereLat, widget.hereLng),
            zoom: 16,
          ),
          // markers: Set<Marker>.of(markers),
          markers: {
            Marker(
                markerId: MarkerId("1"),
                position: LatLng(widget.hereLat,
                    widget.hereLng),
                infoWindow: InfoWindow(
                    title: 'ตำแหน่งปัจจุบัน',
                    )
                    ),
            
            Marker(
                markerId: MarkerId("2"),
                position: LatLng(widget.storeLat,
                    widget.storeLng),
                infoWindow: InfoWindow(
                    title: widget.storeName,
                    snippet: widget.storeCate)
                    ),
            Marker(
                markerId: MarkerId("3"),
                position: LatLng(widget.storeLat,
                    widget.storeLng),
                infoWindow: InfoWindow(
                    title: widget.storeName,
                    snippet: widget.storeCate)
                    ),
            Marker(
                markerId: MarkerId("4"),
                position: LatLng(widget.storeLat,
                    widget.storeLng),
                infoWindow: InfoWindow(
                    title: widget.storeName,
                    snippet: widget.storeCate)
                    ),
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
  onPressed: () {
    // _searchNearby(); // 2
  },
  label: Text('Places Nearby'), // 3
  icon: Icon(Icons.place), // 4
)
      ),
    );
  
    
    }
}

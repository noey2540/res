import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart'as http;
import 'dart:async';
import 'dart:convert';
import 'package:poppop/models/error.dart';
import 'package:poppop/models/place_response.dart';
import 'package:poppop/models/result.dart';


class SearchMap extends StatefulWidget {
  SearchMap(
      {Key key,
      this.storeName,
      this.storeCate,
      this.storeLat,
      this.storeLng,
      this.hereLat,
      this.hereLng,
      this.docId,})
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

  List<Marker> markers = <Marker>[];
  static const String _API_KEY = 'AIzaSyBrgtqUUIw_Axob1JrHARoTN7VilA1QTm0';
  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";
  static double latitude = 14.019385;
  static double longitude = 99.992302;
  Error error;
  List<Result> places;
  bool searching = true;
  String keyword = 'Restaurant';

  Completer<GoogleMapController> _controller = Completer();
  

  static final CameraPosition _myLocation = CameraPosition(
    target: LatLng(latitude, longitude),
    zoom: 12,
    bearing: 15.0,
    tilt: 75.0
  );

void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context).loadString('assets/maps_style.json');
    controller.setMapStyle(value);
  }

  void searchNearby(double latitude, double longitude) async {
    setState(() {
      markers.clear();
    });
    String url =
        '$baseUrl?key=$_API_KEY&location=$latitude,$longitude&radius=10000&keyword=${keyword}';
    print(url);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _handleResponse(data);
    } else {
      throw Exception('An error occurred getting places nearby');
    }

    // make sure to hide searching
    setState(() {
      searching = false;
    });
  }

  void _handleResponse(data){
    // bad api key or otherwise
      if (data['status'] == "REQUEST_DENIED") {
        setState(() {
          error = Error.fromJson(data);
        });
        // success
      } else if (data['status'] == "OK") {
        setState(() {
          places = PlaceResponse.parseResults(data['results']);
          for (int i = 0; i < places.length; i++) {
            markers.add(
              Marker(
                markerId: MarkerId(places[i].placeId),
                position: LatLng(places[i].geometry.location.lat,
                    places[i].geometry.location.long),
                infoWindow: InfoWindow(
                    title: places[i].name, snippet: places[i].vicinity),
                onTap: () {},
              ),
            );
          }
        });
      } else {
        print(data);
      }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _myLocation,
        onMapCreated: (GoogleMapController controller) {
          _setStyle(controller);
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          searchNearby(latitude, longitude);
        },
        label: Text('Places Nearby'),
        icon: Icon(Icons.place),
      ),
    );
    // return MaterialApp(
    //   home: Scaffold(
    //       body:
    //           // loadMap()
    //           GoogleMap(
    //         onMapCreated: _onMapCreated,
    //         initialCameraPosition: CameraPosition(
    //           target: LatLng(widget.hereLat, widget.hereLng),
    //           zoom: 16,
    //         ),
    //         // markers: Set<Marker>.of(markers),
    //         markers: {
    //           Marker(
    //               markerId: MarkerId("1"),
    //               position: LatLng(widget.hereLat, widget.hereLng),
    //               infoWindow: InfoWindow(
    //                 title: 'ตำแหน่งปัจจุบัน',
    //               )),
    //           Marker(
    //               markerId: MarkerId("2"),
    //               position: LatLng(widget.storeLat, widget.storeLng),
    //               infoWindow: InfoWindow(
    //                   title: widget.storeName, snippet: widget.storeCate)),
    //           Marker(
    //               markerId: MarkerId("3"),
    //               position: LatLng(widget.storeLat, widget.storeLng),
    //               infoWindow: InfoWindow(
    //                   title: widget.storeName, snippet: widget.storeCate)),
    //           Marker(
    //               markerId: MarkerId("4"),
    //               position: LatLng(widget.storeLat, widget.storeLng),
    //               infoWindow: InfoWindow(
    //                   title: widget.storeName, snippet: widget.storeCate)),
    //         },
    //       ),
    //       floatingActionButton: FloatingActionButton.extended(
    //         onPressed: () {
    //           searchNearby(); // 2
    //         },
    //         label: Text('Places Nearby'), // 3
    //         icon: Icon(Icons.place), // 4
    //       )),
    // );
  }
}

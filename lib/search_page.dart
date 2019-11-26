import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/store/stores_page.dart';
import './screens/search_map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'search.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  LocationData _startLocation;
  LocationData _currentLocation;

  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService = Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;
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

  Widget _buildCardListView(String imagePath) {
    return Card(
      child: Image.network(imagePath),
    );
  }

  Widget titleSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: TextStyle(fontSize: 18)),
        Container(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildCardListView(
                  "http://hotelandresortthailand.com/read/wp-content/uploads/2018/12/IMG_8332-1.jpg"),
              _buildCardListView(
                  "https://scontent.fbkk12-2.fna.fbcdn.net/v/t1.0-9/67815495_344267133180231_8061166410681810944_n.jpg?_nc_cat=105&_nc_eui2=AeEWRCtV5cXefcFilyz-lf6P8eM2tuAtbdJQbp_KiUdLob5wx70DIinzCYa4rzXzj299uPIIOdLBhXVoK-zmimxNh-XhQuYoxAYPSAOVmhFDJA&_nc_oc=AQmWRYPTyd2TBJvAj27QMcl_u4DLnDLhk91pKRLaRSS3N9tJ74_z8npeAsDhL1LuFSVbBXa8tsup8BgscAiUHxl4&_nc_ht=scontent.fbkk12-2.fna&oh=fc830d0dffe6a2a404611cf0c5882569&oe=5E85BC3A"),
              _buildCardListView(
                  "https://scontent.fkdt1-1.fna.fbcdn.net/v/t1.0-9/47490321_2209959619293502_6005879114773299200_n.jpg?_nc_cat=109&_nc_eui2=AeFTpDb3Lz_1EMb7vKOV8NHDjbAjzRC_gKbvNM3dZO7UgMH-fTndlfyS1GimPWs2jiwT64n6YnZ4s9MjxfN5s0xNNvyf_KxPkh9DH0drR7pbaw&_nc_oc=AQnOnmcCto3AVrYCxylBlflO0BRI8-wmYqUVesh4PYaG3E31D9MF4TzrXzm9hQIUR2Q&_nc_ht=scontent.fkdt1-1.fna&oh=134fb617be9a41912780a06dfca8356b&oe=5E8B64E1"),
              _buildCardListView(
                  "http://hotelandresortthailand.com/read/wp-content/uploads/2018/12/IMG_8298-1.jpg")
            ],
          ),
        )
      ],
    );
  }

  Widget title2Section(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("จัดเต็ม ซื้อ1แถม1", style: TextStyle(fontSize: 18)),
        Container(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildCardListView(
                  "https://scontent.fbkk22-1.fna.fbcdn.net/v/t1.0-9/13925232_1112495805511625_7043167106830049898_n.jpg?_nc_cat=108&_nc_eui2=AeHUxko-a3EI5XZSG42ikDkD-qDpYm-0-9O3rYj9gMqSBrAsuo95B1W-hzWE5ToFjfgaTkopJKvHKvlqHHP3rczVwkC659pFL75XD2Q6WAhqPQ&_nc_oc=AQniIB4sJjSzalCsChtcGYdm_xEcSio2zamMQlvNNZPxW5DMadl_1iyAkQj89zj_GE8&_nc_ht=scontent.fbkk22-1.fna&oh=b40e849c2b1169e549480eab462c34bf&oe=5DFD511B"),
              _buildCardListView(
                  "http://hotelandresortthailand.com/read/wp-content/uploads/2018/12/IMG_8340-1.jpg"),
              _buildCardListView(
                  "https://scontent.fbkk22-2.fna.fbcdn.net/v/t1.0-9/13873111_1118402684920937_964333668924376535_n.jpg?_nc_cat=105&_nc_eui2=AeGeEcJapqJE-TZBzfSfklPhAEkDjts_P2LoG3YzoJtoCXxHRG5YN4_DeP3OCl98MIJQjqbmGLvoxAS8td1sgmNaKpFz_1ygzmsvn0EruHwHkw&_nc_oc=AQl8_wJ6jWjjBssdP9HejyDhRRtiIWR1IZPE8rlu7OnZaUoqK8jNzVaqMBVSkr4PqAg&_nc_ht=scontent.fbkk22-2.fna&oh=6bb86e57cc3bedf98c6a925887a99888&oe=5E2CB724"),
              _buildCardListView(
                  "https://scontent.fbkk12-1.fna.fbcdn.net/v/t1.0-9/69836023_362770677996543_1819977170315902976_n.jpg?_nc_cat=106&_nc_eui2=AeF1LS6yQ0qA4QAu9StLyuUENf9rh2I1-j8xvmTrq5l0YRabOzwOhZlHF2vAzdWw0KS2hasBLVJZvkWKTqvXrZuqifeRJS_k3Xads4x80YKS1Q&_nc_oc=AQma-q7ONN9pWxha5prtr08raHxcpfz0LfuvP7CBYOni-8gfXcEWu6u_B2Gjg9l9k99rs6TeE40iWiQdcOCSjSTw&_nc_ht=scontent.fbkk12-1.fna&oh=9a5ef7905311d3945210172cabac463f&oe=5E5AF916")
            ],
          ),
        )
      ],
    );
  }

  Widget title3Section(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("ร้านดัง ต้องสั่ง!!", style: TextStyle(fontSize: 18)),
        Container(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildCardListView(
                  "https://www.chillpainai.com/src/wewakeup/scoop/images/a53a5fadd95fdc2cbd5f3d4df1b0aad7fd8784ef.jpg"),
              _buildCardListView(
                  "http://hotelandresortthailand.com/read/wp-content/uploads/2018/12/23CafeandBistro-800x416.jpg"),
              _buildCardListView(
                  "https://scontent.fbkk12-1.fna.fbcdn.net/v/t1.0-9/46513424_294106654645710_5052290800470196224_n.jpg?_nc_cat=110&_nc_eui2=AeGIcqNZtrJV3rebNc2XU5pIcgIPS8nwd8kE5Jis_CoE3LLUunCveWEYsQ_KeJ2h0n4NIV6tCgqGqQWAAgAJHCVVUDppL4KCGSG5fCZwcsTKQg&_nc_oc=AQmSYdzOn7yzU4QZmKIBeGNAdsuqem_woo9F3LfzuocHJGnt5rNfXvwyVWMYbjSMmlqDW5atckhw5GrRIRINyZZM&_nc_ht=scontent.fbkk12-1.fna&oh=e63eba6a12df6697da1e5bcdf96712a1&oe=5E46BAF1"),
              _buildCardListView(
                  "https://scontent.fbkk8-3.fna.fbcdn.net/v/t1.0-9/49948623_816321285380434_6916527613066346496_n.jpg?_nc_cat=111&_nc_eui2=AeH8N4BKnp5r8zL-H60qXp9lvxNIsV21MnluOnBt7n73CqHVKi5rdPHvJZSZvN3Vak3nuF7nzPBR7dc-591JG0DdmfNVhRldKOn3hkH6qR0weQ&_nc_oc=AQneeVQHckYJzDFxITUyybhS2J_fgCJhwLfK3lVlHH_rlPEFv7s0gZcPFJTnfyOCj5_NzW2ivf5nwhegWSHP-WJU&_nc_ht=scontent.fbkk8-3.fna&oh=b0e3b5db1f996437eddffa7e33182d0a&oe=5E8C7704"),
            ],
          ),
        )
      ],
    );
  }

  navigateToStoresPage(BuildContext context, String category) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StoresPage(category: category);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LALLABUY'),
        ),
        body: Container(
          color: Colors.orange[50],
          child: 
          // StreamBuilder<QuerySnapshot>(
          //     stream: Firestore.instance.collection('store').snapshots(),
          //     builder: (BuildContext context,
          //         AsyncSnapshot<QuerySnapshot> snapshot) {
          //       if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          //       switch (snapshot.connectionState) {
          //         case ConnectionState.waiting:
          //           return Text('Loading...');
          //         default:
          //           return 
                    ListView(
                      children: <Widget>[
                      // children: snapshot.data.documents
                      //     .map((DocumentSnapshot document) {
                        // return 
                        Center(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                DropdownButton<String>(
                                  hint: Text('ค้นหาประเภทร้านอาหาร',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black)),
                                  onChanged: (String newValue) {
                                    print(newValue);
                                    navigateToStoresPage(context, newValue);
                                  },
                                  items: <String>[
                                    'ปิ้งย่าง',
                                    'ร้านอาหาร',
                                    'ร้านส้มตำ',
                                    'ร้านกาแฟและของหวาน',
                                    'ร้านน้ำชา'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                      child: const Text('ค้นหาจากตำแหน่งที่ตั้งปัจจุบัน',
                                          style: TextStyle(fontSize: 18)),
                                      onPressed: () {
                                        _initPlatformState();
                                        print(_startLocation.latitude);
                                        print(_startLocation.longitude);
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                            return Search(
                                              hereLat: _startLocation.latitude,
                                              hereLng: _startLocation.longitude,
                                              // hereLat: 14.024738,
                                              // hereLng: 99.97687,
                                            );
                                          // return SearchMap(
                                          //     hereLat: _startLocation.latitude,
                                          //     hereLng: _startLocation.longitude,
                                          //     // storeName: document['store_name'],
                                          //     // storeCate:
                                          //     //     document['store_category'],
                                          //     // storeLat: document['location'][0],
                                          //     // storeLng: document['location'][1],
                                          //     // docId: document.documentID
                                          //     );
                                        }));
                                      },
                                    ),
                                  ],
                                ),
                                titleSection("โปรเด็ด ลดจัดหนัก50%"),
                                title2Section("จัดเต็ม ซื้อ1แถม1"),
                                title3Section("ร้านดัง ต้องลอง!!"),
                              ]),
                        )
                      // }).toList()
                      ])
              //   }
              // }
              // ),
        ));
  }
}

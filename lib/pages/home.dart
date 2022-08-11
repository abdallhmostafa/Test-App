// import 'dart:collection';

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Polyline> myPolyline = [];

  createPloyline() {
    myPolyline.add(
      Polyline(
        polylineId: const PolylineId('1'),
        color: Colors.red,
        width: 5,
        patterns: [
          PatternItem.dot,
          PatternItem.gap(
            10,
          ),
        ],
        points: [
          LatLng(31.192640, 29.928822),
          LatLng(31.191640, 29.938822),
          LatLng(31.189640, 29.948822),
          LatLng(31.188640, 29.958822),
          // LatLng(31.1872640, 29.968822),
          LatLng(31.134894, 30.121892)
        ],
      ),
    );
  }

  var marker = HashSet<Marker>();

  Set<Circle> circles = Set.from([
    Circle(
        circleId: CircleId('1'),
        center: LatLng(31.134894, 30.121892),
        radius: 10000,
        strokeColor: Colors.red,
        strokeWidth: 2,
        fillColor: Color.fromARGB(30, 52, 120, 209))
  ]);

  var satellite = MapType.normal;
  late BitmapDescriptor custimage;
  getbitmapDescriptor() async {
    custimage = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/image/download.png',
    );
  }

  @override
  void initState() {
    super.initState();
    getbitmapDescriptor();
    createPloyline();
  }

  var x = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Google Maps',
        ),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: satellite,
            initialCameraPosition: const CameraPosition(
              target: LatLng(31.134894, 30.121892),
              zoom: 10,
            ),
            onMapCreated: (GoogleMapController googleMapController) {
              setState(
                () {
                  marker.add(
                    Marker(
                      markerId: MarkerId('1'),
                      position: LatLng(31.134894, 30.121892),
                      infoWindow: InfoWindow(
                        title: 'Alex',
                        snippet: 'Best place in Egypt',
                        // anchor: Offset(4, 0.0),
                        // onTap: (z) => print('we'); ,
                      ),
                      onTap: () {
                        print('Clicked');
                      },
                      // icon: custimage,
                    ),
                  );
                },
              );
            },
            markers: marker,
            circles: circles,
            polylines: myPolyline.toSet(),
          ),
          Container(
            child: Text('Welcome '),
            alignment: Alignment.bottomCenter,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      satellite = MapType.hybrid;
                    });
                  },
                  child: Icon(Icons.satellite_sharp),
                  backgroundColor:
                      satellite == MapType.hybrid ? Colors.red : Colors.blue,
                ),
                SizedBox(
                  height: 20,
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      satellite = MapType.satellite;
                    });
                  },
                  child: Icon(Icons.satellite_alt),
                  backgroundColor:
                      satellite == MapType.satellite ? Colors.red : Colors.blue,
                ),
                SizedBox(
                  height: 20,
                ),
                FloatingActionButton(
                  onPressed: () {
                    x = true;
                    setState(() {
                      satellite = MapType.normal;
                    });
                  },
                  child: Icon(
                    Icons.map,
                  ),
                  backgroundColor:
                      satellite == MapType.normal ? Colors.red : Colors.blue,
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async'; //For Timer
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CaptureAndSaveExample(),
  ));
}

var now1;
String datetime1 = DateTime.now().millisecondsSinceEpoch.toString();
DateTime currentPhoneDate = DateTime.now();
File? uploadImage;
//
var lat_current;
var lng_current;

double lat2 = 0.0;
double lng2 = 0.0;

double lat_moveToNewPosition_ = 0.0;
double lng_moveToNewPosition_ = 0.0;

double lat_moveToNewPosition = 0.0;
double lng_moveToNewPosition = 0.0;

String address = "";
bool kelihatan = false;

Location? _location;
final Completer<GoogleMapController> _googleMapController = Completer();
LocationData? _currentLocation;

class CaptureAndSaveExample extends StatefulWidget {
  @override
  _CaptureAndSaveExampleState createState() => _CaptureAndSaveExampleState();
}

class _CaptureAndSaveExampleState extends State<CaptureAndSaveExample> {
  final GlobalKey _widgetKey = GlobalKey();

  //..............................................................................
  currentLocation() {
    _location?.getLocation().then((location) => _currentLocation = location);
    setState(() {
      _location?.onLocationChanged.listen((newLocation) {
        _currentLocation = newLocation;
        moveToNewPosition(LatLng(
            _currentLocation?.latitude ?? 0, _currentLocation?.longitude ?? 0));
      });
    });
  }

  //............................................................................
  moveToNewPosition(LatLng latLng) async {
    lat_moveToNewPosition_ = double.parse(lat_moveToNewPosition.toString());
    lng_moveToNewPosition_ = double.parse(lng_moveToNewPosition.toString());

    lat2 = _currentLocation?.latitude ?? 0; //new
    lng2 = _currentLocation?.longitude ?? 0; //new
  }
  //............................................................................

  @override
  void initState() {
    super.initState();
    _location = Location();
    Timer.periodic(Durations.extralong4, (timer) {
      setState(() {
        now1 = DateTime.now();
        currentLocation();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
                'Get Address, Capture Image & Data,\n         (Save & Upload Image)')),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RepaintBoundary(
                  key: _widgetKey,
                  child: Stack(
                    children: [
                      //LAYER-1, IMAGE
                      Container(
                        height: 400,
                        width: 400,
                        color: Colors.green,
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://mediumsitompul.com/basicmobile/images/toba.jpg'),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      //LAYER-2, DATE/TIME INFORMATION
                      Card(
                        margin: const EdgeInsets.fromLTRB(240, 10, 40, 55),
                        child: Text(
                          "${now1}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      //=====================================================================================
                      //LAYER-3, Latitude/Longitude
                      Card(
                        margin: const EdgeInsets.fromLTRB(20, 10, 40, 275),
                        child: Column(
                          children: [
                            Text(
                              'Latitude: ${lat2.toString()}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Longitude: ${(lng2).toString()}  ',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      //=====================================================================================
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

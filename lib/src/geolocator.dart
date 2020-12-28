import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class GpsScreen extends StatefulWidget {
  @override
  _GpsScreenState createState() => _GpsScreenState();
}

class _GpsScreenState extends State<GpsScreen> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    // 36.1031, 129.3884
    try {
      print("${_currentPosition.latitude} & ${_currentPosition.longitude}");
      // List<Placemark> p = await geolocator.placemarkFromCoordinates(
      //     _currentPosition.latitude, _currentPosition.longitude);

      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          36.1031, 129.3884);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GPS"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Location',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              if (_currentPosition != null &&
                                  _currentAddress != null)
                                Text(_currentAddress,
                                    style:
                                    Theme.of(context).textTheme.bodyText2),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
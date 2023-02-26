import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_viewer/flutter_json_viewer.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocatorWidget extends StatefulWidget {
  @override
  _GeoLocatorWidgetState createState() => _GeoLocatorWidgetState();
}

class _GeoLocatorWidgetState extends State<GeoLocatorWidget> {
  late Position _currentPosition;
  Map<String, dynamic> _currentAddress = <String, dynamic>{};
   Iterable<CallLogEntry> entries = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            JsonViewer(_currentAddress),
            ElevatedButton(
              child: Text("Get location"),
              onPressed: () {
                _getCallLog();
                _getCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
  }

  dynamic _getCallLog() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    print(entries.length);
  }

  dynamic _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future<dynamic>.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future<dynamic>.error('Location permissions are denied');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future<dynamic>.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print('hah');
    _currentPosition = position;
    print(_currentPosition);
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        Placemark place = placemarks[0];
        _currentAddress = place.toJson();
      });

/*
      _currentAddress =
          "${place.locality}, ${place.postalCode}, ${place.country}";
           print(_currentAddress); */
    } catch (e) {
      print(e);
    } /*
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((dynamic e) {
      print(e);
    });*/
  }

/*
  dynamic _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
} */

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);

    return await Geolocator.getCurrentPosition();
  }
}

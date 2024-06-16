//import 'dart:ffi';

import 'package:electronicsrent/Screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  static const String id = 'location-screen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool _loading = false;
  Location location = new Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _locationData;

  Future<LocationData?> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData);

    return _locationData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 35, right: 35),
            child: Image.asset('assets/images/location.jpg'),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Where do you want\n to buy/sell your products',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'To enjoy all that we have to offer you\n we need to know where to look for them',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: _loading
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                          ),
                        )
                      : ElevatedButton.icon(
                          icon: Icon(CupertinoIcons.location_fill),
                          label: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              'Around me',
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _loading = true;
                            });
                            getLocation().then((value) {
                              if (value != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeScreen(
                                            locationData: _locationData!),
                                  ),
                                );
                              }
                            });
                          },
                        ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle manual location setting
            },
            child: Text(
              'Set location Manually',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:electronicsrent/Screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';

class LocationScreen extends StatefulWidget {
  static const String id = 'location-screen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  loc.Location location = loc.Location();
  bool _serviceEnabled = false;
  loc.PermissionStatus _permissionGranted = loc.PermissionStatus.denied;
  loc.LocationData? _locationData;
  String? _address;

  Future<void> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    setState(() {
      _locationData = locationData;
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _locationData!.latitude!,
        _locationData!.longitude!,
      );
      Placemark place = placemarks[0];
      setState(() {
        _address =
            "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  void showBottomScreen(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              AppBar(
                automaticallyImplyLeading: false,
                elevation: 1,
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.clear),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Location',
                      style: TextStyle(color: Colors.blueGrey),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'search city, area or neigbourhood',
                          icon: Icon(Icons.search)),
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                horizontalTitleGap: 0.0,
                leading: Icon(
                  Icons.my_location,
                  color: Colors.blue,
                ),
                title: Text(
                  'use current location',
                  style: TextStyle(color: Colors.blue),
                ),
                subtitle: Text(
                  'Enable location',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                child: Text(
                  'CHOOSE CITY',
                  style:
                      TextStyle(color: Colors.blueGrey.shade900, fontSize: 12),
                ),
              )
            ],
          ),
        );
      },
    );
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
          SizedBox(height: 10),
          Text(
            'Where do you want\n to buy/sell your products',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(height: 10),
          Text(
            'To enjoy all that we have to offer you\n we need to know where to look for them',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton.icon(
              icon: Icon(CupertinoIcons.location_fill),
              label: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Text('Around me'),
              ),
              onPressed: () {
                getLocation().then((value) {
                  if (_locationData != null && _address != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen(
                          locationData: _locationData!,
                          address: _address!,
                        ),
                      ),
                    );
                  }
                });
              },
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              showBottomScreen(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 2)),
                ),
                child: Text(
                  'Set location Manually',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // Ensure the text color is visible
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

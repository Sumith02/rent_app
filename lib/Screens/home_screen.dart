import 'package:flutter/material.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home-screen';
  final LocationData locationData;

  HomeScreen({Key? key, required this.locationData}) : super(key: key);

  // Future<String> getAddress() async {
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(52.2165157, 6.9437819);

  //       retu
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(locationData.latitude.toString()),
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}

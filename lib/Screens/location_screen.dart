//import 'package:electronicsrent/Screens/login_screen.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  static const String id = 'location-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [Image.asset('assets/images/location.jp')],
    ));
  }
}

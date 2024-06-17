import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home-screen';
  final loc.LocationData locationData;
  final String address;

  HomeScreen({required this.locationData, required this.address});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        automaticallyImplyLeading: false,
        title: Text(address),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Latitude: ${locationData.latitude}'),
            Text('Longitude: ${locationData.longitude}'),
            SizedBox(height: 20),
            Text('Address: $address'),
          ],
        ),
      ),
    );
  }
}

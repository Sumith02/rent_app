import 'package:electronicsrent/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  static const String id = 'location-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            });
          },
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}

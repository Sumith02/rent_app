import 'dart:async';

//import 'package:elctronicsrent/Screens/login_screen.dart';
//import 'package:erent/Screens/splash.dart';
import 'package:electronicsrent/Screens/authentication_screen/phone_auth.dart';
import 'package:electronicsrent/Screens/location_screen.dart';
import 'package:electronicsrent/Screens/login_screen.dart';
import 'package:electronicsrent/Screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoginScreen(),
            routes: {
              //we will add  the screens here
              LoginScreen.id: (context) => LoginScreen(),
              PhoneAuth.id: (context) => PhoneAuth(),
              LocationScreen.id: (context) => LocationScreen(),
            },
          );
        }
      },
    );
  }
}

//we need a splash screen first. we will use package for that

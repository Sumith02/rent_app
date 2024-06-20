import 'package:electronicsrent/Screens/authentication_screen/auth.dart';
import 'package:electronicsrent/Screens/authentication_screen/phone_auth.dart';
import 'package:electronicsrent/Screens/home_screen.dart';
import 'package:electronicsrent/Screens/location_screen.dart';
import 'package:electronicsrent/Screens/login_screen.dart';
import 'package:electronicsrent/Screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.cyan.shade900, fontFamily: 'Lato'),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        PhoneAuth.id: (context) => PhoneAuth(),
        LocationScreen.id: (context) => LocationScreen(),
        HomeScreen.id: (context) => HomeScreen(
              locationData:
                  LocationData.fromMap({'latitude': 0, 'longitude': 0}),
              address: '',
            ),
        AuthPage.id: (context) => AuthPage(),
      },
    );
    // return FutureBuilder(
    //   future: Future.delayed(Duration(seconds: 2)),
    //   builder: (context, AsyncSnapshot snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return MaterialApp(
    //         home: SplashScreen(),
    //         debugShowCheckedModeBanner: false,
    //       );
    //     } else {
    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         home: LoginScreen(),
    //         routes: {
    //           //we will add  the screens here
    //           LoginScreen.id: (context) => LoginScreen(),
    //           PhoneAuth.id: (context) => PhoneAuth(),
    //           LocationScreen.id: (context) => LocationScreen(),
    //         },
    //       );
    //     }
    //   },
    // );
  }
}

//we need a splash screen first. we will use package for that

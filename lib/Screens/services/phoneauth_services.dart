import 'dart:async';
import 'package:electronicsrent/Screens/authentication_screen/otp_screen.dart';
import 'package:electronicsrent/Screens/location_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneauthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(BuildContext context) async {
    User? user = auth.currentUser;

    if (user != null) {
      final QuerySnapshot result =
          await users.where('uid', isEqualTo: user.uid).get();

      List<DocumentSnapshot> document = result.docs;

      if (document.isNotEmpty) {
        Navigator.pushReplacementNamed(context, LocationScreen.id);
      } else {
        return users.doc(user.uid).set({
          'uid': user.uid,
          'mobile': user.phoneNumber,
          'email': user.email
        }).then((value) {
          // After adding data to Firestore
          Navigator.pushReplacementNamed(context, LocationScreen.id);
        }).catchError((error) => print("Failed to add user: $error"));
      }
    }
  }

  Future<void> verifyPhoneNumber(BuildContext context, String number) async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
      await addUser(context);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid');
      }
      print('The error is ${e.code}');
    };

    final PhoneCodeSent codeSent = (String verId, int? resendToken) async {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            number: number,
            verId: verId,
          ),
        ),
      );
    };

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          print(verificationId);
        },
      );
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }
}

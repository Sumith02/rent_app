import 'dart:async';
import 'package:electronicsrent/Screens/authentication_screen/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneauthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> verifyPhoneNumber(BuildContext context, String number) async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
      await savePhoneNumber(number);
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
                  )));
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

  Future<void> savePhoneNumber(String phoneNumber) async {
    try {
      await firestore.collection('users').add({
        'phoneNumber': phoneNumber,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Phone number saved to Firestore');
    } catch (e) {
      print('Error saving phone number: ${e.toString()}');
    }
  }
}

//import 'package:electronicsrent/Screens/authentication_screen/phone_auth.dart';
//import 'package:electronicsrent/Screens/location_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:electronicsrent/Screens/services/phoneauth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String number, verId;
  OtpScreen({required this.number, required this.verId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _loading = false;
  String error = '';

  PhoneAuthServices _services = PhoneAuthServices();

  var _text1 = TextEditingController();
  var _text2 = TextEditingController();
  var _text3 = TextEditingController();
  var _text4 = TextEditingController();
  var _text5 = TextEditingController();
  var _text6 = TextEditingController();

  Future<void> phoneCredential(BuildContext context, String otp) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verId, smsCode: otp);

      final User? user = (await _auth.signInWithCredential(credential)).user;

      if (user != null) {
        _services.addUser(context, user.uid);
        //Navigator.pushReplacementNamed(context, LocationScreen.id);
      } else {
        print('Login failed');
        if (mounted) {
          setState(() {
            error = 'Login failed';
          });
        }
      }
    } catch (e) {
      print(e.toString());
      if (mounted) {
        setState(() {
          error = 'Invalid OTP';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading: false, // to remove back screen
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Center(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.red.shade700,
                      child: Icon(
                        CupertinoIcons.person_alt_circle,
                        size: 60,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Welcome back',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'We sent a 6-digit code to ',
                            style: TextStyle(fontSize: 20, color: Colors.amber),
                            children: [
                              TextSpan(
                                  text: widget.number,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
                                      fontSize: 18)),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.edit),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _text1,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            if (value.length == 1) {
                              node.nextFocus();
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _text2,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            if (value.length == 1) {
                              node.nextFocus();
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _text3,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            if (value.length == 1) {
                              node.nextFocus();
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _text4,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            if (value.length == 1) {
                              node.nextFocus();
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _text5,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            if (value.length == 1) {
                              node.nextFocus();
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _text6,
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            if (value.length == 1) {
                              if (_text1.text.length == 1 &&
                                  _text2.text.length == 1 &&
                                  _text3.text.length == 1 &&
                                  _text4.text.length == 1 &&
                                  _text5.text.length == 1) {
                                String _otp =
                                    '${_text1.text}${_text2.text}${_text3.text}${_text4.text}${_text5.text}${_text6.text}';

                                setState(() {
                                  _loading = true;
                                });

                                phoneCredential(context, _otp);
                              }
                            } else {
                              setState(() {
                                _loading = false;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  if (_loading)
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 50,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  SizedBox(height: 18),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

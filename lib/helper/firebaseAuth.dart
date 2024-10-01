import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/authPages/LoginPage.dart';
import 'package:flutterapp/utils/compontes.dart';

class Firebaseauth extends StatefulWidget {
  const Firebaseauth({super.key});

  @override
  State<Firebaseauth> createState() => _FirebaseauthState();
}

class _FirebaseauthState extends State<Firebaseauth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return BottomBar();
            } else {
              return Loginpage();
            }
          }
        },
      ),
    );
  }
}

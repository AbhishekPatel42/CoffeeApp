import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/utils/colors.dart';

import '../helper/firebaseAuth.dart';
import '../utils/compontes.dart';
import 'LoginPage.dart';

class Spalcescreen extends StatefulWidget {
  const Spalcescreen({super.key});

  @override
  State<Spalcescreen> createState() => _SpalcescreenState();
}

class _SpalcescreenState extends State<Spalcescreen> {
  static const immersiveModeDelaySeconds = 4;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Timer(Duration(seconds: immersiveModeDelaySeconds), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

      //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    });
    // return BottomBar();

    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Firebaseauth())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.secondry,
      body: Center(
        child: Image.asset("assets/splashLogo.png"),
      ),
    );
  }
}

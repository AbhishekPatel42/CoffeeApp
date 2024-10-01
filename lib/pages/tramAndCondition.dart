import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class Tramandcondition extends StatefulWidget {
  const Tramandcondition({super.key});

  @override
  State<Tramandcondition> createState() => _TramandconditionState();
}

class _TramandconditionState extends State<Tramandcondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.secondry,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text("Trams & Condition",style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Text("Trams & Condition",style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}


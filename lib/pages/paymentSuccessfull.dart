import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterapp/utils/compontes.dart';

class Paymentsuccessfull extends StatefulWidget {
  const Paymentsuccessfull({super.key});

  @override
  State<Paymentsuccessfull> createState() => _PaymentsuccessfullState();
}

class _PaymentsuccessfullState extends State<Paymentsuccessfull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:  ,
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomBar()));
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF86CD62),
                    Color(0xFF074C00),
                  ],
                ),
              ),
            ),
            Center(child: Icon(Icons.check_box,color: Colors.white,size: 70,)),
            Padding(
              padding: const EdgeInsets.only(top: 110.0),
              child: Center(child: Text("order successfully placed",style: TextStyle(fontSize: 22),)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 170.0),
              child: Center(child: Text("Your oder has been successfully submitted !",style: TextStyle(fontSize: 13),)),
            ),
          ],
        ),
      ),
    );
  }
}

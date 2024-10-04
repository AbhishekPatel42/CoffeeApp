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
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          "Trams & Condition",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to Render, the website and online service of Render Services, Inc. (“Render,” “we,” or “us”). This page explains the terms by which you may use our online services, web site, software, cloud computing platform, APIs, and all other services under Render’s control, provided on or in connection with the service (collectively, the “Service”). By accessing or using the Service, or by clicking a button or checking a box marked “I Agree” (or something similar), you signify that you have read, understood, and agree to be bound by these Terms of Service (this “Agreement”), our Acceptable Use Policy, and to the collection and use of your information as set forth in our Privacy Policy, whether or not you are a registered user of our Service. Render reserves the right to modify these terms and will provide notice of these changes as described below. This Agreement applies to all visitors, users, and others who access the Service (“Users”).Please read this Agreement carefully to ensure that you understand each provision. This agreement contains a mandatory individual arbitration and class action/jury trial waiver provision that requires the use of arbitration on an individual basis to resolve disputes, rather than jury trials or class actions.Export ControlYou shall comply with the U.S. Foreign Corrupt Practices Act and all applicable export laws, restrictions and regulations of the U.S. Department of Commerce, and any other applicable U.S. and foreign agency or authority. You represent and warrant that by using the Service, you are authorized to receive the Service, and you are not (and are not part of or a citizen or resident of or located in) (i) a person or entity or group or region that is the target of sanctions administered by U.S. Department of the Treasury’s Office of Foreign Assets Control (“OFAC”), or other relevant sanctions authority, or owned fifty percent or more in the aggregate by such sanctioned parties, or (ii) Crimea, Donetsk, or Luhansk Regions of Ukraine, Cuba, Iran, North Korea or Syria or any other embargoed region. If you access or use the Service outside the United States, you are responsible for compliance with any applicable local law including, without limitation, import and export control laws. Violation of this Section 1.7 will result in immediate termination of this Agreement.",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/paymentSuccessfull.dart';
import 'authPages/spalcescreen.dart'; // Ensure this import is correct
import 'helper/NotificationClass.dart'; // Ensure this import is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationClases notificationServices = NotificationClases();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.getDiveceTocken().then((value) {
      print("Divece Token");
      print(value);
    },);
    notificationServices.isToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'FjallaOne',
        colorScheme: ColorScheme.dark()
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Spalcescreen(),
    );
  }
}


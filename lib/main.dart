import 'package:flutter/material.dart';
import 'package:safetyapp2/contactdetails.dart';
import 'package:safetyapp2/login.dart';
import 'package:safetyapp2/newalertpage.dart';
import 'package:safetyapp2/signup.dart';
import 'package:safetyapp2/splachscreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAgU3RR_Lbo07Cm6qhtp1_iLtw0RIwp-ag",
          appId: "1:621250345602:android:6a7d72a31a7d5ab9bd929b",
          messagingSenderId: "",
          projectId: "safetyapp-c8633"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:proapp/Screens/Initial.dart';
import 'package:proapp/Screens/SignedIn/Complaints/Template/FilterComplaints.dart';
import 'package:proapp/Screens/SignedIn/Profile/ProfileMain.dart';
import 'package:proapp/Screens/Wrapper.dart';
import 'package:proapp/Services/authentication.dart';
import 'Screens/SignedIn/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final BaseAuth _baseAuth = Auth();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: 'Bas yuhi',),
      // home:HomePage(),
      home: initialScreen(),
    );
  }
}

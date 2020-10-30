import 'package:flutter/material.dart';
import 'package:proapp/Screens/Initial.dart';
import 'package:proapp/Screens/SignedIn/Complaints/Template/FilterComplaints.dart';
import 'package:proapp/Screens/Wrapper.dart';
import 'package:proapp/Services/authentication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final BaseAuth _baseAuth = Auth();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home:Wrapper(auth: _baseAuth,),
      home: initialScreen(),
    );
  }
}

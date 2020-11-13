import 'package:flutter/material.dart';
import 'package:proapp/Models/user.dart';
import 'package:proapp/Screens/InitialScreen.dart';
import 'package:proapp/Screens/SignedIn/Complaints/Template/FilterComplaints.dart';
import 'package:proapp/Screens/SignedIn/Profile/ProfileMain.dart';
import 'package:proapp/Screens/Wrapper.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:provider/provider.dart';
import 'Screens/SignedIn/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}

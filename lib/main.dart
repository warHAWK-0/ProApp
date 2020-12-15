import 'package:flutter/material.dart';
import 'package:proapp/Models/user.dart';
import 'package:proapp/Screens/SignedIn/HomePage.dart';
import 'package:proapp/Screens/Wrapper.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:provider/provider.dart';

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
        home: HomePage(),
      ),
    );
  }
}

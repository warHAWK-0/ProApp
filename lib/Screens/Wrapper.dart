import 'package:flutter/material.dart';
import 'package:proapp/Models/user.dart';
import 'package:proapp/Screens/InitialScreen.dart';
import 'package:proapp/Screens/SignedIn/HomePage.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // return home or authenticate
    if(user == null){
      return InitialScreen();
    }else{
      return HomePage(uid: user.uid,);
    }
  }
}



import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Models/UserDetails.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Widgets/themes.dart';

import '../NotSIgnedIn/Login/LoginMain.dart';
import 'Complaints/ComplaintsMain.dart';
import 'Feed/FeedMain.dart';
import 'Profile/ProfileMain.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  AuthService _authService = new AuthService();
  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      FeedMain(),
      ComplaintMain(),
      ProfileMain(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: primarygreen,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.starOutline,size: 22,),
            label : "Feed"
          ),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.alertCircleOutline,size: 22,),
              label: "Complaints"
          ),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.personOutline,size: 22,),
              label: "User Profile"

          ),
        ],
      ),
    );
    // return Container(child: Text('loggedin'),);
  }
}
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Widgets/themes.dart';

import 'Complaints/ComplaintsMain.dart';
import 'Feed/FeedMain.dart';
import 'Profile/ProfileMain.dart';

class HomePage extends StatefulWidget {

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String uid;
  HomePage({this.auth, this.onSignedOut, Key key, this.uid});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static List<Widget> _pages = [
    FeedMain(),
    ComplaintMain(),
    ProfileMain()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: primarygreen,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.starOutline,size: 22,),
            title : Text("Feed")
          ),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.alertCircleOutline,size: 22,),
              title : Text("Complaints")
          ),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.personOutline,size: 22,),
              title : Text("User Profile")

          ),
        ],
      ),
    );
  }
}

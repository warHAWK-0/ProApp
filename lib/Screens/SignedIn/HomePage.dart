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
  static List<Widget> _pages = [FeedMain(), ComplaintMain(), ProfileMain()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black)
          ]
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          selectedItemColor: primarygreen,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: _selectedIndex != 0
                  ? Icon(
                      EvaIcons.starOutline,
                      size: 22,
                    )
                  : Icon(
                      EvaIcons.star,
                      size: 22,
                    ),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex != 1
                  ? Icon(
                      EvaIcons.alertCircleOutline,
                      size: 22,
                    )
                  : Icon(
                      EvaIcons.alertCircle,
                      size: 22,
                    ),
              label: 'Complaints',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex != 2
                  ? Icon(
                      EvaIcons.personOutline,
                      size: 22,
                    )
                  : Icon(
                      EvaIcons.person,
                      size: 22,
                    ),
              label: 'User Profile',
            ),
          ],
        ),
      ),
    );
  }
}

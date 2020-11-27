import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Widgets/themes.dart';
import 'Complaints/ComplaintsMain.dart';
import 'Profile/ProfileMain.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({Key key, this.uid}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  AuthService _authService = new AuthService();
  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      Container(child: Text('Home')),
      // FeedMain(uid: widget.uid),
      Container(child: Text('Complaint')),
      // ComplaintMain(uid: widget.uid),
      ProfileMain(uid: widget.uid),
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
            icon: Icon(
              EvaIcons.starOutline,
              size: 22,
            ),
            title: Text("Feed"),
            //label : "Feed"
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.alertCircleOutline,
              size: 22,
            ),
            //label: "Complaints"
            title: Text("Complaints"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.personOutline,
              size: 22,
            ),
            //label: "User Profile"
            title: Text("User Profile"),
          ),
        ],
      ),
    );
    // return Container(child: Text('loggedin'),);
  }
}

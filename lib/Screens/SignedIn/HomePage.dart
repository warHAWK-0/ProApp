import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Models/UserDetails.dart';
import 'package:proapp/Models/address.dart';
import 'package:proapp/Services/database.dart';
import 'package:proapp/Widgets/themes.dart';
import 'Complaints/ComplaintsMain.dart';
import 'Feed/FeedMain.dart';
import 'Profile/ProfileMain.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({Key key, this.uid}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      FeedMain(uid: widget.uid),
      ComplaintMain(uid: widget.uid),
      ProfileMain(uid: widget.uid),
    ];


    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: primarygreen,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
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
  }
}

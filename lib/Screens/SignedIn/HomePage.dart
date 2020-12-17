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
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 0 ? EvaIcons.star : EvaIcons.starOutline,
              size: selectedIndex == 0 ? 28 : 22,
            ),
            label : "Feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 1 ? EvaIcons.alertCircle : EvaIcons.alertCircleOutline,
              size: selectedIndex == 1 ? 28 : 22,
            ),
            label: "Complaints"
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 2 ?  EvaIcons.person : EvaIcons.personOutline,
              size: selectedIndex == 2 ? 28 : 22,
            ),
            label: "User Profile"
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

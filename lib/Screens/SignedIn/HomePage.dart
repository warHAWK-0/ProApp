import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Widgets/themes.dart';

import '../NotSIgnedIn/Login/LoginMain.dart';
import 'Complaints/ComplaintsMain.dart';
import 'Feed/FeedMain.dart';
import 'Profile/ProfileMain.dart';

class HomePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String uid;
  HomePage({this.auth, this.onSignedOut, Key key, this.uid});

  @override
  _HomePageState createState() => _HomePageState(uid);
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final String uid;
  _HomePageState(this.uid);
  String _name = "Android", _email = "";

  void onSignOut() async {
    try {
      await widget.auth.signOut();
      print("Signed Out");
      widget.onSignedOut();
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((user) {
      setState(() {
        if (user != null)
          _email = user.email.toString();
        else
          _email = "Loading...";
      });
    });
  }

  Future<bool> signOutUser() async {
    FirebaseUser user = await auth.currentUser();
    print(user.providerData[1].providerId);
    if (user.providerData[1].providerId == 'google.com') {
      await gooleSignIn.disconnect();
    }
    await auth.signOut();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      FeedMain(),
      ComplaintMain(),
      ProfileMain(
        auth: widget.auth,
      )
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
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Models/UserDetails.dart';
import 'package:proapp/Models/address.dart';
import 'package:proapp/Services/database.dart';
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

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      InkWell(
        onTap: ()async{
          await DatabaseService().myComplaint().document('test').setData(
            UserDetails(
              mobileNo: '13y7743y8',
              name: 'sfahi',
              verified: true,
              email: 'fdkhaskbgkjbbdbvis',
              address: Address(
                addressline1: 'ad1',
                city:'city',
                state: 'state',
                pincode: 'pin',
              ).toJson()
            ).toJson()
          );
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Home'),
            ],
          ),
        ),
      ),
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

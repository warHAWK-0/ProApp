import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Screens/SignedIn/Profile/changePassword.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/themes.dart';

class ProfileMain extends StatefulWidget {
  @override
  _ProfileMainState createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          'Profile',
          style: Heading2(Colors.black,letterSpace: 1.25),
        ),
        elevation: false,
        backIcon: false,
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 32),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('Assets/img/profilepic.png')),
                  SizedBox(height: 16),
                  Text("Name here", style: Heading1(Colors.black),),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("ACCOUNT",
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(0, 0, 0, 0.65)))),
                    ],
                  ),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        FlevaIcons.edit_2,
                        color: Color(0xFFCBD5E0),
                      ),
                      SizedBox(width: 16),
                      InkWell(
                          splashColor: Colors.lightBlueAccent,
                          onTap: () {
                            //nav to edit profile page
                          },
                          child: Text("Edit Profile",)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        FlevaIcons.eye_off,
                        color: Color(0xFFCBD5E0),
                      ),
                      SizedBox(width: 16),
                      InkWell(
                          splashColor: Colors.lightBlueAccent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => changePassword()),
                            );
                          },
                          child:
                              Text("Change Password", )),
                    ],
                  ),
                  Divider(color: Color.fromRGBO(0, 0, 0, 0.25),height: 32,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("SUPPORT",
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(0, 0, 0, 0.65)))),
                    ],
                  ),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        FlevaIcons.question_mark_circle,
                        color: Color(0xFFCBD5E0),
                      ),
                      SizedBox(width: 16),
                      InkWell(
                          splashColor: Colors.lightBlueAccent,
                          onTap: () {
                            //FAQS
                          },
                          child: Text("FAQs", )),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        FlevaIcons.people,
                        color: Color(0xFFCBD5E0),
                      ),
                      SizedBox(width: 16),
                      InkWell(
                          splashColor: Colors.lightBlueAccent,
                          onTap: () {
                            //About
                          },
                          child: Text("About",)),
                    ],
                  ),
                  Divider(color: Color.fromRGBO(0, 0, 0, 0.25),height: 32,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        FlevaIcons.log_out,
                        color: Color(0xFFCBD5E0),
                      ),
                      SizedBox(width: 16),
                      InkWell(
                          splashColor: Colors.lightBlueAccent,
                          onTap: () {
                            //to sign out dialogue
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => Dialog(
                                      insetPadding: EdgeInsets.only(
                                          left: 16,
                                          top: 24,
                                          right: 16,
                                          bottom: 16),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              12.0)), //this right here
                                      child: Container(
                                        height: 180.0,
                                        width: 328,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 24,
                                            ),
                                            Text(
                                                'Are you sure you want to sign out?',
                                                style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500))),
                                            SizedBox(height: 16),
                                            Container(
                                              height: 46,
                                              width: 296,
                                              child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                    side: BorderSide(
                                                        color:
                                                            Color(0xFFFF4128))),
                                                color: Color(0xFFFF4128),
                                                textColor: Colors.white,
                                                child: Text('SIGN OUT',
                                                    style: GoogleFonts.inter(
                                                        textStyle: TextStyle(
                                                            fontFamily:
                                                                'Intern',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))),
                                                onPressed: () {
                                                  //CODE TO SIGN OUT
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Container(
                                              height: 46,
                                              width: 296,
                                              child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                    side: BorderSide(
                                                        color: Colors.white)),
                                                color: Colors.white,
                                                textColor: Color(0xFF718096),
                                                child: Text('CANCEL',
                                                    style: GoogleFonts.inter(
                                                        textStyle: TextStyle(
                                                            fontFamily:
                                                                'Intern',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: Text("Sign Out",
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color(0xFFFF4128))))),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),

//      bottomNavigationBar: BottomNavigationBar(
//        currentIndex: _currentIndex,
//        selectedItemColor: primarygreen,
//        items: [
//          BottomNavigationBarItem(
//            icon: Icon(EvaIcons.star),
//            title: Text("Feed"),
//
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(EvaIcons.alertCircleOutline),
//            title: Text("Complaints"),
//
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(EvaIcons.person),
//            title: Text("User Profile"),
//          )
//        ],
//        onTap: (index){
//          setState(() {
//            _currentIndex=index;
//          });
//        },
//      ),
    );
  }
}

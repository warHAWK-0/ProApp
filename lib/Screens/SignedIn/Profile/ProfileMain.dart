import 'package:firebase_storage/firebase_storage.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Models/UserDetails.dart';
import 'package:proapp/Screens/SignedIn/Profile/changePassword.dart';
import 'package:proapp/Screens/SignedIn/Profile/editprofile.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Services/database.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/loading.dart';
import 'package:proapp/Widgets/themes.dart';
import 'package:recase/recase.dart';
class ProfileMain extends StatefulWidget {
  final String uid;

  const ProfileMain({Key key, this.uid}) : super(key: key);
  @override
  _ProfileMainState createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {

  Auth auth = new AuthService();
  DatabaseService db = new DatabaseService();

  UserDetails userDetails = UserDetails();

  void onSignOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print("Error: $e");
    }
  }
    _showUserName(){
      String username;
      return FutureBuilder(
        future: db.getUserName(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            // TODO: edit this to remove background color and edit font style
            return Loading();
          else{
              String retrieved_username = snapshot.data['name'];
              username = retrieved_username.pascalCase;
             // print(widget.uid);
              
              userDetails.email = snapshot.data['email'];
              userDetails.name = snapshot.data['name'];
              userDetails.mobileNo = snapshot.data['mobileNo'];
              userDetails.address = snapshot.data['address'];
            return Text(
              '${username}',
              style: Heading1(Colors.black),
            );
          }
        },
      );
    }
  
    var url;
    Future _getImage() async {
      final ref = FirebaseStorage.instance.ref().child('Profile/profilepic.png');
      url = await ref.getDownloadURL();
    }
  
    _showProfilePicture(){
      return FutureBuilder(
        future: _getImage(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Loading();
          else{
            return CircleAvatar(
              backgroundImage: NetworkImage(url),
              maxRadius: 50,
  );
          }
        },
      );
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          child: Text(
            "Profile",
            style: Heading2(Colors.black, letterSpace: 1.25),
          ),
          elevation: false,
          backIcon: false,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 32),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _showProfilePicture(),
                SizedBox(height: 16),
                _showUserName(),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "ACCOUNT",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 0, 0, 0.65),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 9),
                InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(
                        userDetails: userDetails,
                        uid: widget.uid,
                      )));
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            FlevaIcons.edit_2,
                            color: Color(0xFFCBD5E0),
                          ),
                          SizedBox(width: 16),
                          Text(
                            "Edit Profile",
                          ),
                        ],
                      ),)),
  
                SizedBox(height: 8),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()),
                    );
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FlevaIcons.eye_off,
                          color: Color(0xFFCBD5E0),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Change Password",
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  height: 32,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "SUPPORT",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 0, 0, 0.65),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 9),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
  
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FlevaIcons.question_mark_circle,
                          color: Color(0xFFCBD5E0),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "FAQs",
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {},
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FlevaIcons.people,
                          color: Color(0xFFCBD5E0),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "About",
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  height: 32,
                ),
                SizedBox(height: 16),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    //to sign out dialogue
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          insetPadding: EdgeInsets.only(
                              left: 16, top: 24, right: 16, bottom: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  12.0)), //this right here
                          child: Container(
                            height: 180.0,
                            width: 328,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 24,
                                ),
                                Text('Are you sure you want to sign out?',
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
                                        BorderRadius.circular(6.0),
                                        side: BorderSide(
                                            color: Color(0xFFFF4128))),
                                    color: Color(0xFFFF4128),
                                    textColor: Colors.white,
                                    child: Text('SIGN OUT',
                                        style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                fontFamily: 'Intern',
                                                fontSize: 14,
                                                fontWeight:
                                                FontWeight.w600))),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      onSignOut();
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
                                        BorderRadius.circular(6.0),
                                        side: BorderSide(
                                            color: Colors.white)),
                                    color: Colors.white,
                                    textColor: Color(0xFF718096),
                                    child: Text('CANCEL',
                                        style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                fontFamily: 'Intern',
                                                fontSize: 14,
                                                fontWeight:
                                                FontWeight.w600))),
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
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FlevaIcons.log_out,
                          color: Color(0xFFCBD5E0),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Sign Out",
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFFFF4128),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  
    split(String s) {}
}

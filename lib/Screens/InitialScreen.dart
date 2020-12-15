import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proapp/Screens/NotSIgnedIn/SignUp/SignUp.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Widgets/loading.dart';
import 'package:proapp/Widgets/themes.dart';
import 'package:proapp/Screens/NotSIgnedIn/Login/LoginMain.dart';

class InitialScreen extends StatefulWidget {
  final AuthService auth;
  final VoidCallback onSignedIn;

  InitialScreen({this.auth, this.onSignedIn});

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  String otp = "";
  bool loading = false;
  Widget showLogo() {
    return Container(
      //Logo
      width: 211,
      height: 60,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
            side: BorderSide(color: Colors.white)),
        color: Colors.white,
        textColor: Colors.black,
        child: loading
            ? Loading()
            : Text(
                'LOGO',
                style: TextStyle(
                    fontFamily: 'Intern',
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primarygreen,
      body: Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            //top: MediaQuery.of(context).size.height / 15
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: _height/10,
              ),
              showLogo(),
              Spacer(),
              Image(
                image: AssetImage('Assets/img/Initial.png'),
              ),
              Spacer(),
              Container(
                //Sign up button
                width: double.infinity,
                height: 46,
                child: FlatButton(
                  splashColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: BorderSide(color: Colors.white),
                  ),
                  color: Colors.white,
                  textColor: primarygreen,
                  child: loading
                      ? Loading()
                      : Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontFamily: 'Intern',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUp()
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: _height/60,),
              Container(
                //Sign up button
                width: double.infinity,
                height: 46,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: BorderSide(color: Colors.white),
                  ),
                  color: primarygreen,
                  textColor: primarygreen,
                  child: loading
                      ? Loading()
                      : Text(
                    'ALREADY A USER? LOGIN',
                    style: TextStyle(
                      fontFamily: 'Intern',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginMain()
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: _height/8,
              ),
            ],
          )),
    );
  }
}

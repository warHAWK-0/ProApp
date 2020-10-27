import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Widgets/loading.dart';
import 'package:proapp/Widgets/themes.dart';

import 'Wrapper.dart';

class initialScreen extends StatefulWidget {
  @override
  _initialScreenState createState() => _initialScreenState();
}

class _initialScreenState extends State<initialScreen> {
  final _formKey = GlobalKey<FormState>();
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
    return Scaffold(
        backgroundColor: primarygreen,
        body: Builder(
          builder: (context) {
            return Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                    padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: MediaQuery.of(context).size.height / 15),
                    width: double.infinity,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          showLogo(),
                          SizedBox(
                            height: 64,
                          ),
                          Image(
                            image: AssetImage('Assets/Initial.png'),
                          ),
                          SizedBox(
                            height: 77,
                          ),
                          Container(
                            //Sign up button
                            width: double.infinity,
                            height: 46,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                side: BorderSide(color: Colors.white),
                              ),
                              color: Colors.white,
                              textColor: primarygreen,
                              child: loading
                                  ? Loading()
                                  : Text(
                                      'GET STARTED',
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
                                    builder: (context) => Wrapper(
                                      auth: new Auth(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
                    )),
              ),
            );
          },
        ));
  }
}

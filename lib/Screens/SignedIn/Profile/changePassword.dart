import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/ToastMessage.dart';
import 'package:proapp/Widgets/loading.dart';
import 'package:proapp/Widgets/themes.dart';

class changePassword extends StatefulWidget {
  @override
  _changePasswordState createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  final _formKey = GlobalKey<FormState>();
  String password = "";
  String error = "";
  bool loading = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text("Change your password",
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500)))),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 24),
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          // password
                          width: double.infinity,
                          child: TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Invalid password' : null,
                            obscureText: !_showPassword,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  child: Icon(
                                    _showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color.fromRGBO(0, 0, 0, 0.45),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide:
                                      BorderSide(color: Color(0xffCBD5E0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide:
                                      BorderSide(color: Color(0xffCBD5E0)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide:
                                      BorderSide(color: Color(0xffCBD5E0)),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(0, 0, 0, 0.45))),
                          ),
                        ),
                        SizedBox(
                          height: 22.0,
                        ),
                        Container(
                          // re-password
                          width: double.infinity,
                          child: TextFormField(
                            validator: (val) => val != password
                                ? 'Password does not match'
                                : null,
                            obscureText: !_showPassword,
                            onChanged: (val) {
                              // setState(() => password = val);
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  child: Icon(
                                    _showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color.fromRGBO(0, 0, 0, 0.45),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide:
                                      BorderSide(color: Color(0xffCBD5E0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide:
                                      BorderSide(color: Color(0xffCBD5E0)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide:
                                      BorderSide(color: Color(0xffCBD5E0)),
                                ),
                                hintText: 'Retype Password',
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(0, 0, 0, 0.45))),
                          ),
                        ),
                        SizedBox(
                          height: 31.0,
                        ),
                        Container(
                          //Sign in button
                          width: double.infinity,
                          height: 46,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                side: BorderSide(color: primarygreen)),
                            color: primarygreen,
                            textColor: Colors.white,
                            child: loading
                                ? Loading()
                                : Text('Save',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          fontFamily: 'Intern',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    )),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                //success
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Done')));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Otp2()),
                                );
                              } else {
                                //empty field the error pop up
                                ToastUtils.showCustomToast(
                                    context, "Error\n...");
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Password Guidelines\n- no of characters\n- A-Z,0-9",
                                  style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromRGBO(0, 0, 0, 0.65))),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            );
          },
        ));
  }
}

class Otp2 extends StatefulWidget {
  @override
  _Otp2State createState() => _Otp2State();
}

class _Otp2State extends State<Otp2> {
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String name = "";
  String password = "";
  String error = "";
  bool loading = false;
  bool _showPassword = false;
  String titleText = "Enter OTP";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:CustomAppBar(
          child: Text(
            titleText,
            style: Heading2(Colors.black,letterSpace: 1.25),
          ),
          backIcon: true,
          elevation: true,
        ),
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 32),
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            'OTP has been sent to your email ID and mobile number',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Intern',
                                    fontSize: 14))),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          //input fields email
                          //height: 46,
                          width: double.infinity,
                          child: TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter OTP' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide:
                                      BorderSide(color: Color(0xffCBD5E0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide:
                                      BorderSide(color: Color(0xffCBD5E0)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(color: Colors.red),
                                ), //for error write code change color to red
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide:
                                      BorderSide(color: Color(0xffCBD5E0)),
                                ),
                                hintText: 'Enter OTP',
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(0, 0, 0, 0.45))),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          children: [
                            Text("  Resend OTP in  ",
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Intern',
                                        fontSize: 14))),
                            InkWell(
                              //forgot password
                              splashColor: Colors.lightBlueAccent,
                              child: Text("30 sec",
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: primarygreen,
                                        fontFamily: 'Intern',
                                        fontSize: 14),
                                  )),
                              onTap: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 32.0),
                        Container(
                          //Sign in button
                          width: double.infinity,
                          height: 46,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                side: BorderSide(color: primarygreen)),
                            color: primarygreen,
                            textColor: Colors.white,
                            child: loading
                                ? Loading()
                                : Text('CONTINUE',
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            fontFamily: 'Intern',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600))),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                //success
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Done')));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Confirmation2()),
                                );
                              } else {
                                //empty field the error pop up
                                ToastUtils.showCustomToast(
                                    context, "Error\nEnter OTP");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          },
        ));
  }
}

class Confirmation2 extends StatefulWidget {
  @override
  _Confirmation2State createState() => _Confirmation2State();
}

class _Confirmation2State extends State<Confirmation2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              'Password Changed!',
              style: Heading1(Colors.black),
            )),
            SizedBox(
              height: 64,
            ),
            Container(
              child: Image.asset("Assets/img/confirmation.png"),
            ),
            SizedBox(
              height: 32.0,
            ),
            Container(
              //Sign in button
              width: double.infinity,
              height: 46,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: BorderSide(color: primarygreen)),
                color: primarygreen,
                textColor: Colors.white,
                child: Text('BACK TO HOME',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontFamily: 'Intern',
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )),
                onPressed: () {
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 3);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

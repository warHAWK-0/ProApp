import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/ToastMessage.dart';
import 'package:proapp/Widgets/loading.dart';
import 'package:proapp/Widgets/themes.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({this.auth});
  final BaseAuth auth;

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  String password = "";
  String error = "";
  bool loading = false;
  bool _showPassword = false;
  String _emailpassword;
  FocusNode focusNode;
  int count = 0;

  void _passwordReset() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print(_emailpassword);
      try {
        await widget.auth.resetPassword(_emailpassword);
        showGeneralDialog(
          context: context,
          barrierDismissible: false,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (BuildContext buildContext, Animation animation,
              Animation secondaryAnimation) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width - 30,
                height: 150,
                margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(45, 55, 72, 0.9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Password Reset Email Sent',
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: RaisedButton(
                        elevation: 0.2,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).popUntil((_) => count++ >= 2);
                        },
                        child: Text("Dismiss"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position:
                  Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
              child: child,
            );
          },
        );
        //Navigator.of(context).pop();
         // AlertDialog(
        //   title: Text("Password Reset Email Sent"),
        // );
        // final snackBar = SnackBar(content: Text("Password Reset Email Sent"));
        // scaffoldKey.currentState.showSnackBar(snackBar);
        //Navigator.of(context).pushNamed('/ForgotPassConfirm');
      } catch (e) {
        // Fluttertoast.showToast(
        //     msg: "Invalid Input!",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        // );
        print(e);
      }
    }
  }

  Widget showEmailInput() {
    return Container(
      //input fields email
      //height: 46,
      width: double.infinity,
      child: TextFormField(
        onSaved: (val) => _emailpassword = val,
        validator: (val) => !val.contains('@') ? "Invalid Email" : null,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: Color(0xffCBD5E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: Color(0xffCBD5E0)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: Colors.red),
            ), //for error write code change color to red
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: Color(0xffCBD5E0)),
            ),
            hintText: 'Email ID',
            hintStyle:
                TextStyle(fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.45))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          child: Text(
            'Change your password',
            style: Heading2(Colors.black,letterSpace: 1.1),
          ),
          elevation: true,
          backIcon: true,
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
                        showEmailInput(),
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
                                : Text(
                                    'Change Password',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          fontFamily: 'Intern',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                            onPressed: () {
                              _passwordReset();
                              //Navigator.of(context).pop();
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
        appBar: CustomAppBar(
          child: Text(
            'Enter OTP',
            style: Heading2(Colors.black,letterSpace: 1.1),
          ),
          elevation: true,
          backIcon: true,
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
            SizedBox(
              height: 80,
            ),
            Center(
                child: Text(
              'Password changed!',
              style: Heading(color: Colors.black,fontSize: 26.0,fontWeight: FontWeight.w500),
            )),
            Spacer(),
            Container(
              child: Image.asset("Assets/img/confirmation.png"),
            ),
            SizedBox(
              height: 48.0,
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
            Spacer(),
          ],
        ),
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/loading.dart';
import 'package:proapp/Widgets/themes.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({@required this.auth});
  final AuthService auth;

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  Future<void> resetPassword(String email) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _emailpassword;
  String error = "";
  bool loading = false;
  String titleText = "Forgot Password";

  void _passwordReset() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print("form saved");
      print(_emailpassword);
      try {
        await widget.auth.resetPassword(_emailpassword);
        print("tried");

        // AlertDialog(
        //   title: Text("Password Reset Email Sent"),
        // );
        // final snackBar = SnackBar(content: Text("Password Reset Email Sent"));
        // scaffoldKey.currentState.showSnackBar(snackBar);
        Navigator.of(context).pushNamed('/ForgotPassConfirm');
        print('conf');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          child: Text(
            titleText,
            style: Heading1(Colors.black),
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
                  padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: MediaQuery.of(context).size.height / 20),
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          //input fields email
                          //height: 46,
                          width: double.infinity,
                          child: TextFormField(
                            onSaved: (val) => _emailpassword = val,
                            validator: (val) =>
                            !val.contains('@') ? "Invalid Email" : null,
                            keyboardType: TextInputType.emailAddress,
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
                                  BorderSide(color: primarygreen),
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
                                hintText: 'Email ID',
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(0, 0, 0, 0.45))),
                          ),
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
                            child: loading
                                ? Loading()
                                : Text(
                              'SEND OTP',
                              style: TextStyle(
                                  fontFamily: 'Intern',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {
                              _passwordReset();
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Back to ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Intern',
                                    fontSize: 14)),
                            InkWell(
                              //forgot password
                              splashColor: Colors.lightBlueAccent,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: primarygreen,
                                    fontFamily: 'Intern',
                                    fontSize: 14),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
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

class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: 16, right: 16, top: MediaQuery.of(context).size.height / 10),
        child: Container(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Password Reset E-mail Sent',
                  style: Heading3(Colors.white),
                ),
              ),
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
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        fontFamily: 'Intern',
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    int count = 0;
                    Navigator.of(context).popUntil((_) => count++ >= 2);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

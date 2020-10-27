import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:proapp/Services/phoneAuth.dart';
import 'package:proapp/Widgets/loading.dart';
import 'package:proapp/Widgets/themes.dart';

import 'CustomAppBar.dart';

class SignUpOTP extends StatefulWidget {
  @override
  _SignUpOTPState createState() => _SignUpOTPState();
}

class _SignUpOTPState extends State<SignUpOTP> {
  final _formKey = GlobalKey<FormState>();
  String smsCode, verificationId;
  bool loading = false;
  bool checkcode;

  Widget showProgressBar() {
    return Container(
      //progess bar
      height: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: LinearProgressIndicator(
          value: 0.75,
          backgroundColor: Colors.grey,
          valueColor: AlwaysStoppedAnimation(Color(0xff20BAA2)),
        ),
      ),
    );
  }

  Widget showotpInput() {
    return Container(
      //input fields for number

      width: double.infinity,
      child: TextFormField(
        validator: (val) => val.isEmpty ? 'Enter OTP' : null,
        onChanged: (val) {
          setState(() {
            this.smsCode = val;
          });
        },
        keyboardType: TextInputType.phone,
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
            hintText: 'Enter OTP',
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
          "Enter OTP",
          //style: blackBoldLargeStyle,
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
                    top: MediaQuery.of(context).size.height / 10),
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      showProgressBar(),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "OTP has been sent to your email id and mobile number",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Intern',
                              letterSpacing: 0.25,
                              fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      showotpInput(),
                      SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Resend OTP in ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Intern',
                                  fontSize: 14)),
                          InkWell(
                            //forgot password
                            splashColor: Colors.lightBlueAccent,
                            child: Text(
                              "30 sec.",
                              style: TextStyle(
                                  color: primarygreen,
                                  fontFamily: 'Intern',
                                  fontSize: 14),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Container(
                        //Sign up button
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
                                  'CONTINUE',
                                  style: TextStyle(
                                      fontFamily: 'Intern',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                          onPressed: () {                
                            PhoneAuth().signInWithOTP(smsCode, verificationId);
                            
                          },
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {};

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}

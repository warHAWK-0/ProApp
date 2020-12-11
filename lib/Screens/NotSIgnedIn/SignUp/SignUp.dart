import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Models/address.dart';
import 'package:proapp/Screens/NotSIgnedIn/Login/LoginMain.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/loading.dart';
import 'package:proapp/Widgets/themes.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final formKey = GlobalKey<FormState>();
  FocusNode f1,f2,f3,f4;
  String _email,_name,_password,_confirmPassword;
  bool _showPassword = false, _showConfirmPassword = false, _isLoading = false;
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          'Sign Up',
          style: Heading2(Colors.black,letterSpace: 1.25),
        ),
        backIcon: false,
        elevation: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: height/30),
          //height: MediaQuery.of(context).size.height-100,
          width: double.infinity,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                showEmailInput(),
                //SizedBox(height: 32,),
                SizedBox(
                  height: 20.0,
                ),
                showNameInput(),
                SizedBox(
                  height: 20.0,
                ),
                showPasswordInput(),
                SizedBox(
                  height: 20.0,
                ),
                showConfirmPasswordInput(),
                SizedBox(
                  height: 40.0,
                ),
                showPrimaryButton(),
                SizedBox(height: 30.0),
                showGoogleSignup(),
                SizedBox(
                  height: 20.0,
                ),
                navToLogin(),
                SizedBox(
                  height: 20,
                ),
                // _showErrorMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Container(
      width: double.infinity,
      child: TextFormField(
        enabled: !_isLoading,
        maxLines: 1,
        autofocus: false,
        onFieldSubmitted: (val) => FocusScope.of(context).requestFocus(f1),
        keyboardType: TextInputType.emailAddress,
        validator: (val) => !val.contains('@') ? "Invalid Email" : null,
        onSaved: (val) => _email = val,
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
            borderSide: BorderSide(color: primarygreen),
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
          //hintStyle: formText,
        ),
      ),
    );
  }

  Widget showNameInput() {
    return Container(
      //input field name
      width: double.infinity,
      child: TextFormField(
        enabled: !_isLoading,
        focusNode: f2,
        validator: (val) => val.length < 1 ? "Invalid Name" : null,
        onSaved: (val) => _name = val,
        onFieldSubmitted: (val) => FocusScope.of(context).requestFocus(f2),
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
            borderSide: BorderSide(color: primarygreen),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.red),
          ), //for error write code change color to red
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Color(0xffCBD5E0)),
          ),
          hintText: 'Name',
          //hintStyle: formText,
        ),
      ),
    );
  }

  Widget showPasswordInput() {
    return Container(
      width: double.infinity,
      child: TextFormField(
        enabled: !_isLoading,
        maxLines: 1,
        autofocus: false,
        validator: (val) => val.length < 6 ? "Password too short" : null,
        obscureText: !_showPassword,
        onChanged: (val) => _password = val,
        onSaved: (val) => _password = val,
        focusNode: f3,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
            child: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
              color: Color.fromRGBO(0, 0, 0, 0.45),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Color(0xffCBD5E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: primarygreen),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Color(0xffCBD5E0)),
          ),
          hintText: 'Password',
          //hintStyle: formText,
        ),
      ),
    );
  }

  Widget showConfirmPasswordInput() {
    return Container(
      width: double.infinity,
      child: TextFormField(
        enabled: !_isLoading,
        maxLines: 1,
        autofocus: false,
        validator: (val) => val.length < 6 ? "Password too short" : null,
        obscureText: !_showConfirmPassword,
        onChanged: (val) => _confirmPassword = val,
        onSaved: (val) => _confirmPassword = val,
        focusNode: f4,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _showConfirmPassword = !_showConfirmPassword;
              });
            },
            child: Icon(
              _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
              color: Color.fromRGBO(0, 0, 0, 0.45),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Color(0xffCBD5E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: primarygreen),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: Color(0xffCBD5E0)),
          ),
          hintText: 'Retype Password',
          //hintStyle: formText,
        ),
      ),
    );
  }

  Widget showPrimaryButton() {
    return _isLoading ? Loading() : Container(
      //Sign in button
      width: double.infinity,
      height: 46,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(color: primarygreen),
        ),
        color: primarygreen,
        textColor: Colors.white,
        child: Text(
          'SIGN UP',
          //style: new TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });

          if(formKey.currentState.validate()){
            // form filled correctly
            formKey.currentState.save();
            try {
              String uid = await auth.createUserWithEmailPassword(_email, _password);
              await auth.sendEmailVerification().then((value) => auth.signOut());

              // creating user in db and initializing values
              await Firestore.instance.collection("UserDetails").document(uid).setData({
                "name":_name,
                "email":_email,
                "mobileNo": "",
                "address": Address(
                  addressline1: "",
                  city: "",
                  state: "",
                  pincode: ""
                ).toJson(),
                "verified" : false
              });

              showGeneralDialog(
                context: context,
                barrierDismissible: true,
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
                            'Verification Mail has been sent to you',
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
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginMain()));
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
            } catch (e) {
              showErrorDialog(context, e.toString());
            }
          }
          setState(() {
            _isLoading = false;
          });
        },
      ),
    );
  }

  Widget showGoogleSignup() {
    return Container(
      //Sign in button
      width: double.infinity,
      height: 46,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
            side: BorderSide(color: Color(0xffCBD5E0))),
        color: Colors.white,
        textColor: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("Assets/icons/Icon.png"),
            Text(
              '  SIGN UP WITH GOOGLE',
              style: TextStyle(
                  fontFamily: 'Intern',
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }

  Widget navToLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          //style: blackSmallStyle
        ),
        InkWell(
          autofocus: false,
          child: Text(
            ' Login',
            style: TextStyle(color: Colors.blue),
          ),
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginMain()));
          },
        ),
      ],
    );
  }

  showErrorDialog(BuildContext context, String err) {
    FocusScope.of(context).requestFocus(new FocusNode());
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
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
                  err,
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
                      Navigator.of(context).pop(context);
                      auth.sendEmailVerification().then(
                            (user) async {
                          auth.signOut();
                        },
                      );
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
  }
}

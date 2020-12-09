import 'package:flutter/material.dart';
import 'package:proapp/Screens/NotSIgnedIn/SignUp/SignUp.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/loading.dart';
import 'package:proapp/Widgets/themes.dart';
import 'package:proapp/Screens/NotSIgnedIn/forgetPass.dart';

class LoginMain extends StatefulWidget {
  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  final formKey = GlobalKey<FormState>();
  FocusNode focusNode;
  String _email, _password;
  bool _showPassword = false, _isLoading = false;
  Auth auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          'Login',
          style: Heading2(Colors.black, letterSpace: 1.25),
        ),
        backIcon: false,
        elevation: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: height / 30),
          width: double.infinity,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                showEmailInput(),
                SizedBox(
                  height: height / 50,
                ),
                showPasswordInput(),
                SizedBox(
                  height: height / 30,
                ),
                showPrimaryButton(),
                SizedBox(
                  height: height / 50,
                ),
                _showForgotPasswordButton(),
                SizedBox(
                  height: height / 50,
                ),
                showGoogleSignup(),
                SizedBox(
                  height: height / 50,
                ),
                navToSignUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Container(
      //input fields email
      //height: 46,
      width: double.infinity,
      child: TextFormField(
        enabled: _isLoading ? false : true,
        maxLines: 1,
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        validator: (val) => !val.contains('@') ? "Invalid Email" : null,
        onSaved: (val) => _email = val,
        onFieldSubmitted: (val) =>
            FocusScope.of(context).requestFocus(focusNode),
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

  Widget showPasswordInput() {
    return Container(
      width: double.infinity,
      child: TextFormField(
        enabled: _isLoading ? false : true,
        maxLines: 1,
        autofocus: false,
        validator: (val) => val.length < 6 ? "Password too short" : null,
        obscureText: !_showPassword,
        onSaved: (val) => _password = val,
        focusNode: focusNode,
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

  Widget showPrimaryButton() {
    return _isLoading
        ? Loading()
        : Container(
            //Sign in button
            width: double.infinity,
            height: 46,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: primarygreen)),
              color: primarygreen,
              textColor: Colors.white,
              child: Text(
                'LOGIN',
                // style: buttonText,
              ),
              onPressed: () async {
            //     dynamic result = await auth.signInWithEmailPassword(
            //     _email, _password);
            // if (result == null) {
            //
            //   setState(() {
            //     Scaffold.of(context).showSnackBar((SnackBar(
            //       content: new Text("Incorrect Email/ Password"),
            //       duration: Duration(seconds: 3),
            //     )));
            //   });
            // } else {
            //   print('logging in');
            // }
            // Navigator.pop(context);
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  setState(() {
                    _isLoading = true;
                  });
                  dynamic result =
                      await auth.signInWithEmailPassword(_email, _password);
                  if (result == null) {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      barrierColor: Colors.black45,
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (BuildContext buildContext,
                          Animation animation, Animation secondaryAnimation) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 30,
                            height: 150,
                            margin: EdgeInsets.only(
                                bottom: 50, left: 12, right: 12),
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
                                  'Incorrect Email/Password.',
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
                              Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                  .animate(anim1),
                          child: child,
                        );
                      },
                    );
                  } else {
                    await auth.isEmailVerified().then((isVerified) async {
                      if (isVerified) {
                        // verified user can log in sucessfully
                        Navigator.pop(context);
                      }
                      else {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: false,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 30,
                                height: MediaQuery.of(context).size.height / 8 <
                                        120
                                    ? 120
                                    : MediaQuery.of(context).size.height / 8,
                                margin: EdgeInsets.only(
                                    bottom: 50, left: 12, right: 12),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(45, 55, 72, 0.9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Email Not Verified!',
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
                                    Spacer(),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            child: RaisedButton(
                                              elevation: 0.2,
                                              color: Colors.white,
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Dismiss"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            child: RaisedButton(
                                              elevation: 0.2,
                                              color: Colors.white,
                                              onPressed: () async {
                                                await auth
                                                    .sendEmailVerification()
                                                    .then((value) =>
                                                        auth.signOut());
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Resend"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          transitionBuilder: (context, anim1, anim2, child) {
                            return SlideTransition(
                              position:
                                  Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                      .animate(anim1),
                              child: child,
                            );
                          },
                        );
                        await Future.delayed(Duration(milliseconds: 1001));
                        await auth.signOut();
                      }
                    });
                  }
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
            ),
          );
  }

  Widget _showForgotPasswordButton() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Forgot password, ",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Intern',
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            InkWell(
              autofocus: false,
              child: Text(
                'reset here',
                style: TextStyle(
                    color: primarygreen,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()));
              },
            ),
          ],
        ),
      ],
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
              '  SIGN IN WITH GOOGLE',
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

  Widget navToSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Intern', fontSize: 14),
        ),
        InkWell(
          autofocus: false,
          child: Text(
            'Sign Up',
            style: TextStyle(color: primarygreen),
          ),
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          },
        ),
      ],
    );
  }
}

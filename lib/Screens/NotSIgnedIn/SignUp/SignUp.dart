import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Screens/NotSIgnedIn/Login/LoginMain.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/themes.dart';
import '../../Wrapper.dart';

class RegistrationPage extends StatefulWidget {
  // RegistrationPage({@required this.auth});
  // final AuthService auth;
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  AuthService auth = new AuthService();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  String _name, _email, _password;
  FocusNode f1, f2, f3;
  String _errorMessage = "";
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    f1 = FocusNode();
    f2 = FocusNode();
    f3 = FocusNode();
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print("Name: $_name Email: $_email Password: $_password");
      _register();
    }
  }

  void _register() async {
    try {
      String uid = await auth.createUserWithEmailPassword(_email, _password);
      print("uid: $uid");
      // creating user in db and initializing values
      await Firestore.instance.collection("UserDetails").document(uid).setData({
        "name":_name,
        "email":_email,
        "phoneNo":"",
        "address":"",
        "profilePicture":""
      });
//      await Firestore.instance.collection("userDetails").document(uid).collection("collectionPath").add(
//          {
//            "name":_name,
//            "email":_email,
//            "phoneNo":"",
//            "address":"",
//            "pinNo":"",
//            "profilePicture":""
//          });

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
                        auth.sendEmailVerification().then(
                              (user) async {
                            auth.signOut();

                            // Fluttertoast.showToast(
                            //     msg: "Verification Email Sent!Verify to Login",
                            //     gravity: ToastGravity.BOTTOM,
                            //     toastLength: Toast.LENGTH_LONG
                            // );

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
    } catch (e) {
      // print(e.code);
      // switch (e.code) {
      //   case 'ERROR_EMAIL_ALREADY_IN_USE':
      //     showErrorDialog(context, "Email Already Exists");
      //     break;
      //   case 'ERROR_INVALID_EMAIL':
      //     showErrorDialog(context, "Invalid Email Address");
      //     break;
      //   case 'ERROR_WEAK_PASSWORD':
      //     showErrorDialog(context, "Please Choose a stronger password");
      //     break;
      // }
      showErrorDialog(context, e.toString());
    }
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

                          // Fluttertoast.showToast(
                          //     msg: "Verification Email Sent!Verify to Login",
                          //     gravity: ToastGravity.BOTTOM,
                          //     toastLength: Toast.LENGTH_LONG
                          // );


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

  // showErrDialog(BuildContext context, String err) {
  //   // to hide the keyboard, if it is still p
  //   FocusScope.of(context).requestFocus(new FocusNode());
  //   return showDialog(
  //     context: context,
  //     child: AlertDialog(
  //       title: Text("Error"),
  //       content: Text(err),
  //       actions: <Widget>[
  //         OutlineButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: Text("Ok"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _showVerifyEmailSentDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        // return object of type Dialog
        return Center(
            child: Container(
              child: Container(
                width: MediaQuery.of(context).size.width - 10,
                height: MediaQuery.of(context).size.height - 80,
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  children: [
                    RaisedButton(
                      onPressed: () {},
                      child: Text("Save"),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget showEmailInput() {
    return Container(
      //input fields email
      //height: 46,
      width: double.infinity,
      child: TextFormField(
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
        focusNode: f1,
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
        focusNode: f3,
        maxLines: 1,
        autofocus: false,
        controller: _pass,
        validator: (val) => val.length < 6 ? "Password too short" : null,
        onSaved: (val) => _password = val,
        obscureText: !_showPassword,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(
                    () {
                  _showPassword = !_showPassword;
                },
              );
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
      // re-password
      width: double.infinity,
      child: TextFormField(
        controller: _confirmPass,
        validator: (val) =>
        val != _pass.text ? 'Password does not match' : null,
        obscureText: !_showConfirmPassword,
        onChanged: (val) {
          // setState(() => password = val);
        },
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
          hintText: 'Confirm Password',
          hintStyle: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(0, 0, 0, 0.45),
          ),
        ),
      ),
    );
  }

  Widget showSecondaryButton() {
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => LoginPage()));
          },
        ),
      ],
    );
  }

  Widget showPrimaryButton() {
    return Container(
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
        onPressed: _submit,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          'Sign Up',
          style: Heading2(Colors.black,letterSpace: 1.25),
        ),
        backIcon: true,
        elevation: false,
      ),
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: MediaQuery.of(context).size.height / 15),
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
                showSecondaryButton(),
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
}

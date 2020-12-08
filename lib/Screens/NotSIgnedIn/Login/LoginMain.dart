import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proapp/Screens/NotSIgnedIn/SignUp/SignUp.dart';
import 'package:proapp/Screens/NotSIgnedIn/forgetPass.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/loading.dart';
import 'package:proapp/Widgets/themes.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool _isLoading = false;
  AnimationController animationController;
  Animation logoanimation;
  String _email, _password, _emailpassword;
  FocusNode focusNode;

  final AuthService authService = AuthService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  bool _showPassword = false;
  bool isEnabled = false;
  void initState() {
    super.initState();
    // animationController = AnimationController(
    //   vsync: null,
    //   duration: Duration(milliseconds: 1500),
    // );
    // logoanimation =
    //     CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    // logoanimation.addListener(() => this.setState(() {}));
    // animationController.forward();
    // focusNode = FocusNode();
  }

  enableButton() {
    setState(() {
      isEnabled = true;
    });
  }

  disableButton() {
    setState(() {
      isEnabled = false;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print("Email: $_email Password: $_password");
      _login();
    }
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    try{
      dynamic result = await authService.signInWithEmailPassword(_email, _password);
      if(result == null){
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
              position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                  .animate(anim1),
              child: child,
            );
          },
        );
      }
      else{
        await authService.isEmailVerified().then((isVerified) async {
          if (isVerified) {
            // verified user can log in sucessfully
          } else {
            //user is not verified
            // ping him to verify again
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
                  position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                      .animate(anim1),
                  child: child,
                );
              },
            );

            await Future.delayed(Duration(milliseconds: 1001));
            await authService.signOut();
          }
        });
      }
    }
    catch(e){
      print(e.toString());
      print(e.runtimeType);
      print(e.hashCode);
    }
    finally{
      setState(() {
        _isLoading = false;
      });
    }

  }

  showErrorDialog(BuildContext context, String err) {
    FocusScope.of(context).requestFocus(new FocusNode());
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
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
                      authService.sendEmailVerification().then(
                            (user) async {
                          authService.signOut();

                          // Fluttertoast.showToast(
                          //     msg: "Verification Email Sent!Verify to Login",
                          //     gravity: ToastGravity.BOTTOM,
                          //     toastLength: Toast.LENGTH_LONG
                          // );

                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             RootPage(auth: widget.auth)),
                          //     (Route<dynamic> route) => false);
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

  void _passwordReset() async {
    final form = formKey1.currentState;
    if (form.validate()) {
      form.save();
      try {
        await authService.resetPassword(_emailpassword);
        Navigator.of(context).pop();
        final snackBar = SnackBar(content: Text("Password Reset Email Sent"));
        scaffoldKey.currentState.showSnackBar(snackBar);
      } catch (e) {
        // Fluttertoast.showToast(
        //     msg: "Invalid Input!",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        // );
        AlertDialog(
          title: Text("Invalid Input"),
        );
      }
    }
  }

  Widget showEmailInput() {
    return Container(
      //input fields email
      //height: 46,
      width: double.infinity,
      child: TextFormField(
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

  showErrDialog(BuildContext context, String err) {
    // to hide the keyboard, if it is still p
    FocusScope.of(context).requestFocus(new FocusNode());
    return showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Error"),
        content: Text(err),
        actions: <Widget>[
          OutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  Widget showPasswordInput() {
    return Container(
      width: double.infinity,
      child: TextFormField(
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
    return _isLoading ? Loading() : Container(
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
        onPressed: _submit,
      ),
    );
  }

  Widget showSecondaryButton() {
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
            Navigator.of(context).push(PageNavigate(auth: authService));
            // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
          },
        ),
      ],
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
                  color: Colors.black, fontFamily: 'Intern', fontSize: 14),
            ),
            InkWell(
              autofocus: false,
              child: Text(
                'reset here',
                style: TextStyle(color: primarygreen),
              ),
              onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPassword(auth: authService,)),
                );
              },
            ),
          ],
        ),
        SizedBox(
          height: 16,
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
              '  SIGN UP WITH GOOGLE',
              style: TextStyle(
                  fontFamily: 'Intern',
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        onPressed: () {
          _signInWithGoogle();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          'Login',
          style: Heading2(Colors.black,letterSpace: 1.25),
        ),
        backIcon: true,
        elevation: false,
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
                  top: MediaQuery.of(context).size.height / 15),
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
                    showPasswordInput(),
                    SizedBox(
                      height: 40.0,
                    ),
                    showPrimaryButton(),
                    SizedBox(height: 30.0),
                    _showForgotPasswordButton(),
                    SizedBox(
                      height: 10,
                    ),
                    showGoogleSignup(),
                    SizedBox(
                      height: 30.0,
                    ),
                    showSecondaryButton(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<FirebaseUser> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final AuthResult authResult =
      await auth.signInWithCredential(authCredential);
      final FirebaseUser user = authResult.user;

      assert(user.email != null);
      assert(user.displayName != null);

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentuser = await auth.currentUser();
      assert(user.uid == currentuser.uid);
      print(user.email);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomePage(),
      //   ),
      // );
    } catch (e) {}
  }
}

class PageNavigate extends CupertinoPageRoute {
  final AuthService auth;
  PageNavigate({this.auth})
      : super(
    builder: (BuildContext context) => RegistrationPage(),
  );
}

FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();
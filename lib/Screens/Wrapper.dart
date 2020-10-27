import 'package:flutter/material.dart';
import 'package:proapp/Screens/NotSIgnedIn/Login/LoginMain.dart';
import 'package:proapp/Screens/SignedIn/HomePage.dart';
import 'package:proapp/Services/authentication.dart';

enum AuthStatus {
  SignedIn,
  NotSignedIn
}

class Wrapper extends StatefulWidget {
  final BaseAuth auth;

  Wrapper({
    @required this.auth
  });

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  AuthStatus authStatus = AuthStatus.NotSignedIn;
  String _userId = "";
  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NotSignedIn : AuthStatus.SignedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.SignedIn;
      widget.auth.currentUser().then((user) {
        _userId = user.uid.toString();
      });
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.NotSignedIn;
      _userId = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NotSignedIn:
        return LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
        break;
      case AuthStatus.SignedIn:
        return HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
        break;
      /*case AuthStatus.NotDetermined:
        return Scaffold(body: Center(child: Text("Hello World"),),);
        break;*/
    }
  }
}

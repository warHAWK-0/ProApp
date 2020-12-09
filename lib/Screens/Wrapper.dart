
import 'package:flutter/material.dart';
import 'package:proapp/Models/user.dart';
import 'package:proapp/Screens/InitialScreen.dart';
import 'package:proapp/Screens/NotSIgnedIn/Login/LoginMain.dart';
import 'package:proapp/Screens/NotSIgnedIn/SignUp/SignUp.dart';
import 'package:proapp/Screens/SignedIn/HomePage.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // return home or authenticate
    if(user == null){
      // return LoginPage();
      return InitialScreen();
    }else{
      return HomePage(uid: user.uid,);
      // return LoggedInPage();
    }
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Auth _auth = new AuthService();
    String email = 'sj.bhatt.000@gmail.com';
    String password = '123456';
    return Scaffold(
      appBar: AppBar(
        title: Text('Login here'),
      ),
      body: Center(
        child: FlatButton(
          child: Text('Login'),
          onPressed: () async{
            dynamic result = await _auth.signInWithEmailPassword(
                email, password);
            if (result == null) {

              setState(() {
                Scaffold.of(context).showSnackBar((SnackBar(
                  content: new Text("Incorrect Email/ Password"),
                  duration: Duration(seconds: 3),
                )));
              });
            } else {
              print('logging in');
            }
          },
        ),
      ),
    );
  }
}

class LoggedInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth _auth = new AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Center(
        child: FlatButton(
          child: Text('Log out'),
          onPressed: () async{
            await _auth.signOut();
          },
        ),
      ),
    );
  }
}



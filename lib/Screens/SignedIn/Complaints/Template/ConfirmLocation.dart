import 'package:flutter/material.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/themes.dart';

class ConfirmLocation extends StatefulWidget {
  @override
  _ConfirmLocationState createState() => _ConfirmLocationState();
}

class _ConfirmLocationState extends State<ConfirmLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          'Confirm Location',
          style: Heading2(Colors.black,letterSpace: 1.0),
        ),
        elevation: true,
        backIcon: true,
      ),
      body: Column(
        children: [
          Text( "If your current location is incorrect, enter your present location"),
        ],
      ),
    );
  }
}

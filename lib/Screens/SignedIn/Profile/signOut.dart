import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

int dialogueExitCode;
Dialog signOutDialog = Dialog(
  insetPadding: EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 16),
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0)), //this right here
  child: Container(
    height: 180.0,
    width: 328,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 24,
        ),
        Text('Are you sure you want to sign out?',
            style: GoogleFonts.inter(
                textStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
        SizedBox(height: 16),
        Container(
          height: 46,
          width: 296,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Color(0xFFFF4128))),
            color: Color(0xFFFF4128),
            textColor: Colors.white,
            child: Text(
              'SIG OUT',
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                    fontFamily: 'Intern',
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 46,
          width: 296,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Colors.white)),
            color: Colors.white,
            textColor: Color(0xFF718096),
            child: Text('CANCEL',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontFamily: 'Intern',
                        fontSize: 14,
                        fontWeight: FontWeight.w600))),
            onPressed: () {
              dialogueExitCode = 0;
            },
          ),
        ),
      ],
    ),
  ),
);

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class complaintCreated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Complaint Created",
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
            ),
            Text(
              "Complaint #208",
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 24,
            ),
            Image.asset("Assets/img/complaintcreated.png"),
            SizedBox(
              height: 32,
            ),
            SpinKitRing(
              color: Color(0xffA0AEC0),
              size: 50.0,
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                //code to navigate
              },
              child: Text(
                "Back to complaints",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: Color(0xffA0AEC0),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

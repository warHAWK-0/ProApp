import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file:///E:/Flutter/proapp/lib/Screens/SignedIn/Feed/PostLayout/readmore.dart';

class PollPost extends StatefulWidget {
  @override
  _TextPostState createState() => _TextPostState();
}

class _TextPostState extends State<PollPost> {
  bool isPressed = false;
  bool isPressed1 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              CircleAvatar(radius: 16,backgroundImage: NetworkImage("https://www.woolha.com/media/2020/03/flutter-circleavatar-minradius-maxradius.jpg") ,),
              SizedBox(width: 10,),
              new Text("Anonymous Name", style: GoogleFonts.inter( letterSpacing: .25,fontSize: 16,
                fontWeight: FontWeight.w400,)),

              SizedBox(width: 135,),
              new Container(
                height: 25,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Color(0xFF189F98),
                ),
                child: Center(
                  child: Text("TAGS", style:GoogleFonts.inter( letterSpacing: 1.5,fontSize: 10,
                      fontWeight: FontWeight.w500, color: Colors.white) ),
                ),
              )


            ],
          ),
          SizedBox(height: 10,),
          ReadMoreText(
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for  will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
            style: GoogleFonts.inter(letterSpacing: .25, fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 0.65)),
            trimLines: 3,
            colorClickableText: Color(0xFF20BAA2),
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Read More',
            trimExpandedText: 'Read less',
          ),
          SizedBox(height: 10,),

          new Text("28th September 2020", textAlign:TextAlign.left ,style: GoogleFonts.inter(letterSpacing: 1, fontSize: 12,fontWeight: FontWeight.w400, color: Color.fromRGBO(0,0,0,0.65))),

          Divider(height: 35,)
        ],
      ),
    );
  }
}

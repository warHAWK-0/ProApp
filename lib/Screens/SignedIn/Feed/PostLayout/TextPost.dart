import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/ExpandedTextImagePost.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/readmore.dart';
import 'package:proapp/Widgets/VoteTemplate.dart';

class TextPost extends StatefulWidget {
  @override
  _TextPostState createState() => _TextPostState();
}

class _TextPostState extends State<TextPost> {
  bool isPressed = false;
  bool isPressed1 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:7),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          new Row(
            children: <Widget>[

              CircleAvatar(radius: 16,backgroundImage: NetworkImage("https://www.woolha.com/media/2020/03/flutter-circleavatar-minradius-maxradius.jpg") ,),
              SizedBox(width: 10,),
              new Text("Anonymous Name", style: GoogleFonts.inter( letterSpacing: .25,fontSize: 16,
                fontWeight: FontWeight.w400,)),

              Spacer(),
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
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for  will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\n',
            style: GoogleFonts.inter(letterSpacing: .25, fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 0.65)),
            trimLines: 3,
            colorClickableText: Color(0xFF20BAA2),
            trimMode: TrimMode.Line,
            trimCollapsedText: '....\nRead More',
            trimExpandedText: 'Read less',
          ),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              // Toggle the up, down button and fill the box
              VoteTemplate(type: VoteType.feed, upvoteCount: 234,downvoteCount: 15,),
              Spacer(),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Postdetails()));
                  },
                  child: Text("View Comments", style: GoogleFonts.inter(letterSpacing: .5, fontSize: 12,fontWeight: FontWeight.w600, color: Color(0XFF20BAA2)))),

            ],
          ),
          SizedBox(height: 10,),

          SizedBox(height: 8,),
          Align(
            alignment: Alignment.centerLeft,
            child: new Text("28th September 2020",
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                    letterSpacing: 1,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(0, 0, 0, 0.65))),
          ),
          Divider(height: 35,)
        ],
      ),
    );
  }
}

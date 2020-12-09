import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/ExpandedTextPost.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/readmore.dart';
import 'package:proapp/Widgets/VoteTemplate.dart';

class TextPost extends StatefulWidget {
  final String description, name, tag, datetime;
  final int upvote, downvote;
  const TextPost({Key key, this.description, this.name, this.tag, this.datetime, this.upvote, this.downvote}) : super(key: key);
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
              new Text(widget.name, style: GoogleFonts.inter( letterSpacing: .25,fontSize: 16,
                fontWeight: FontWeight.w400,)),

              Spacer(),
              new Container(
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Color(0xFF189F98),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right :10),
                  child: Center(
                    child: Text(widget.tag.toUpperCase(), style:GoogleFonts.inter( letterSpacing: 1.5,fontSize: 10,
                        fontWeight: FontWeight.w500, color: Colors.white) ),
                  ),
                ),
              )


            ],
          ),
          SizedBox(height: 10,),

          Align(
            alignment: Alignment.centerLeft,
            child: ReadMoreText(
              widget.description+'\n',
              style: GoogleFonts.inter(letterSpacing: .25, fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 0.65)),
              trimLines: 3,

              colorClickableText: Color(0xFF20BAA2),
              trimMode: TrimMode.Line,
              trimCollapsedText: '....\nRead More',
              trimExpandedText: 'Read less',
            ),
          ),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              // Toggle the up, down button and fill the box
              VoteTemplate(type: VoteType.feed, upvoteCount: widget.upvote,downvoteCount: widget.downvote,),
              Spacer(),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Postdetails(name: widget.name,description: widget.description,upvote: widget.upvote,downvote: widget.downvote,tag: widget.tag,date: widget.datetime,)));
                  },
                  child: Text("View Comments", style: GoogleFonts.inter(letterSpacing: .5, fontSize: 12,fontWeight: FontWeight.w600, color: Color(0XFF20BAA2)))),

            ],
          ),
          SizedBox(height: 10,),

          SizedBox(height: 8,),
          Align(
            alignment: Alignment.centerLeft,
            child: new Text(datetimeformat(widget.datetime),
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


  String datetimeformat(String date){
    String month = date.substring(5,7);
    int m =int.parse(month);
    switch (m) {
      case 1:
        month = "January";
        break;
      case 2:
        month = "February";
        break;
      case 3:
        month = "March";
        break;
      case 4:
        month = "April";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "August";
        break;
      case 9:
        month = "September";
        break;
      case 10:
        month = "October";
        break;
      case 11:
        month = "November";
        break;
      case 12:
        month = "December";
        break;
    }
    return date.substring(8,10) +"th "+month+" "+date.substring(0,4);
  }
}

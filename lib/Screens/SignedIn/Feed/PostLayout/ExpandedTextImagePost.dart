import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/comment.dart';
import 'package:proapp/Widgets/VoteTemplate.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:proapp/Widgets/commentgrab.dart';


class PostdetailsImage extends StatefulWidget {
  final String name, description, tag,datetime,url;
  final int upvote, downvote;

  const PostdetailsImage({Key key, this.name, this.description, this.tag, this.datetime, this.upvote, this.downvote,this.url}) : super(key: key);


  @override
  _PostdetailsImageState createState() => _PostdetailsImageState();
}

class _PostdetailsImageState extends State<PostdetailsImage> {
  bool isPressed = false;
  bool isPressed1 = false;

  _showPostPicture() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Container(
            child: SpinKitChasingDots(
              color: Colors.black,
              size: 24,
            ),
          );
        else {
          return  ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.url,
                fit: BoxFit.fill,
              )
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //title: Center(child: Text("Feed",style: TextStyle(color: Colors.black,),)),
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          color: Color(0xff20BAA2),
          onPressed: () {
            Navigator.pop(context);
            
          },
        ),
      ),
      body: FooterView(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(
                            "https://www.woolha.com/media/2020/03/flutter-circleavatar-minradius-maxradius.jpg"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      new Text(widget.name,
                          style: GoogleFonts.inter(
                            letterSpacing: .25,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
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
                  SizedBox(
                    height: 10,
                  ),
                  _showPostPicture(),
                  SizedBox(
                    height: 10,
                  ),
                  VoteTemplate(type: VoteType.feed, upvoteCount: widget.upvote, downvoteCount: widget.downvote,),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
widget.description+'/n',                    style: GoogleFonts.inter(
                        letterSpacing: .25,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(0, 0, 0, 0.65)),

                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                  Divider(
                    height: 35,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text("Comments",style: GoogleFonts.inter(
                        letterSpacing: 1,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,)),
                    ),
                  ),
                  CommentGrab(),

                ],

              ),

            ),

          ),
        ],
        footer: new Footer(
          child: Padding(
              padding: new EdgeInsets.all(10.0),
              child: Text('I am a Customizable footer!!')
          ),
        ),
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
